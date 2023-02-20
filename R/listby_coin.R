#' @title List transactions by coin
#'
#' @description Provides a list of transactions, separated by coin..
#' @param formatted.ACB The dataframe
#' @return A list of formatted data frames, by coin.
#' @export
#' @examples
#' all.data <- format_shakepay(data_shakepay)
#' formatted.ACB <- format_ACB(all.data, verbose = FALSE)
#' listby_coin(formatted.ACB)
#' @importFrom dplyr group_by group_map
#' @importFrom rlang .data

listby_coin <- function(formatted.ACB) {
  gains.group <- formatted.ACB %>%
    group_by(.data$currency) %>%
    group_map(~ as.data.frame(.x), .keep = TRUE) %>%
    stats::setNames(unique(sort(formatted.ACB$currency)))
  gains.group
}
