#' @title Format BlockFi file
#'
#' @description Format a .csv transaction history file from BlockFi for later ACB processing.
#' @param data The dataframe
#' @param list.prices A `list.prices` object from which to fetch coin prices.
#' @param force Whether to force recreating `list.prices` even though
#' it already exists (e.g., if you added new coins or new dates).
#' @return A data frame of exchange transactions, formatted for further processing.
#' @export
#' @examples
#' format_blockfi(data_blockfi)
#' @importFrom dplyr %>% rename mutate filter select arrange bind_rows
#' @importFrom rlang .data

format_blockfi <- function(data, list.prices = NULL, force = FALSE) {
  known.transactions <- c(
    "Withdrawal", "BIA Withdraw", "BIA Deposit", "Interest Payment", 
    "Crypto Transfer", "Trade", "Bonus Payment", "Referral Bonus")
  
  # Rename columns
  data <- data %>%
    rename(
      quantity = "Amount",
      currency = "Cryptocurrency",
      description = "Transaction.Type",
      date = "Confirmed.At"
    )
  
  # Check if there's any new transactions
  check_new_transactions(data, 
                         known.transactions = known.transactions,
                         transactions.col = "description")
  
  # Add single dates to dataframe
  data <- data %>%
    mutate(date = lubridate::as_datetime(.data$date))
  # UTC confirmed

  # Create a "buy" object
  BUY <- data %>%
    filter(
      .data$description %in% c(
        "purchase_TEMP",
        "Trade"
      ),
      .data$quantity > 0
    ) %>%
    mutate(transaction = "buy") %>%
    select(
      "date", "quantity", "currency",
      "transaction", "description"
    )

  # Create a "earn" object
  EARN <- data %>%
    filter(.data$description %in% c(
      "Interest Payment",
      "Referral Bonus",
      "Bonus Payment"
    )) %>%
    mutate(
      transaction = "revenue",
      revenue.type = replace(
        .data$description,
        .data$description %in% c("Interest Payment"),
        "interests"
      ),
      revenue.type = replace(
        .data$revenue.type,
        .data$revenue.type %in% c("Referral Bonus"),
        "referrals"
      ),
      revenue.type = replace(
        .data$revenue.type,
        .data$revenue.type %in% c("Bonus Payment"),
        "promos"
      )
    ) %>%
    select(
      "date", "quantity", "currency", "transaction",
      "revenue.type", "description"
    )

  # Create a "sell" object
  SELL <- data %>%
    filter(
      .data$description %in% c(
        "sell_TEMP",
        "Trade"
      ),
      .data$quantity < 0
    ) %>%
    mutate(
      transaction = "sell",
      quantity = abs(.data$quantity)
    ) %>%
    select(
      "date", "quantity", "currency",
      "transaction", "description"
    )

  # Merge the "buy" and "sell" objects
  data <- merge_exchanges(BUY, EARN, SELL) %>%
    mutate(exchange = "blockfi")

  # Determine spot rate and value of coins
  data <- cryptoTax::match_prices(data, list.prices = list.prices, force = force)
  
  if (is.null(data)) {
    message("Could not reach the CoinMarketCap API at this time")
    return(NULL)
  }
  
  if (any(is.na(data$spot.rate))) {
    warning("Could not calculate spot rate. Use `force = TRUE`.")
  }

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
      "description", "revenue.type", "exchange", "rate.source"
    )
  
  # Return result
  data
}
