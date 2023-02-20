#' @title Format numeric values to dollars
#'
#' @description Format numeric values with comma for thousands separator.
#' Can be converted back from this format to numeric using `to = "numeric"`.
#' @param x The formatted.ACB file
#' @param to What to convert to, with otions `c("character", "numeric")`.
#' @return A value representing dollars, either as a formatted 
#' character string or as a numeric value.
#' @export
#' @examples
#' x <- format_dollars(1010.92)
#' x
#' format_dollars(x, to = "numeric")
#' @importFrom dplyr %>% rename mutate select filter bind_rows group_by slice_tail
#' @importFrom rlang .data

format_dollars <- function(x, to = "character") {
  if (to == "character") {
    formatted.value <- paste0("", formatC(x, format = "f", big.mark = ",", digits = 2))
  } else if (to == "numeric") {
    formatted.value <- as.numeric(gsub(",", "", x))
  }
  formatted.value
}