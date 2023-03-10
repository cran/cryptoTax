% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data_cryptotaxcalculator.R
\docType{data}
\name{data_cryptotaxcalculator1}
\alias{data_cryptotaxcalculator1}
\alias{data_cryptotaxcalculator2}
\title{Sample data sets provided by cryptotaxcalculator.io}
\format{
A data frame with 4 rows and 4 variables:
\describe{
\item{date}{the date}
\item{trade}{type of transaction}
\item{currency}{the coin}
\item{price}{the spot rate, in dollars}
\item{quantity}{how much of the stock/coin}
...
}

An object of class \code{data.frame} with 4 rows and 5 columns.
}
\source{
\url{https://cryptotaxcalculator.io/guides/crypto-tax-canada-cra/}
}
\usage{
data_cryptotaxcalculator1

data_cryptotaxcalculator2
}
\description{
Data sets from cryptotaxcalculator.io to demonstrate adjusted cost base as
well as capital gains/losses. Used as demo for our own \code{\link[=ACB]{ACB()}} function.
}
\keyword{datasets}
