% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/report_summary.R
\name{report_summary}
\alias{report_summary}
\title{Summary of gains and losses}
\usage{
report_summary(
  formatted.ACB,
  today.data = TRUE,
  tax.year = "all",
  local.timezone = Sys.timezone(),
  list.prices = NULL,
  force = FALSE
)
}
\arguments{
\item{formatted.ACB}{The formatted ACB data.}

\item{today.data}{whether to fetch today's data.}

\item{tax.year}{Which tax year(s) to include.}

\item{local.timezone}{Which time zone to use for the date of the report.}

\item{list.prices}{A \code{list.prices} object from which to fetch coin prices.}

\item{force}{Whether to force recreating \code{list.prices} even though
it already exists (e.g., if you added new coins or new dates).}
}
\value{
A summary data frame, containing at least the following columns:
Type, Amount, currency.
}
\description{
Provides a summary of realized capital gains and losses (and total).
}
\examples{
all.data <- format_shakepay(data_shakepay)
formatted.ACB <- format_ACB(all.data, verbose = FALSE)
report_summary(formatted.ACB, today.data = FALSE)
}
