#' @title Format a generic transaction file
#'
#' @description Format a generic .csv transaction history file. This
#' function requires one transaction per row, so will not work with
#' trades of two coins reported on the same row. For this you will
#' have to split the trade on two rows and have a single currency
#' column per row.
#' @param data The dataframe
#' @param date The date column
#' @param currency The currency column
#' @param quantity The quantity column
#' @param total.price The total.price column, if available
#' @param spot.rate The spot.rate column, if available
#' @param transaction The transaction column
#' @param fees The fees column, if available
#' @param description The description column, if available
#' @param comment The comment column, if available
#' @param revenue.type The revenue.type column, if available (content can
#' be one of `c("airdrops", "referrals", "staking", "promos", "interests",
#' "rebates", "rewards", "forks", "mining")`)
#' @param exchange The exchange column
#' @param timezone The time zone of the transactions
#' @param list.prices A `list.prices` object from which to fetch coin prices.
#' @param force Whether to force recreating `list.prices` even though
#' it already exists (e.g., if you added new coins or new dates).
#' @return A data frame of exchange transactions, formatted for further processing.
#' @export
#' @examples
#' # Detects correct names even with capitals
#' format_generic(data_generic1)
#'
#' # In other cases, names can be specified explicitly:
#' format_generic(
#'   data_generic2,
#'   date = "Date.Transaction",
#'   currency = "Coin",
#'   quantity = "Amount",
#'   total.price = "Price",
#'   transaction = "Type",
#'   fees = "Fee",
#'   exchange = "Platform"
#' )
#'
#' # If total.price is missing, it will calculate it based
#' # on the spot.rate, if available
#' format_generic(data_generic3)
#'
#' # If both total.price and spot.rate are missing, it will
#' # scrap the spot.rate from coinmarketcap based on the coin:
#' format_generic(data_generic4)
#'
#' @importFrom dplyr %>% rename mutate rowwise filter select bind_rows arrange any_of
#' @importFrom rlang .data

format_generic <- function(data,
                           date = "date",
                           currency = "currency",
                           quantity = "quantity",
                           total.price = "total.price",
                           spot.rate = "spot.rate",
                           transaction = "transaction",
                           fees = "fees",
                           description = "description",
                           comment = "comment",
                           revenue.type = "revenue.type",
                           exchange = "exchange",
                           timezone = "UTC", 
                           force = FALSE,
                           list.prices = NULL) {
  names(data) <- tolower(names(data))

  any_lower <- function(x) {
    any_of(tolower(x))
  }

  # Rename columns
  data <- data %>%
    rename(
      date = any_lower(date),
      currency = any_lower(currency),
      quantity = any_lower(quantity),
      total.price = any_lower(total.price),
      spot.rate = any_lower(spot.rate),
      transaction = any_lower(transaction),
      fees = any_lower(fees),
      description = any_lower(description),
      comment = any_lower(comment),
      revenue.type = any_lower(revenue.type),
      exchange = any_lower(exchange),
      timezone = any_lower(timezone)
    )

  # Add proper dates to dataframe
  data <- data %>%
    mutate(date = lubridate::as_datetime(.data$date, tz = timezone))

  # Add total price
  if (!"total.price" %in% names(data) && "spot.rate" %in% names(data)) {
    data <- data %>%
      mutate(total.price = .data$spot.rate * .data$quantity)
  }

  # Add spot rate
  if (!"spot.rate" %in% names(data) && "total.price" %in% names(data)) {
    data <- data %>%
      mutate(
        spot.rate = .data$total.price / .data$quantity,
        rate.source = "exchange"
      )
  } else if (!"spot.rate" %in% names(data) && !"total.price" %in% names(data) &&
    "currency" %in% names(data)) {
    data <- match_prices(data, list.prices = list.prices, force = force)
    if (is.null(data)) {
      message("Could not reach the CoinMarketCap API at this time")
      return(NULL)
    }
    if (any(is.na(data$spot.rate))) {
      warning("Could not calculate spot rate. Use `force = TRUE`.")
    }
  } else if (!"spot.rate" %in% names(data) && !"total.price" %in% names(data) &&
    !"currency" %in% names(data)) {
    stop("Cannot calculate 'total.price' without 'spot.rate' or 'currency' columns!")
  }

  data <- data %>%
    mutate(total.price = ifelse(is.na(.data$total.price),
      .data$quantity * .data$spot.rate,
      .data$total.price
    ))

  # Change the order of columns
  data <- data %>%
    select(any_of(c(
      "date", "currency", "quantity", "total.price", "spot.rate", "transaction",
      "fees", "description", "comment", "revenue.type", "exchange", "rate.source"
    )))

  # Return result
  data
}
