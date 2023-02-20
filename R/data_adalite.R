#' Sample data set of a fictive Adalite transaction history file
#'
#' A fictive Adalite data set to demonstrate [format_adalite()].
#'
#' @docType data
#' @format A data frame with 10 rows and 11 variables:
#' \describe{
#'   \item{Date}{the date}
#'   \item{Transaction.ID}{transaction ID}
#'   \item{Type}{transaction type}
#'   \item{Received.from..disclaimer..may.not.be.accurate...first.sender.address.only.}{address the coins were received from}
#'   \item{Received.amount}{received amount}
#'   \item{Received.currency}{received currency}
#'   \item{Sent.amount}{sent amount}
#'   \item{Sent.currency}{sent currency}
#'   \item{Fee.amount}{fee amount}
#'   \item{Fee.currency}{fee currency}
#'   \item{X}{not used}
#'   ...
#' }
#' @source \url{https://adalite.io/}
"data_adalite"
