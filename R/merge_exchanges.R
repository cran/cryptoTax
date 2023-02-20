#' @title List transactions by coin
#'
#' @description Provides a list of transactions, separated by coin..
#' @param ... To pass the other exchanges to be merged.
#' @return A data frame, with rows binded and arranged, of the provided 
#' data frames.
#' @export
#' @examples
#' shakepay <- format_shakepay(data_shakepay)
#' newton <- format_newton(data_newton)
#' merge_exchanges(shakepay, newton)
#' @importFrom dplyr %>% bind_rows arrange

merge_exchanges <- function(...) {
  bind_rows(...) %>% arrange(date)
}
