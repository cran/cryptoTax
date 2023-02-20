#' Sample data set of a fictive Uphold transaction history file
#'
#' A fictive Uphold data set to demonstrate [format_uphold()].
#'
#' @docType data
#' @format A data frame with 10 rows and 12 variables:
#' \describe{
#'   \item{Date}{the date}
#'   \item{Destination}{destination}
#'   \item{Destination.Amount}{destination amount}
#'   \item{Destination.Currency}{destination currency}
#'   \item{Fee.Amount}{fee amount}
#'   \item{Fee.Currency}{fee currency}
#'   \item{Id}{transaction id}
#'   \item{Origin}{origin}
#'   \item{Origin.Amount}{origin amount}
#'   \item{Origin.Currency}{origin currency}
#'   \item{Status}{transaction status}
#'   \item{Type}{transaction type}
#'   ...
#' }
#' @source \url{https://uphold.com/}
"data_uphold"
