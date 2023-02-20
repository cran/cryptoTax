#' Sample data set of a fictive Shakepay transaction history file
#'
#' A fictive Shakepay data set to demonstrate [format_shakepay()].
#'
#' @docType data
#' @format A data frame with 10 rows and 11 variables:
#' \describe{
#'   \item{Transaction.Type}{transaction type}
#'   \item{Date}{the date}
#'   \item{Amount.Debited}{amount debited}
#'   \item{Debit.Currency}{debit currency}
#'   \item{Amount.Credited}{amount credited}
#'   \item{Credit.Currency}{credit currency}
#'   \item{Buy...Sell.Rate}{"spot rate" of the trade}
#'   \item{Direction}{purchase, sale, or credit}
#'   \item{Spot.Rate}{actual spot rate for shakestats}
#'   \item{Source...Destination}{withdrawal address}
#'   \item{Blockchain.Transaction.ID}{blockchain transaction number}
#'   ...
#' }
#' @source \url{https://shakepay.com/}
"data_shakepay"
