#' @title Format Celsius file
#'
#' @description Format a .csv transaction history file from Celsius for later ACB processing.
#' @param data The dataframe
#' @return A data frame of exchange transactions, formatted for further processing.
#' @export
#' @examples
#' format_celsius(data_celsius)
#' @importFrom dplyr %>% rename mutate rowwise filter select arrange
#' @importFrom rlang .data

format_celsius <- function(data) {
  known.transactions <- c(
    "Reward", "Transfer", "Withdrawal", "Promo Code Reward", 
    "Referrer Award", "Referred Award")
  
  # Rename columns
  data <- data %>%
    rename(
      quantity = "Coin.amount",
      currency = "Coin.type",
      description = "Transaction.type",
      date = "Date.and.time"
    )
  
  # Check if there's any new transactions
  check_new_transactions(data, 
                         known.transactions = known.transactions,
                         transactions.col = "description")
  
  # Add single dates to dataframe
  data <- data %>%
    mutate(date = lubridate::mdy_hm(.data$date))
  # UTC confirmed

  # Convert USD value to CAD
  data <- data %>%
    cryptoTax::USD2CAD() %>%
    mutate(total.price = .data$USD.Value * .data$CAD.rate)

  # Create a "earn" object
  EARN <- data %>%
    filter(.data$description %in% c(
      "Referred Award",
      "Reward",
      "Promo Code Reward"
    )) %>%
    mutate(
      transaction = "revenue",
      revenue.type = replace(
        .data$description,
        .data$description %in% c("Reward"),
        "interests"
      ),
      revenue.type = replace(
        .data$revenue.type,
        .data$revenue.type %in% c("Referred Award"),
        "referrals"
      ),
      revenue.type = replace(
        .data$revenue.type,
        .data$revenue.type %in% c("Promo Code Reward"),
        "promos"
      ),
      quantity = abs(.data$quantity),
      spot.rate = .data$total.price / .data$quantity
    ) %>%
    select(
      "date", "quantity", "currency", "total.price", "spot.rate",
      "transaction", "revenue.type", "description"
    )

  # Merge the "buy" and "sell" objects
  data <- merge_exchanges(EARN) %>%
    mutate(exchange = "celsius", rate.source = "exchange (USD conversion)")

  # Reorder columns properly
  data <- data %>%
    select(
      "date", "currency", "quantity", "total.price", "spot.rate", "transaction", 
      "description", "revenue.type", "exchange", "rate.source"
    )
  
  # Return result
  data
}
