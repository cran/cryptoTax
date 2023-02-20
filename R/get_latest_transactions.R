#' @title Get the date from the latest transactions per exchange
#'
#' @description  Get the date from the latest transactions per exchange
#' @param formatted.ACB The formatted.ACB file
#' @return A data frame with two columns: the name of the exchange as well
#' as the date of the latest transaction.
#' @export
#' @examples
#' all.data <- format_shakepay(data_shakepay)
#' formatted.ACB <- format_ACB(all.data, verbose = FALSE)
#' get_latest_transactions(formatted.ACB)
#' @importFrom dplyr %>% rename mutate select filter bind_rows group_by slice_tail
#' @importFrom rlang .data

get_latest_transactions <- function(formatted.ACB) {
  formatted.ACB %>%
    group_by(.data$exchange) %>%
    filter(date == max(.data$date)) %>%
    slice_tail() %>%
    select("exchange", "date")
}
