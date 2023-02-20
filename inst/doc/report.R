## ----knitr, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(cryptoTax)

## ----list.prices, eval=FALSE--------------------------------------------------
#  library(cryptoTax)
#  
#  my.coins <- c("BTC", "ETH", "ADA", "CRO", "LTC", "USDC", "BUSD", "CEL", "PRE", "ETHW", "BAT")
#  list.prices <- prepare_list_prices(coins = my.coins, start.date = "2021-01-01")
#  

## ----list.prices2-------------------------------------------------------------
library(cryptoTax)

my.coins1 <- c("BTC", "ETH", "ADA", "CRO", "LTC", "USDC")
my.coins2 <- c("BUSD", "CEL", "PRE", "ETHW", "BAT")

list.prices1 <- prepare_list_prices(coins = my.coins1, start.date = "2021-01-01")
list.prices2 <- prepare_list_prices(coins = my.coins2, start.date = "2021-01-01")

list.prices <- rbind(list.prices1, list.prices2)

## ----format exchanges, message=FALSE------------------------------------------
exchanges <- list(
  data_adalite, data_binance, data_binance_withdrawals, data_blockfi, data_CDC, 
  data_CDC_exchange_rewards, data_CDC_exchange_trades, data_CDC_wallet, data_celsius,
  data_coinsmart, data_exodus, data_gemini, data_newton, data_pooltool, data_presearch,
  data_shakepay, data_uphold)

formatted.data <- format_detect(exchanges)

## ----format_ACB---------------------------------------------------------------
formatted.ACB <- format_ACB(formatted.data)

## ----check_missing_transactions-----------------------------------------------
check_missing_transactions(formatted.ACB)

## ----get_latest_transactions--------------------------------------------------
get_latest_transactions(formatted.ACB)

## ----prepare_report, message=FALSE--------------------------------------------
report.info <- prepare_report(formatted.ACB, 
                              tax.year = 2021, 
                              local.timezone = "America/Toronto",
                              list.prices = list.prices)

## ----report.info names--------------------------------------------------------
names(report.info)

## ----print_report, eval = FALSE-----------------------------------------------
#  print_report(tax.year = "2021",
#               name = "Mr. Cryptoltruist",
#               report.info)

## ----report prep, echo=FALSE, message=FALSE, warning=FALSE--------------------
library(dplyr)
tax.year <- "2021"
name <- "Mr. Cryptoltruist"
person.name <- paste("Name:", name)
total.income.numeric <- dplyr::last(report.info$table.revenues$staking) +
  dplyr::last(report.info$table.revenues$interests)
total.income <- format_dollars(total.income.numeric)
total.cost <- report.info$report.summary$Amount[5]
gains <- report.info$report.summary$Amount[2]
gains.numeric <- format_dollars(gains, "numeric")
gains.50 <- format_dollars(gains.numeric * 0.5)
losses <- report.info$report.summary$Amount[3]
net <- report.info$report.summary$Amount[4]
net.numeric <- format_dollars(net, "numeric")
net.50 <- format_dollars(net.numeric * 0.5)
total.tax <- format_dollars(net.numeric * 0.5 + total.income.numeric)
sup.losses.total <- report.info$sup.losses[nrow(report.info$sup.losses), "sup.loss"]
tot.losses <- format_dollars(as.numeric(losses) - sup.losses.total)
tot.sup.loss <- as.numeric(tot.losses) + sup.losses.total
if (tax.year == "all") {
  tax.year <- "all years"
} else {
  tax.year <- tax.year
}


## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = FALSE, fig.width=6.5, fig.height=6.5, 
                      dpi=300, out.width="60%")

## ----summary------------------------------------------------------------------

report.info$report.summary[-1,] %>% 
  tax_table()


## ----values, echo=FALSE-------------------------------------------------------
# ((value.today + net.numeric + revenues) / sum(ACB.list$ACB) - 1) * 100
value <- round(((format_dollars(report.info$report.summary$Amount[6], "numeric") + 
          last(report.info$report.overview$net) + 
          last(report.info$table.revenues$total.revenues)) / 
         last(report.info$report.overview$total.cost) - 1) * 100, 2)

value2 <- round(last(report.info$report.overview$net) + last(
  report.info$report.overview$unrealized.net), 2)


## ----overview-----------------------------------------------------------------

# Attempting to add header rows midway of the table

# report.overview2 <- report.overview

# report.overview2$date.last <- as.character(report.overview2$date.last)

# report.overview2 <- rbind(report.overview2, names(report.overview2))

# Define our new custom function
#add_row2 <- function(.data, x, ...) {
#  add_row(
#    .data, 
#    tibble(!!!setNames(x, names(.data))),
#    ...
#  )
#}

# Add the header row
#report.overview2 %>%
#  mutate(across(everything(),
#                as.character)) %>%
#  add_row2(names(report.overview2),
#           .before = 12) -> temp.table

#temp.table %>%
#  flextable() %>%
#  bold(i = nrow(temp.table)) %>%
#  bold(i = nrow(temp.table)/2+1) %>%
#  bold(part = "header") %>%
#  hline(i = nrow(temp.table)) %>%
#  hline(i = nrow(temp.table)-1) %>%
#  hline(i = nrow(temp.table)/2+1) %>%
#  hline(i = nrow(temp.table)/2) %>%
#  colformat_double(j = "total.quantity", digits = 7)

sub <- report.info$report.overview %>% 
  select(date.last:net, currency2)

# Make table
sub %>% 
  tax_table(type = 2)


## ----current value------------------------------------------------------------

sub2 <- report.info$report.overview %>% 
  select(currency, cost.share, total.cost, rate.today:currency2)

sub2 %>% 
  tax_table(repeat.header = TRUE)


## ----sup loss-----------------------------------------------------------------

report.info$sup.losses %>%
  tax_table(report.info, type = 3)


## ----revenues-----------------------------------------------------------------

report.info$table.revenues %>% 
  tax_table(repeat.header = TRUE)


## ----pie_exchange-------------------------------------------------------------
report.info$pie_exchange

## ----pie_revenue--------------------------------------------------------------
report.info$pie_revenue

## -----------------------------------------------------------------------------

report.info$tax.box %>% 
  tax_table


