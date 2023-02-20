#' @title Format Adalite wallet file
#'
#' @description Format a .csv transaction history file from the Adalite 
#' wallet for later ACB processing.
#' @param data The dataframe
#' @param list.prices A `list.prices` object from which to fetch coin prices.
#' @param force Whether to force recreating `list.prices` even though
#' it already exists (e.g., if you added new coins or new dates).
#' @return A data frame of exchange transactions, formatted for further processing.
#' @export
#' @examples
#' data <- data_adalite
#' format_adalite(data)
#' @importFrom dplyr %>% rename mutate select filter bind_rows
#' @importFrom rlang .data

format_adalite <- function(data, list.prices = NULL, force = FALSE) {
  known.transactions <- c("Reward awarded", "Received", "Sent")
  
  # Rename columns
  data <- data %>%
    rename(
      quantity = "Received.amount",
      currency = "Received.currency",
      description = "Type",
      date = "Date"
    )

  # Check if there's any new transactions
  check_new_transactions(data, 
                         known.transactions = known.transactions,
                         transactions.col = "description")
  
  # Add single dates to dataframe
  data <- data %>%
    mutate(date = lubridate::mdy_hm(.data$date))
  # UTC confirmed

  # Add currency to missing places
  data <- data %>%
    mutate(currency = ifelse(.data$currency == "",
      .data$Sent.currency,
      .data$currency
    ))

  # Create a "earn" object
  EARN <- data %>%
    filter(.data$description %in% c("Reward awarded")) %>%
    mutate(
      transaction = "revenue",
      revenue.type = replace(
        .data$description,
        .data$description %in% c("Reward awarded"),
        "staking"
      )
    ) %>%
    select(
      "date", "quantity", "currency", "transaction",
      "revenue.type", "description"
    )

  # Create a "withdrawals" object
  WITHDRAWALS <- data %>%
    filter(.data$description == "Sent") %>%
    mutate(
      quantity = .data$Fee.amount,
      transaction = "sell",
      comment = "Withdrawal Fee"
    ) %>%
    select(
      "date", "quantity", "currency", "transaction",
      "description", "comment"
    )

  # Merge the "buy" and "sell" objects
  data <- merge_exchanges(EARN, WITHDRAWALS) %>%
    mutate(exchange = "adalite")

  # Determine spot rate and value of coins
  data <- match_prices(data, list.prices = list.prices, force = force)

  if (any(is.na(data$spot.rate))) {
    warning("Could not calculate spot rate. Use `force = TRUE`.")
  }
  
  data <- data %>%
    mutate(total.price = ifelse(is.na(.data$total.price),
      .data$quantity * .data$spot.rate,
      .data$total.price
    ))

  # Actually correct network fees sold for zero!
  # data <- data %>%
  #  mutate(total.price = ifelse(description == "Sent",
  #                              0,
  #                              total.price))

  # Reorder columns properly
  data <- data %>%
    select(
      "date", "currency", "quantity", "total.price", "spot.rate", "transaction", 
      "description", "comment", "revenue.type", "exchange", "rate.source"
    )
  
  # Return result
  data
}
