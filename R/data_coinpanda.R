#' Sample data sets provided by coinpanda.io
#'
#' Data sets from coinpanda.io to demonstrate adjusted cost base as well as
#' capital gains/losses. Used as demo for our own [ACB()] function.
#'
#' @docType data
#' @format A data frame with 4 rows and 6 variables:
#' \describe{
#'   \item{type}{type of transaction}
#'   \item{date}{the date}
#'   \item{currency}{the coin}
#'   \item{amount}{quantity}
#'   \item{price}{the total.price}
#'   \item{fees}{any transaction fees}
#'   ...
#' }
#' @source \url{https://coinpanda.io/blog/crypto-taxes-canada-adjusted-cost-base/}
"data_coinpanda1"

#' @rdname data_coinpanda1
"data_coinpanda2"
