#' Sample data set of a fictive Binance withdrawals transaction history file
#'
#' A fictive withdrawals Binance data set to demonstrate [format_binance_withdrawals()].
#'
#' @docType data
#' @format A data frame with 3 rows and 10 variables:
#' \describe{
#'   \item{Date(UTC)}{the date}
#'   \item{Coin}{currency}
#'   \item{Network}{network type}
#'   \item{Amount}{quantity}
#'   \item{TransactionFee}{transaction fee}
#'   \item{Address}{destination address}
#'   \item{TXID}{transaction ID}
#'   \item{SourceAddress}{source address}
#'   \item{PaymentID}{payment ID}
#'   \item{Status}{status}
#'   ...
#' }
#' @source \url{https://www.binance.com/}
"data_binance_withdrawals"
