#' @title Format Newton file
#'
#' @description Format a .csv transaction history file from Newton for later ACB
#' processing. When downloading from Newton, please choose the yearly reports
#' format (the "CoinTracker Version" and "Koinly Version" are not supported
#' at this time). If you have multiple years, that means you might have to
#' merge the two datasets.
#' @param data The dataframe
#' @param filetype Which Newton file format to use, one of c("yearly",
#' "cointracker", or "koinly"). Only "yearly" (default) supported at this time.
#' @return A data frame of exchange transactions, formatted for further processing.
#' @export
#' @examples
#' format_newton(data_newton)
#' @importFrom dplyr %>% rename mutate rowwise filter select bind_rows arrange
#' @importFrom rlang .data

format_newton <- function(data, filetype = "yearly") {
  known.transactions <- c("WITHDRAWN", "TRADE", "DEPOSIT")
  
  # Rename columns
  data <- data %>%
    rename(
      description = "Type",
      date = "Date"
    )
  
  # Check if there's any new transactions
  check_new_transactions(data, 
                         known.transactions = known.transactions,
                         transactions.col = "description")

  # Add single dates to dataframe
  data <- data %>%
    mutate(
      date = lubridate::mdy_hms(.data$date, tz = "America/New_York"),
      date = lubridate::with_tz(.data$date, tz = "UTC")
    )
  # UTC confirmed (original time = "America/New_York"))

  # Create a "buy" object
  BUY <- data %>%
    filter(.data$description == "TRADE") %>%
    rename(
      quantity = "Received.Quantity",
      currency = "Received.Currency",
      total.price = "Sent.Quantity"
    ) %>%
    mutate(
      transaction = "buy",
      spot.rate = .data$total.price / .data$quantity
    ) %>%
    select(
      "date", "quantity", "currency", "total.price", "spot.rate",
      "transaction", "description"
    ) %>%
    filter(.data$currency != "CAD")

  # Create a "sell" object
  SELL <- data %>%
    filter(.data$description == "TRADE") %>%
    rename(
      quantity = "Sent.Quantity",
      currency = "Sent.Currency",
      total.price = "Received.Quantity"
    ) %>%
    mutate(
      transaction = "sell",
      spot.rate = .data$total.price / .data$quantity
    ) %>%
    select(
      "date", "quantity", "currency", "total.price", "spot.rate",
      "transaction", "description"
    ) %>%
    filter(.data$currency != "CAD")

  # Create a "earn" object
  EARN <- data %>%
    filter(.data$Fee.Amount %in% c("Referral Program")) %>%
    mutate(
      quantity = .data$Received.Quantity,
      currency = .data$Received.Currency,
      total.price = .data$Received.Quantity,
      description = .data$Fee.Amount,
      transaction = "revenue",
      revenue.type = replace(
        .data$description,
        .data$description %in% c("Referral Program"),
        "referrals"
      ),
      spot.rate = ifelse(.data$currency == "CAD", 1, NA)
    ) %>%
    select(
      "date", "quantity", "currency", "total.price", "spot.rate",
      "transaction", "revenue.type", "description"
    )

  EARN$description <- as.character(EARN$description)

  # Merge the "buy" and "sell" objects
  data <- merge_exchanges(BUY, SELL, EARN) %>%
    mutate(exchange = "newton", rate.source = "exchange")

  # Reorder columns properly
  data <- data %>%
    select(
      "date", "currency", "quantity", "total.price", "spot.rate", "transaction", 
      "description", "revenue.type", "exchange", "rate.source"
    )
  
  # Return result
  data
}
