#' @title Format CDC wallet file
#'
#' @description Format a .csv transaction history file from the Crypto.com DeFi
#' wallet for later ACB processing.
#'
#' One way to download the CRO staking rewards data from the blockchain is to
#' visit http://crypto.barkisoft.de/ and input your CRO address. Keep the default
#' export option ("Koinly"). It will output a CSV file with your transactions.
#' Note: the site does not use a secure connection: use at your own risks.
#' The file is semi-column separated; when using `read.csv`, add the `sep = ";"`
#' argument.
#'
#' @param data The dataframe
#' @param list.prices A `list.prices` object from which to fetch coin prices.
#' @param force Whether to force recreating `list.prices` even though
#' it already exists (e.g., if you added new coins or new dates).
#' @return A data frame of exchange transactions, formatted for further processing.
#' @export
#' @examples
#' format_CDC_wallet(data_CDC_wallet)
#' @importFrom dplyr %>% rename mutate filter select arrange bind_rows mutate_at
#' @importFrom rlang .data

format_CDC_wallet <- function(data, list.prices = NULL, force = FALSE) {
  known.transactions <- c("", "cost", "Reward")
  
  # Rename columns
  data <- data %>%
    rename(
      quantity = "Received.Amount",
      currency = "Received.Currency",
      description = "Label",
      comment = "Description",
      date = "Date"
    )
  
  # Check if there's any new transactions
  check_new_transactions(data, 
                         known.transactions = known.transactions,
                         transactions.col = "description")

  # Add single dates to dataframe
  data <- data %>%
    mutate(date = lubridate::as_datetime(.data$date))
  # UTC confirmed

  # Add description to deposits and withdrawals
  data <- data %>%
    mutate(
      description = ifelse(grepl("Incoming", .data$comment),
        "Deposit",
        ifelse(grepl("Outgoing", .data$comment),
          "Withdrawal",
          .data$description
        )
      ),
      currency = ifelse(.data$Sent.Currency != "",
        .data$Sent.Currency,
        .data$currency
      ),
      quantity = ifelse(!is.na(.data$Sent.Amount),
        .data$Sent.Amount,
        .data$quantity
      )
    )

  # Create a "earn" object
  EARN <- data %>%
    filter(.data$description %in% c("Reward")) %>%
    mutate(
      transaction = "revenue",
      revenue.type = "staking"
    ) %>%
    select(
      "date", "quantity", "currency", "transaction",
      "revenue.type", "description", "comment"
    )

  # Create a "withdrawals" object
  WITHDRAWALS <- data %>%
    filter(.data$description == "Withdrawal") %>%
    mutate(
      quantity = .data$Fee.Amount,
      transaction = "sell"
    ) %>%
    select(
      "date", "quantity", "currency", "transaction",
      "description", "comment"
    )

  # Actually withdrawal fees should be like "selling at zero", so correct total.price
  # WITHDRAWALS <- WITHDRAWALS %>%
  #  mutate(total.price = 0)

  # Merge the "buy" and "sell" objects
  data <- merge_exchanges(EARN, WITHDRAWALS) %>%
    mutate(exchange = "CDC.wallet")

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
  
  # Reorder columns properly
  data <- data %>%
    select(
      "date", "currency", "quantity", "total.price", "spot.rate", "transaction", 
      "description", "comment", "revenue.type", "exchange", "rate.source"
    )
  
  # Return result
  data
}
