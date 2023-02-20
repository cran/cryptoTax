#' Sample data sets provided by koinly.io
#'
#' A data set from koinly.io to demonstrate adjusted cost base as well as
#' capital gains/losses. Used as demo for our own [ACB()] function.
#'
#' @docType data
#' @format A data frame with 4 rows and 4 variables:
#' \describe{
#'   \item{date}{the date}
#'   \item{transaction}{buy or sell}
#'   \item{currency}{the coin}
#'   \item{quantity}{how much of the stock/coin}
#'   \item{spot.rate}{the price of the coin}
#'   ...
#' }
#' @source \url{https://koinly.io/blog/calculating-crypto-taxes-canada/}
"data_koinly"
