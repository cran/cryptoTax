#' Sample data sets of fictive generic transaction history files
#'
#' Fictive generic data sets to demonstrate [format_generic()].
#'
#' @docType data
#' @format A data frame with 3 rows and 6-8 variables:
#' \describe{
#'   \item{Date}{the date}
#'   \item{Currency}{the currency}
#'   \item{Quantity}{quantity}
#'   \item{Spot.Rate}{the spot rate, in dollars}
#'   \item{Total.Price}{the cost of the transaction}
#'   \item{Transaction}{the type of transaction}
#'   \item{Fees}{the transaction fees}
#'   \item{Exchange}{the exchange}
#'   ...
#' }
"data_generic1"

#' @rdname data_generic1
"data_generic2"

#' @rdname data_generic1
"data_generic3"

#' @rdname data_generic1
"data_generic4"