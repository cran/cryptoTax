#' Sample data sets provided by adjustedcostbase.ca
#'
#' Data sets from adjustedcostbase.ca to demonstrate adjusted cost base as well as
#' capital gains/losses. Used as demo for our own [ACB()] function.
#'
#' @docType data
#' @format Data frames with 4 variables:
#' \describe{
#'   \item{date}{the date}
#'   \item{transaction}{buy or sell}
#'   \item{quantity}{how much of the stock/coin}
#'   \item{price}{the spot rate, in dollars}
#'   \item{fees}{any transaction fees}
#'   ...
#' }
#' @references 
#' - https://www.adjustedcostbase.ca/blog/how-to-calculate-adjusted-cost-base-acb-and-capital-gains/
#' - https://www.adjustedcostbase.ca/blog/what-is-the-superficial-loss-rule/
"data_adjustedcostbase1"

#' @rdname data_adjustedcostbase1
"data_adjustedcostbase2"

#' @rdname data_adjustedcostbase1
"data_adjustedcostbase3"

#' @rdname data_adjustedcostbase1
"data_adjustedcostbase4"

#' @rdname data_adjustedcostbase1
"data_adjustedcostbase5"

#' @rdname data_adjustedcostbase1
"data_adjustedcostbase6"
