#' @title Get superficial loss amounts
#'
#' @description Get superficial loss amounts
#' @param formatted.ACB The dataframe `formatted.ACB`,
#' @param tax.year which year
#' @param local.timezone which time zone
#' @return A data frame, with the following columns: currency, sup.loss.
#' @export
#' @examples
#' all.data <- format_shakepay(data_shakepay)
#' formatted.ACB <- format_ACB(all.data, verbose = FALSE)
#' get_sup_losses(formatted.ACB, 2021)
#' @importFrom dplyr mutate %>% filter summarize add_row across
#' @importFrom rlang .data

get_sup_losses <- function(formatted.ACB, tax.year, local.timezone = Sys.timezone()) {
  formatted.ACB.year <- formatted.ACB %>%
    mutate(datetime.local = lubridate::with_tz(.data$date, tz = local.timezone)) %>%
    filter(lubridate::year(.data$datetime.local) == tax.year)
  formatted.ACB.year %>%
    summarize(sup.loss = sum(.data$gains.sup, na.rm = TRUE)) %>%
    filter(.data$sup.loss != 0) %>% 
    add_row(currency = "Total",
            summarize(., across("sup.loss", sum))) %>%
    as.data.frame() %>%
    mutate(sup.loss = round(.data$sup.loss, 2))
}
