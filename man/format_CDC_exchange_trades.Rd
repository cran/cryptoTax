% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/format_CDC_exchange_trades.R
\name{format_CDC_exchange_trades}
\alias{format_CDC_exchange_trades}
\title{Format CDC exchange file (FOR TRADES ONLY)}
\usage{
format_CDC_exchange_trades(data, list.prices = NULL, force = FALSE)
}
\arguments{
\item{data}{The dataframe}

\item{list.prices}{A \code{list.prices} object from which to fetch coin prices.}

\item{force}{Whether to force recreating \code{list.prices} even though
it already exists (e.g., if you added new coins or new dates).}
}
\value{
A data frame of exchange transactions, formatted for further processing.
}
\description{
Format a .csv transaction history file from the Crypto.com
exchange for later ACB processing. Only processes trades, not rewards
(see \code{format_CDC_exchange_rewards} for this).
}
\details{
Original file name of the right file from the exchange is
called "SPOT_TRADE.csv", make sure you have the right one. It can
usually be accessed with the following steps: (1) connect to the
CDC exchange. On the left menu, click on "Wallet", and choose the
"Transactions" tab. Pick your desired dates. Unfortunately, the CDC
exchange history export only supports 30 days at a time. So if you
have more than that, you will need to export each file and merge them
manually before you use this function.

As of the new changes to the exchange (3.0) transactions before
November 1st, 2022, one can go instead through the "Archive" button
on the left vertical menu, choose dates (max 100 days), and
download trade transactions. It will be a zip file with several
transaction files inside. Choose the "SPOT_TRADE.csv".

In newer versions of this transaction history file, CDC has added
three disclaimer character lines at the top of the file, which is
messing with the headers. Thus, when reading the file with
\code{read.csv()}, add the argument \code{skip = 3}. You will then be able to
read the file normally.
}
\examples{
format_CDC_exchange_trades(data_CDC_exchange_trades)
}
