#' @title Format Gemini file
#'
#' @description Format a .csv transaction history file from Gemini for later ACB processing.
#' @param data The dataframe
#' @param list.prices A `list.prices` object from which to fetch coin prices.
#' @param force Whether to force recreating `list.prices` even though
#' it already exists (e.g., if you added new coins or new dates).
#' @return A data frame of exchange transactions, formatted for further processing.
#' @export
#' @examples
#' format_gemini(data_gemini)
#' @importFrom dplyr %>% slice rename mutate rowwise filter select bind_rows
#' arrange transmute n contains full_join
#' @importFrom rlang .data

format_gemini <- function(data, list.prices = NULL, force = FALSE) {
  known.transactions <- c("Credit", "Sell", "Buy", "Debit")
  
  # Remove last summary row
  data <- data %>%
    slice(1:n() - 1)
  
  # Rename columns
  data <- data %>%
    rename(
      description = "Type",
      comment = "Specification",
      date = "Date"
    )
  
  # Check if there's any new transactions
  check_new_transactions(data, 
                         known.transactions = known.transactions,
                         transactions.col = "description",
                         description.col = "comment")

  # Add single dates to dataframe
  data <- data %>%
    mutate(date = lubridate::as_datetime(.data$date))
  # UTC confirmed

  # Pivot from wide to long
  amount <- data %>%
    select("date", "description":"comment", contains("Amount")) %>%
    mutate(nrow = 1:n()) %>%
    tidyr::pivot_longer(-c("nrow", "date", "description":"comment"),
      names_to = "currency",
      values_to = "value",
      values_drop_na = FALSE
    ) %>%
    tidyr::separate(.data$currency, c(NA, "Type", "currency")) %>%
    tidyr::pivot_wider(
      names_from = "Type",
      values_from = "value"
    )

  fee <- data %>%
    select("date", "description":"comment", contains("Fee (")) %>%
    mutate(nrow = 1:n()) %>%
    tidyr::pivot_longer(-c("nrow", "date", "description":"comment"),
      names_to = "currency",
      values_to = "value",
      values_drop_na = FALSE
    ) %>%
    tidyr::separate(.data$currency, c("Type", NA, "currency")) %>%
    tidyr::pivot_wider(
      names_from = "Type",
      values_from = "value"
    )

  balance <- data %>%
    select("date", "description":"comment", contains("Balance")) %>%
    mutate(nrow = 1:n()) %>%
    tidyr::pivot_longer(-c("nrow", "date", "description":"comment"),
      names_to = "currency",
      values_to = "value",
      values_drop_na = FALSE
    ) %>%
    tidyr::separate(.data$currency, c(NA, "Type", "currency")) %>%
    tidyr::pivot_wider(
      names_from = "Type",
      values_from = "value"
    )

  full <- Reduce(
    function(dtf1, dtf2) {
      full_join(
        dtf1, dtf2,
        by = c(
          "date", "currency", "description",
          "Symbol", "comment", "nrow"
        )
      )
    },
    list(amount, fee, balance)
  )

  full2 <- full %>%
    filter(!is.na(.data$Amount))

  data <- full2 %>%
    rename(quantity = "Amount")

  # Create a "buy" object
  BUY <- data %>%
    filter(
      .data$description %in% c(
        "Buy",
        "Sell"
      ),
      .data$quantity > 0
    ) %>%
    mutate(
      transaction = "buy",
      description = .data$Symbol
    ) %>%
    select(
      "date", "quantity", "currency", "transaction",
      "Fee", "description", "comment"
    )

  # Create a "earn" object
  EARN <- data %>%
    filter(.data$comment %in% c("Administrative Credit")) %>%
    mutate(
      transaction = "revenue",
      revenue.type = replace(
        .data$comment,
        .data$comment %in% c("Administrative Credit"),
        "referrals"
      )
    ) %>%
    select(
      "date", "quantity", "currency", "transaction",
      "revenue.type", "description", "comment"
    )

  # Create a second "earn" object
  EARN2 <- data %>%
    filter(.data$comment == "Deposit" & .data$currency == "BAT") %>%
    mutate(
      transaction = "revenue",
      revenue.type = "airdrops"
    ) %>%
    select(
      "date", "quantity", "currency", "transaction",
      "revenue.type", "description", "comment"
    )

  # Create a "sell" object
  SELL <- data %>%
    filter(
      .data$description %in% c(
        "Buy",
        "Sell"
      ),
      .data$quantity < 0
    ) %>%
    mutate(
      transaction = "sell",
      description = .data$Symbol,
      quantity = abs(.data$quantity)
    ) %>%
    select(
      "date", "quantity", "currency", "transaction",
      "Fee", "description", "comment"
    )

  # Merge the "buy" and "sell" objects
  data <- merge_exchanges(BUY, EARN, EARN2, SELL) %>%
    mutate(exchange = "gemini")

  # Rename Fee column and make it positive.
  data <- data %>%
    rename(fees = "Fee") %>%
    mutate(fees = .data$fees * -1)

  # Determine spot rate and value of coins
  data <- cryptoTax::match_prices(data, list.prices = list.prices, force = force)

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
      "fees", "description", "comment", "revenue.type", "exchange", "rate.source"
    ) %>% 
    as.data.frame()
  
  # Return result
  data
}
