#' @title Prepare info for full crypto tax report
#'
#' @description Prepare all required information for a full crypto tax report.
#' @param formatted.ACB The `formatted.ACB` object.
#' @param tax.year The tax year desired.
#' @param local.timezone Which time zone to use for the date of the report.
#' @param list.prices A `list.prices` object from which to fetch coin prices.
#' @return A list, containing the following objects: report.overview, 
#' report.summary, proceeds, sup.losses, table.revenues, tax.box, 
#' pie_exchange, pie_revenue.
#' @export
#' @examples
#' list.prices <- prepare_list_prices(coins = "BTC", start.date = "2021-01-01")
#' all.data <- format_shakepay(data_shakepay)
#' formatted.ACB <- format_ACB(all.data, verbose = FALSE)
#' x <- prepare_report(formatted.ACB, list.prices = list.prices)
#' x$proceeds

prepare_report <- function(formatted.ACB, 
                           tax.year = "all", 
                           local.timezone = Sys.timezone(), 
                           list.prices = NULL) {
  report.overview <- report_overview(
    formatted.ACB, today.data = TRUE, tax.year = tax.year, 
    local.timezone = local.timezone, list.prices = list.prices)
  report.summary <- report_summary(
    formatted.ACB, today.data = TRUE, tax.year = tax.year, 
    local.timezone = local.timezone, list.prices = list.prices)
  proceeds <- get_proceeds(formatted.ACB, tax.year = tax.year)
  sup.losses <- get_sup_losses(formatted.ACB, tax.year)
  table.revenues <- report_revenues(formatted.ACB, tax.year = tax.year)
  tax.box <- tax_box(report.summary, sup.losses, table.revenues, proceeds)
  pie_exchange <- crypto_pie(table.revenues)
  pie_revenue <- crypto_pie(table.revenues, by = "revenue.type")
  report.info <- dplyr::lst(report.overview, report.summary, proceeds, sup.losses, table.revenues, 
                            tax.box, pie_exchange, pie_revenue)
  report.info
}
