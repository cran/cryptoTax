#' @title Format ADA rewards from blockchain CSV
#'
#' @description Format a .csv transaction history file from the Cardano PoolTool for later ACB processing. Instructions: Use https://pooltool.io/ click on "rewards data for taxes", search your ADA address, scroll to the bottom of the page, and use the export tool to export all transactions. Make sure to use the "Generic(CSV)" format.
#' @details This is necessary e.g., if you used the Exodus wallet which does not report
#' ADA rewards in its transaction history file.
#' @param data The dataframe
#' @return A data frame of exchange transactions, formatted for further processing.
#' @export
#' @examples
#' format_pooltool(data_pooltool)
#' @importFrom dplyr %>% rename mutate rowwise filter select bind_rows arrange
#' @importFrom rlang .data

format_pooltool <- function(data) {
  # There are no transaction types at all for this file type
  
  # Rename columns
  data <- data %>%
    rename(
      quantity = "stake_rewards",
      total.price = "stake_rewards_value",
      spot.rate = "rate",
      date = "date" # used to be "\\u00ef..date" ....
    )
  # Have to find a way to remove that special character, "ï" (solution = use "\\u00ef")

  # Add single dates to dataframe
  data <- data %>%
    mutate(date = lubridate::ymd_hms(.data$date))
  # Time zone (-04:00) being converted to UTC automatically confirmed

  # Add currency to missing places
  data <- data %>%
    mutate(
      local.currency = .data$currency,
      currency = "ADA",
      transaction = "revenue",
      revenue.type = "staking",
      rate.source = "pooltool",
      description = paste0("epoch = ", .data$epoch),
      comment = paste0("pool = ", .data$pool)
    )

  # Put fees to zero and add exchange
  data <- merge_exchanges(data) %>%
    mutate(exchange = "exodus")
  
  # Select and reorder correct columns
  data <- data %>%
    select(
      "date", "currency", "quantity", "total.price",
      "spot.rate", "transaction", "description", "comment",
      "revenue.type", "exchange", "rate.source"
    )
  
  # Return result
  data
}
