#' @title Format Binance earn file
#'
#' @description Format a .csv earn history file from Binance for later
#' ACB processing.
#' @details To get this file. Download your overall transaction report
#' (this will include your trades, rewards, & "Referral Kickback" rewards).
#' To get this file, connect to your Binance account on desktop, click
#' "Wallet" (top right), "Transaction History", then in the top-right,
#' "Generate all statements". For "Time", choose "Customized" and pick
#' your time frame.
#'
#' Warning: This does NOT process WITHDRAWALS (see the
#' `format_binance_withdrawals()` function for this purpose).
#' @param data The dataframe
#' @param list.prices A `list.prices` object from which to fetch coin prices.
#' @param force Whether to force recreating `list.prices` even though
#' it already exists (e.g., if you added new coins or new dates).
#' @return A data frame of exchange transactions, formatted for further processing.
#' @export
#' @examples
#' \donttest{
#' format_binance(data_binance)
#' }
#' @importFrom dplyr %>% rename mutate across select arrange bind_rows desc
#' @importFrom rlang .data

format_binance <- function(data, list.prices = NULL, force = FALSE) {
  known.transactions <- c(
    "Deposit", "Withdraw", "Buy", "Fee", "Referral Kickback", "Sell", 
    "Simple Earn Flexible Interest", "Distribution", "Stablecoins Auto-Conversion")
  
  # Rename columns
  data <- data %>%
    rename(
      currency = "Coin",
      quantity = "Change",
      date = "UTC_Time",
      description = "Operation",
      comment = "Account"
    )
  
  # Check if there's any new transactions
  check_new_transactions(data, 
                         known.transactions = known.transactions,
                         transactions.col = "description")
  
  # Add single dates to dataframe
  data <- data %>%
    mutate(date = lubridate::as_datetime(.data$date))
  # UTC confirmed

  # Remove withdrawals since those are treated separately
  # Because this file does not provide exact withdrawal fees
  # We also don't need deposits
  data <- data %>%
    filter(!.data$description %in% c("Withdraw", "Deposit"))

  # Label buys and sells properly
  data <- data %>%
    mutate(
      transaction = case_when(
        .data$description %in% c(
          "Buy", "Sell", "Fee", "Stablecoins Auto-Conversion"
        ) &
          quantity > 0 ~ "buy",
        .data$description %in% c(
          "Buy", "Sell", "Fee", "Stablecoins Auto-Conversion"
        ) &
          .data$quantity < 0 ~ "sell"
      ),
      quantity = abs(.data$quantity)
    )

  # Determine spot rate and value of coins
  data <- cryptoTax::match_prices(data, list.prices = list.prices, force = force)

  if (any(is.na(data$spot.rate))) {
    warning("Could not calculate spot rate. Use `force = TRUE`.")
  }
  
  data <- data %>%
    mutate(
      total.price = ifelse(is.na(.data$total.price),
        .data$quantity * .data$spot.rate,
        .data$total.price
      )
    ) %>%
    arrange(.data$date, desc(.data$total.price))

  # Match buys and sells (because these are coin-to-coin exchanges,
  # total.price of buys should overwrite that of sells)
  # Extract fees
  FEES <- data %>%
    filter(.data$description == "Fee")
  
  BUY <- data %>%
    filter(.data$transaction == "buy")
  
  # "Stablecoins Auto-Conversion"
  CONVERSIONS.BUY <- BUY %>%
    filter(.data$description == "Stablecoins Auto-Conversion")
  
  BUY <- BUY %>%
    filter(.data$description != "Stablecoins Auto-Conversion") %>%
    mutate(fees = FEES$total.price)
  
  # Sells
  SELL <- data %>%
    filter(.data$transaction == "sell") %>%
    filter(.data$description != "Fee")
  
  # "Stablecoins Auto-Conversion"
  CONVERSIONS.SELL <- SELL %>%
    filter(.data$description == "Stablecoins Auto-Conversion")
  
  SELL <- SELL %>%
    filter(.data$description != "Stablecoins Auto-Conversion") %>%
    mutate(
      total.price = BUY$total.price,
      spot.rate = .data$total.price / .data$quantity,
      rate.source = "coinmarketcap (buy price)"
    )
  
  # Process revenues
  EARN <- data %>%
    filter(grepl("Interest", .data$description) |
             grepl("Referral", .data$description) |
             grepl("Distribution", .data$description)) %>%
    mutate(
      transaction = "revenue",
      revenue.type = case_when(
        grepl("Interest", .data$description) ~ "interests",
        grepl("Referral", .data$description) ~ "rebates",
        grepl("Distribution", .data$description) ~ "forks"
      )
    )
  
  # Merge the "buy" and "sell" objects
  data <- bind_rows(BUY, SELL, EARN, CONVERSIONS.BUY, CONVERSIONS.SELL) %>%
    mutate(exchange = "binance") %>%
    arrange(date, desc(.data$total.price), .data$transaction) %>%
    select(
      "date", "currency", "quantity", "total.price", "spot.rate", "transaction", 
      "fees", "description", "comment", "revenue.type", "exchange", "rate.source"
    )

  # Return result
  data
}
