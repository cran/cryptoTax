#' @title Get Fair Market Value (FMV) of transactions
#'
#' @description Matches prices obtained through the `prepare_list_prices()`
#' function with the transaction data frame.
#' @param data The dataframe
#' @param my.coins Your coins to match
#' @param start.date What date to start reporting prices for.
#' @param list.prices A `list.prices` object from which to fetch coin prices.
#' @param force Whether to force recreating `list.prices` even though
#' it already exists (e.g., if you added new coins or new dates).
#' @return A data frame, with the following added columns: spot.rate.
#' @export
#' @examples
#' data <- format_shakepay(data_shakepay)[c(1:2)]
#' match_prices(data)
#' @importFrom dplyr %>% rename mutate rowwise filter select bind_rows left_join arrange
#' @importFrom utils timestamp
#' @importFrom rlang .data

match_prices <- function(data, my.coins = NULL, start.date = "2021-01-01", list.prices = NULL, force = FALSE) {
  check_internet()
  
  all.data <- data

  # Create an empty spot.rate if missing else the function won't work
  if (!("spot.rate" %in% names(all.data))) {
    all.data$spot.rate <- NA
  }

  # Same for total.price
  if (!("total.price" %in% names(all.data))) {
    all.data$total.price <- NA
  }

  # Same for rate.source
  if (!("rate.source" %in% names(all.data))) {
    all.data$rate.source <- NA
  }

  # Add spot.rate of 1 for TCAD
  all.data <- all.data %>%
    mutate(spot.rate = ifelse(.data$currency == "TCAD", 1, .data$spot.rate))

  # Apply the prepare_list_prices function to all the coins
  if (is.null(list.prices)) {
    if (is.null(my.coins)) {
      my.coins <- unique(data$currency)
    }
    
    if (is.null(start.date)) {
      start.date <- min(data$date)
    }
    
    list.prices <- prepare_list_prices(coins = my.coins, start.date = start.date, force = force)
    list.prices <<- list.prices
  }

  # Get date in proper format for matching and merge data
  new.data <- all.data %>%
    mutate(date2 = lubridate::as_date(.data$date)) %>%
    left_join(list.prices[c("currency", "spot.rate2", "date2")], by = c("date2", "currency"))

  # Add source of spot.rate and total.price
  new.data <- new.data %>%
    mutate(
      rate.source = ifelse(is.na(.data$spot.rate),
        "coinmarketcap",
        ifelse(is.na(.data$rate.source),
          "exchange",
          .data$rate.source
        )
      ),
      spot.rate = ifelse(is.na(.data$spot.rate), .data$spot.rate2, .data$spot.rate),
      # total.price = ifelse(is.na(total.price),
      #                      quantity * spot.rate,
      #                      total.price)
    ) %>%
    select(-c("date2", "spot.rate2"))
  new.data
}

