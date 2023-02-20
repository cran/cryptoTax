#' @title Format Shakepay file
#'
#' @description Format a .csv transaction history file from Shakepay for later ACB processing.
#' @param data The dataframe
#' @return A data frame of exchange transactions, formatted for further processing.
#' @export
#' @examples
#' formatted.shakepay <- format_shakepay(data_shakepay)
#' formatted.shakepay
#' @importFrom dplyr %>% rename mutate rowwise filter select bind_rows arrange
#' @importFrom rlang .data

format_shakepay <- function(data) {
  known.transactions <- c(
    "shakingsats", "fiat funding", "purchase/sale", "other", "crypto cashout")
  
  # Rename columns
  data <- data %>%
    rename(
      description = "Transaction.Type",
      comment = "Direction",
      spot.rate = "Spot.Rate",
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

  # Create a "buy" object
  BUY <- data %>%
    filter(.data$description == "purchase/sale") %>%
    rename(
      quantity = "Amount.Credited",
      currency = "Credit.Currency",
      total.price = "Amount.Debited"
    ) %>%
    mutate(
      transaction = "buy",
      spot.rate = .data$total.price / .data$quantity
    ) %>%
    select(
      "date", "quantity", "currency", "total.price", "spot.rate",
      "transaction", "description", "comment"
    ) %>%
    filter(.data$currency != "CAD")

  # Create a "SHAKES" object
  SHAKES <- data %>%
    filter(.data$description == "shakingsats") %>%
    rename(
      quantity = "Amount.Credited",
      currency = "Credit.Currency"
    ) %>%
    mutate(
      total.price = .data$quantity * .data$spot.rate,
      transaction = "revenue",
      revenue.type = replace(
        .data$description,
        .data$description %in% c("shakingsats"),
        "airdrops"
      )
    ) %>%
    select(
      "date", "quantity", "currency", "total.price",
      "spot.rate", "transaction", "revenue.type",
      "description", "comment"
    )

  # Create a "REFERRAL" object
  REFERRAL <- data %>%
    filter(.data$description == "other" & comment == "credit") %>%
    rename(
      quantity = "Amount.Credited",
      currency = "Credit.Currency"
    ) %>%
    mutate(
      transaction = "revenue",
      revenue.type = "referrals",
      spot.rate = 1,
      total.price = .data$quantity * .data$spot.rate,
    ) %>%
    select(
      "date", "quantity", "currency", "total.price",
      "spot.rate", "transaction", "revenue.type",
      "description", "comment"
    )

  # Create a "sell" object
  SELL <- data %>%
    filter(.data$description == "purchase/sale") %>%
    rename(
      quantity = "Amount.Debited",
      currency = "Debit.Currency",
      total.price = "Amount.Credited"
    ) %>%
    mutate(
      transaction = "sell",
      spot.rate = .data$total.price / .data$quantity
    ) %>%
    select(
      "date", "quantity", "currency", "total.price",
      "spot.rate", "transaction", "description", "comment"
    ) %>%
    filter(.data$currency != "CAD")

  # Merge the "buy" and "sell" objects
  data <- bind_rows(BUY, SHAKES, REFERRAL, SELL) %>%
    mutate(
      exchange = "shakepay",
      rate.source = "exchange"
    ) %>%
    arrange(date)
  
  # Reorder columns properly
  data <- data %>%
    select(
      "date", "currency", "quantity", "total.price", "spot.rate", "transaction", 
      "description", "comment", "revenue.type", "exchange", "rate.source"
    )

  # Return result
  data
}
