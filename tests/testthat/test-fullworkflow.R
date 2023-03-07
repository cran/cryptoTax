test_that("full workflow", {
  testthat::skip_on_cran()
  
  options(scipen = 999)
  
  # Prepare list of coins ####
  my.coins1 <- c("BTC", "ETH", "ADA", "CRO", "LTC", "USDC")
  list.prices1 <- prepare_list_prices(coins = my.coins1, start.date = "2021-01-01")
  
  my.coins2 <- c("BUSD", "CEL", "PRE", "ETHW", "BAT")
  list.prices2 <- prepare_list_prices(coins = my.coins2, start.date = "2021-01-01")
  
  list.prices <- bind_rows(list.prices1, list.prices2)
  
  # Generate string list of exchanges ####
  exchanges <- paste0(c(
    "adalite",
    "binance",
    "binance_withdrawals",
    "blockfi",
    "CDC",
    "CDC_exchange_rewards",
    "CDC_exchange_trades",
    "CDC_wallet",
    "celsius",
    "coinsmart",
    "exodus",
    "gemini",
    "newton",
    "pooltool",
    "presearch",
    "shakepay",
    "uphold"))
  
  data_exchanges <- paste0("data_", exchanges)
  
  formatted.data <- suppressMessages(lapply(data_exchanges, function(x) {
    format_detect(eval(parse(text = x)), list.prices = list.prices)
  })) %>% 
    merge_exchanges()
  
  # Format data ####
  expect_warning(suppressMessages(format_ACB(formatted.data), "negative values"))
  
  formatted.ACB <- format_ACB(formatted.data, verbose = FALSE)
  
  expect_s3_class(formatted.ACB, "data.frame")
  
  expect_s3_class(check_missing_transactions(formatted.ACB), "data.frame")
  
  expect_s3_class(get_latest_transactions(formatted.ACB), "data.frame")
  
  expect_type(listby_coin(formatted.ACB), "list")
  
  proceeds <- get_proceeds(formatted.ACB, tax.year = 2021)
  
  expect_s3_class(proceeds, "data.frame")
  
  sup.losses <- get_sup_losses(formatted.ACB, 2021)
  
  expect_s3_class(sup.losses, "data.frame")
  
  # Get latest ACB.share for each coin (ACB)
  report.overview <- report_overview(formatted.ACB, today.data = TRUE, tax.year = "all", 
                                     local.timezone = "America/Toronto",
                                     list.prices = list.prices)
  
  expect_s3_class(report.overview, "data.frame")
  
  # Get summary of realized capital gains and losses
  report.summary <- report_summary(formatted.ACB, today.data = TRUE, tax.year = "all", 
                                   local.timezone = "America/Toronto",
                                   list.prices = list.prices)
  
  expect_s3_class(report.summary, "data.frame")
  
  table.revenues <- report_revenues(formatted.ACB, tax.year = "all")
  
  expect_s3_class(table.revenues, "data.frame")
  
  # Graphs ####
  pie_exchange <- crypto_pie(table.revenues)
  
  expect_s3_class(pie_exchange, "ggplot")
  
  pie_revenue <- crypto_pie(table.revenues, by = "revenue.type")
  
  expect_s3_class(pie_revenue, "ggplot")
  
  # Tax summary box
  tax.box <- tax_box(report.summary, sup.losses, table.revenues, proceeds)
  
  expect_s3_class(tax.box, "data.frame")
  
  report.info <- prepare_report(formatted.ACB, list.prices = list.prices)
  
  expect_type(report.info, "list")
  
  # Report
  print_report(tax.year = "2021", 
               name = "Mr. Cryptoltruist", 
               report.info)
  
  unlink("full_report.html")
})

