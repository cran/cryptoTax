#' @title Print full crypto tax report
#'
#' @description Will output a full crypto tax report in HTML format, which can then be printed or saved as PDF.
#' @param tax.year The tax year desired.
#' @param name Name of the individual for the report.
#' @param report.info The report info obtained from `prepare_report()`.
#' @return An HTML page containing a crypto tax report.
#' @export
#' @examples
#' \donttest{
#' list.prices <- prepare_list_prices(coins = "BTC", start.date = "2021-01-01")
#' all.data <- format_shakepay(data_shakepay)
#' formatted.ACB <- format_ACB(all.data, verbose = FALSE)
#' report.info <- prepare_report(formatted.ACB, 2021, list.prices = list.prices)
#' print_report(2021, "Mr. Cryptoltruist", report.info)
#' }
#' \dontshow{
#' unlink("full_report.html")
#' }
#'
print_report <- function(tax.year, name, report.info) {
  rlang::check_installed(c("flextable", "rmarkdown"),
    reason = "for this function."
  )
  person.name <- paste("Name:", name)
  total.income.numeric <- dplyr::last(report.info$table.revenues$staking) +
    dplyr::last(report.info$table.revenues$interests)
  total.income <- format_dollars(total.income.numeric)
  total.cost <- report.info$report.summary$Amount[5]
  gains <- report.info$report.summary$Amount[2]
  gains.numeric <- format_dollars(gains, "numeric")
  gains.50 <- format_dollars(gains.numeric * 0.5)
  losses <- report.info$report.summary$Amount[3]
  net <- report.info$report.summary$Amount[4]
  net.numeric <- format_dollars(net, "numeric")
  net.50 <- format_dollars(net.numeric * 0.5)
  total.tax <- format_dollars(net.numeric * 0.5 + total.income.numeric)
  sup.losses.total <- report.info$sup.losses[nrow(report.info$sup.losses), "sup.loss"]
  tot.losses <- format_dollars(as.numeric(losses) - sup.losses.total)
  tot.sup.loss <- as.numeric(tot.losses) + sup.losses.total
  if (tax.year == "all") {
    tax.year <- "all years"
  } else {
    tax.year <- tax.year
  }
  rmarkdown::render(system.file("full_report.Rmd", package = "cryptoTax"),
    output_dir = getwd()
  )
  if (interactive()) {
    rstudioapi::viewer("full_report.html")
  }
}
