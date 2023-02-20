options(scipen = 999)

# Prepare list of coins ####
my.coins1 <- c("BTC", "ETH", "ADA", "CRO", "LTC", "USDC")
list.prices1 <- prepare_list_prices(coins = my.coins1, start.date = "2021-01-01")

my.coins2 <- c("BUSD", "CEL", "PRE", "ETHW", "BAT")
list.prices2 <- prepare_list_prices(coins = my.coins2, start.date = "2021-01-01")

list.prices <- bind_rows(list.prices1, list.prices2)

# Generics ####

test_that("generic1 - capitals", {
  expect_snapshot(format_generic(data_generic1))
})

test_that("generic2 - different names", {
  expect_snapshot(
    format_generic(
      data_generic2,
      date = "Date.Transaction",
      currency = "Coin",
      quantity = "Amount",
      total.price = "Price",
      transaction = "Type",
      fees = "Fee",
      exchange = "Platform"
    ))
})

test_that("generic3 - calculate total.price", {
  expect_snapshot(format_generic(data_generic3))
})

test_that("generic4 - fetch spot.rate", {
  expect_snapshot(format_generic(data_generic4, list.prices = list.prices))
})

# Other exchanges ####

test_that("shakepay", {
  expect_snapshot(format_shakepay(data_shakepay))
})

test_that("newton", {
  expect_snapshot(format_newton(data_newton))
})

test_that("pooltool", {
  expect_snapshot(format_pooltool(data_pooltool))
})

test_that("CDC", {
  expect_snapshot(suppressMessages(format_CDC(data_CDC)))
})

test_that("celsius", {
  expect_snapshot(format_celsius(data_celsius))
})

test_that("adalite", {
  expect_snapshot(format_adalite(data_adalite, list.prices = list.prices))
})

test_that("binance", {
  expect_snapshot(format_binance(data_binance, list.prices = list.prices))
})

test_that("binance withdrawals", {
  expect_snapshot(format_binance_withdrawals(data_binance_withdrawals, list.prices = list.prices))
})

test_that("blockfi", {
  expect_snapshot(format_blockfi(data_blockfi, list.prices = list.prices))
})

test_that("CDC exchange rewards", {
  expect_snapshot(format_CDC_exchange_rewards(data_CDC_exchange_rewards, list.prices = list.prices))
})

test_that("CDC exchange trades", {
  expect_snapshot(format_CDC_exchange_trades(data_CDC_exchange_trades, list.prices = list.prices))
})

test_that("CDC wallet", {
  expect_snapshot(format_CDC_wallet(data_CDC_wallet, list.prices = list.prices))
})

test_that("coinsmart", {
  expect_snapshot(format_coinsmart(data_coinsmart, list.prices = list.prices))
})

test_that("exodus", {
  expect_snapshot(format_exodus(data_exodus, list.prices = list.prices))
})

test_that("presearch", {
  expect_snapshot(format_presearch(data_presearch, list.prices = list.prices))
})

test_that("gemini", {
  expect_snapshot(format_gemini(data_gemini, list.prices = list.prices))
})

test_that("uphold", {
  expect_snapshot(format_uphold(data_uphold, list.prices = list.prices))
})

# Test format_detect() ####

test_that("format_detect single", {
  expect_snapshot(format_detect(data_shakepay))
  expect_snapshot(format_detect(data_newton))
  expect_snapshot(format_detect(data_pooltool))
  expect_snapshot(format_detect(data_CDC))
  expect_snapshot(format_detect(data_celsius))
  expect_snapshot(format_detect(data_adalite, list.prices = list.prices))
  expect_snapshot(format_detect(data_binance, list.prices = list.prices))
  expect_snapshot(format_detect(data_binance_withdrawals, list.prices = list.prices))
  expect_snapshot(format_detect(data_blockfi, list.prices = list.prices))
  expect_snapshot(format_detect(data_CDC_exchange_rewards, list.prices = list.prices))
  expect_snapshot(format_detect(data_CDC_exchange_trades, list.prices = list.prices))
  expect_snapshot(format_detect(data_CDC_wallet, list.prices = list.prices))
  expect_snapshot(format_detect(data_coinsmart, list.prices = list.prices))
  expect_snapshot(format_detect(data_exodus, list.prices = list.prices))
  expect_snapshot(format_detect(data_presearch, list.prices = list.prices))
  expect_snapshot(format_detect(data_gemini, list.prices = list.prices))
  expect_snapshot(format_detect(data_uphold, list.prices = list.prices))
})

test_that("format_detect list", {
  expect_snapshot(format_detect(list(data_shakepay, data_newton, data_adalite), 
                                list.prices = list.prices))
})

# Add test: timezone!