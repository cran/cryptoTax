# https://www.data_adjustedcostbase/blog/what-is-the-superficial-loss-rule/
# https://www.data_adjustedcostbase/blog/applying-the-superficial-loss-rule-for-a-partial-disposition-of-shares/

test_that("Example #0 - ACB", {
  expect_snapshot(ACB(data_adjustedcostbase1, spot.rate = "price", sup.loss = FALSE))
})

test_that("Example #1 - ACB", {
  expect_snapshot(ACB(data_adjustedcostbase2, spot.rate = "price", sup.loss = FALSE))
  expect_snapshot(ACB(data_adjustedcostbase2, spot.rate = "price"))
})

test_that("Example #2 - ACB", {
  expect_snapshot(ACB(data_adjustedcostbase3, spot.rate = "price", sup.loss = FALSE))
  expect_snapshot(ACB(data_adjustedcostbase3, spot.rate = "price"))
})

test_that("Example #3 - ACB", {
  expect_snapshot(ACB(data_adjustedcostbase4, spot.rate = "price", sup.loss = FALSE))
  expect_snapshot(ACB(data_adjustedcostbase4, spot.rate = "price"))
})

test_that("Example #4 - ACB", {
  expect_snapshot(ACB(data_adjustedcostbase5, spot.rate = "price", sup.loss = FALSE))
  expect_snapshot(ACB(data_adjustedcostbase5, spot.rate = "price"))
})

test_that("Example #5 - ACB", {
  expect_snapshot(ACB(data_adjustedcostbase6, spot.rate = "price", sup.loss = FALSE))
  expect_snapshot(ACB(data_adjustedcostbase6, spot.rate = "price"))
})

test_that("Example #6 - CryptoTaxCalculator", {
  expect_snapshot(ACB(data_cryptotaxcalculator1, transaction = "trade", 
                      spot.rate = "price", sup.loss = FALSE))
  expect_snapshot(ACB(data_cryptotaxcalculator1, transaction = "trade", 
                      spot.rate = "price"))
})

test_that("Example #7 - CryptoTaxCalculator", {
  expect_snapshot(ACB(data_cryptotaxcalculator2, transaction = "trade", 
                      spot.rate = "price", sup.loss = FALSE))
  expect_snapshot(ACB(data_cryptotaxcalculator2, transaction = "trade", 
                      spot.rate = "price"))
})

test_that("Example #8 - Coinpanda", {
  expect_snapshot(ACB(data_coinpanda1, transaction = "type", quantity = "amount",
                      total.price = "price", sup.loss = FALSE))
})

test_that("Example #9 - Coinpanda", {
  expect_snapshot(ACB(data_coinpanda2, transaction = "type", quantity = "amount",
                      total.price = "price", sup.loss = FALSE))
  expect_snapshot(ACB(data_coinpanda2, transaction = "type", quantity = "amount", 
                      total.price = "price"))
})

test_that("Example #10 - Koinly", {
  expect_snapshot(ACB(data_koinly, sup.loss = FALSE))
  expect_snapshot(ACB(data_koinly))
})

