#' Sample data set of a fictive Crypto.com transaction history file
#'
#' A fictive Crypto.com data set to demonstrate [format_CDC()].
#'
#' @docType data
#' @format A data frame with 19 rows and 11 variables:
#' \describe{
#'   \item{Timestamp..UTC.}{the date}
#'   \item{Transaction.Description}{transaction description}
#'   \item{Currency}{the currency}
#'   \item{Amount}{quantity}
#'   \item{To.Currency}{currency of the other traded coin}
#'   \item{To.Amount}{quantity of the other traded coin}
#'   \item{Native.Currency}{usually CAD}
#'   \item{Native.Amount}{equivalent value in CAD}
#'   \item{Native.Amount..in.USD.}{equivalent value in USD}
#'   \item{Transaction.Kind}{Specific transaction identifier}
#'   \item{Transaction.Hash}{blockchain address when withdrawing}
#'   ...
#' }
#' @source \url{https://crypto.com/}
"data_CDC"
