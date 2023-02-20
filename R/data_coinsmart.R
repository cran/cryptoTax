#' Sample data set of a fictive CoinSmart transaction history file
#'
#' A fictive CoinSmart data set to demonstrate [format_coinsmart()].
#'
#' @docType data
#' @format A data frame with 8 rows and 7 variables:
#' \describe{
#'   \item{Credit}{amount added}
#'   \item{Debit}{amount removed}
#'   \item{TransactionType}{transaction type}
#'   \item{ReferenceType}{description}
#'   \item{Product}{the currency}
#'   \item{Balance}{the current balance}
#'   \item{TimeStamp}{the date}
#'   ...
#' }
#' @source \url{https://www.coinsmart.com/}
"data_coinsmart"
