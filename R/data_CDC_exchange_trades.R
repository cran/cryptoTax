#' Sample data set of a fictive Crypto.com exchange trades transaction history file
#'
#' A fictive Crypto.com exchange trades data set to demonstrate [format_CDC_exchange_trades()].
#'
#' @docType data
#' @format A data frame with 7 rows and 10 variables:
#' \describe{
#'   \item{Order.ID}{order id}
#'   \item{Trade.ID}{trade id}
#'   \item{Time..UTC.}{the date}
#'   \item{Symbol}{trade pair}
#'   \item{Side}{buyer or seller side}
#'   \item{Trade.Price}{trade price}
#'   \item{Trade.Amount}{trade quantity}
#'   \item{Volume.of.Business}{volume of business}
#'   \item{Fee}{fee}
#'   \item{Fee.Currency}{fee currency}
#'   ...
#' }
#' @source \url{https://crypto.com/exchange/}
"data_CDC_exchange_trades"
