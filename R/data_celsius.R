#' Sample data set of a fictive Celsius transaction history file
#'
#' A fictive Celsius data set to demonstrate [format_celsius()].
#'
#' @docType data
#' @format A data frame with 12 rows and 9 variables:
#' \describe{
#'   \item{Internal.id}{internal id}
#'   \item{Date.and.time}{the date}
#'   \item{Transaction.type}{transaction type}
#'   \item{Coin.type}{coin type}
#'   \item{Coin.amount}{quantity}
#'   \item{USD.Value}{value in USD}
#'   \item{Original.Reward.Coin}{original reward coin}
#'   \item{Reward.Amount.In.Original.Coin}{reward amount in original coin}
#'   \item{Confirmed}{status of transaction}
#'   ...
#' }
#' @source \url{https://celsius.network/}
"data_celsius"
