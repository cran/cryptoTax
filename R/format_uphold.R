#' @title Format Uphold file
#'
#' @description Format a .csv transaction history file from Uphold for later ACB processing.
#' @param data The dataframe
#' @param list.prices A `list.prices` object from which to fetch coin prices.
#' @param force Whether to force recreating `list.prices` even though
#' it already exists (e.g., if you added new coins or new dates).
#' @return A data frame of exchange transactions, formatted for further processing.
#' @export
#' @examples
#' format_uphold(data_uphold)
#' @importFrom dplyr %>% rename mutate rowwise filter select bind_rows arrange
#' @importFrom rlang .data

format_uphold <- function(data, list.prices = NULL, force = FALSE) {
  known.transactions <- c("in", "out", "transfer")
  
  # Rename columns
  data <- data %>%
    rename(
      quantity = "Destination.Amount",
      currency = "Destination.Currency",
      description = "Type",
      date = "Date"
    )
  
  # Check if there's any new transactions
  check_new_transactions(data, 
                         known.transactions = known.transactions,
                         transactions.col = "description")

  # Add single dates to dataframe
  data <- data %>%
    mutate(date = lubridate::mdy_hms(.data$date))
  # UTC confirmed

  # Create a "buy" object
  BUY <- data %>%
    filter(.data$description %in% c(
      "purchase_TEMP",
      "transfer"
    )) %>%
    mutate(
      transaction = "buy",
      comment = paste0(.data$Origin.Currency, "-", .data$currency)
    ) %>%
    select(
      "date", "quantity", "currency",
      "transaction", "description", "comment"
    )

  # Create a "earn" object
  EARN <- data %>%
    filter(.data$description %in% c("in")) %>%
    mutate(
      transaction = "revenue",
      revenue.type = replace(
        .data$description,
        .data$description %in% c("in"),
        "airdrops"
      )
    ) %>%
    select(
      "date", "quantity", "currency", "transaction",
      "revenue.type", "description"
    )

  # Create a "sell" object
  SELL <- data %>%
    filter(.data$description %in% c(
      "sell_TEMP",
      "transfer"
    )) %>%
    mutate(
      transaction = "sell",
      comment = paste0(.data$Origin.Currency, "-", .data$currency),
      quantity = .data$Origin.Amount,
      currency = .data$Origin.Currency
    ) %>%
    select(
      "date", "quantity", "currency",
      "transaction", "description", "comment"
    )

  # Create a "withdrawals" object
  WITHDRAWALS <- data %>%
    filter(.data$description == "out") %>%
    mutate(
      quantity = .data$Fee.Amount,
      transaction = "sell",
      comment = "withdrawal fees"
    ) %>%
    select(
      "date", "quantity", "currency", "transaction",
      "description", "comment"
    )

  # Actually withdrawal fees should be like "selling at zero", so correct total.price
  # WITHDRAWALS <- WITHDRAWALS %>%
  #  mutate(total.price = 0)

  # Merge the "buy" and "sell" objects
  data <- merge_exchanges(BUY, EARN, SELL, WITHDRAWALS) %>%
    mutate(exchange = "uphold")

  # Rename transfers as trades for clarity
  data <- data %>%
    mutate(description = ifelse(.data$description == "transfer",
      "trade",
      .data$description
    ))

  # Determine spot rate and value of coins
  data <- match_prices(data, list.prices = list.prices, force = force)

  data <- data %>%
    mutate(total.price = ifelse(is.na(.data$total.price),
      .data$quantity * .data$spot.rate,
      .data$total.price
    ))

  # CORRECT SPOT RATE FOR COIN TO COIN TRANSACTIONS [for sales]
  # Replace total.price first, then in a second step spot.rate

  coin.prices <- data %>%
    filter(.data$transaction %in% c("buy")) %>%
    mutate(transaction = "sell")

  # Recreate the SELL object because we need the calculated total prices
  SELL <- data %>%
    filter(.data$transaction %in% c("sell"))

  # These are the prices I want to replace
  SELL[which(SELL$date %in% coin.prices$date), "total.price"]

  # These are the correct prices
  coin.prices[which(coin.prices$date %in% SELL$date), "total.price"]

  # Let's replace them
  SELL[which(SELL$date %in% coin.prices$date), "total.price"] <- coin.prices[which(
    coin.prices$date %in% SELL$date
  ), "total.price"]

  # Now let's recalculate spot.rate
  SELL <- SELL %>%
    mutate(spot.rate = .data$total.price / .data$quantity)

  # Let's also replace the rate.source for these transactions
  SELL[which(SELL$date %in% coin.prices$date), "rate.source"] <- "coinmarketcap (buy price)"

  # Replace these transactions in the main dataframe
  data[which(data$transaction == "sell"), ] <- SELL
  
  # Arrange in correct order
  data <- data %>% 
    arrange(date, desc(.data$total.price))
  
  # Reorder columns properly
  data <- data %>%
    select(
      "date", "currency", "quantity", "total.price", "spot.rate", "transaction", 
      "description", "comment", "revenue.type", "exchange", "rate.source"
    )
  
  # Return result
  data
}
