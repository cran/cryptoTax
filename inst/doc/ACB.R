## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(cryptoTax)
data <- data_adjustedcostbase1
data

## -----------------------------------------------------------------------------
ACB(data, spot.rate = "price", sup.loss = FALSE)

## -----------------------------------------------------------------------------
data <- data_adjustedcostbase2
ACB(data, spot.rate = "price", sup.loss = FALSE)

## ---- message=FALSE-----------------------------------------------------------
library(dplyr)
ACB(data, spot.rate = "price") %>%
  select(date, transaction, quantity, price, total.quantity, ACB, ACB.share, gains)

## -----------------------------------------------------------------------------
data <- data_adjustedcostbase3
ACB(data, spot.rate = "price", sup.loss = FALSE)

## -----------------------------------------------------------------------------
ACB(data, spot.rate = "price") %>%
  select(date, transaction, quantity, price, total.quantity, ACB, ACB.share, gains)

## -----------------------------------------------------------------------------
data <- data_adjustedcostbase4
ACB(data, spot.rate = "price", sup.loss = FALSE)

## -----------------------------------------------------------------------------
ACB(data, spot.rate = "price") %>%
  select(date, transaction, quantity, price, total.quantity, ACB, ACB.share, gains)

## -----------------------------------------------------------------------------
data <- data_adjustedcostbase5
ACB(data, spot.rate = "price", sup.loss = FALSE)

## -----------------------------------------------------------------------------
ACB(data, spot.rate = "price") %>%
  select(date, transaction, quantity, price, total.quantity, ACB, ACB.share, gains)

## -----------------------------------------------------------------------------
data <- data_adjustedcostbase6
ACB(data, spot.rate = "price", sup.loss = FALSE)

## -----------------------------------------------------------------------------
ACB(data, spot.rate = "price") %>%
  select(
    date, transaction, quantity, price, total.quantity,
    suploss.range, sup.loss, sup.loss.quantity, ACB, ACB.share,
    gains.uncorrected, gains.sup, gains.excess, gains
  )

## -----------------------------------------------------------------------------
data <- data_cryptotaxcalculator1
ACB(data, transaction = "trade", spot.rate = "price", sup.loss = FALSE)

## -----------------------------------------------------------------------------
ACB(data, transaction = "trade", spot.rate = "price") %>%
  select(date, trade, price, quantity, total.quantity, ACB, ACB.share, gains)

## -----------------------------------------------------------------------------
data <- data_cryptotaxcalculator2
ACB(data, transaction = "trade", spot.rate = "price", sup.loss = FALSE)

## -----------------------------------------------------------------------------
ACB(data, transaction = "trade", spot.rate = "price") %>%
  select(date, trade, price, quantity, total.quantity, ACB, ACB.share, gains)

## -----------------------------------------------------------------------------
data <- data_coinpanda1
ACB(data,
  transaction = "type", quantity = "amount",
  total.price = "price", sup.loss = FALSE
)

## -----------------------------------------------------------------------------
data <- data_coinpanda2
ACB(data,
  transaction = "type", quantity = "amount",
  total.price = "price", sup.loss = FALSE
)

## -----------------------------------------------------------------------------
ACB(data, transaction = "type", quantity = "amount", total.price = "price") %>%
  select(type, date, amount, price, fees, ACB, ACB.share, gains)

## -----------------------------------------------------------------------------
data <- data_koinly
ACB(data, sup.loss = FALSE)

## -----------------------------------------------------------------------------
ACB(data) %>%
  select(date, transaction, quantity, spot.rate, total.quantity, ACB, ACB.share, gains)

