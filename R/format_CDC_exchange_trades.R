#' @title Format CDC exchange file (FOR TRADES ONLY)
#'
#' @description Format a .csv transaction history file from the Crypto.com
#' exchange for later ACB processing. Only processes trades, not rewards
#' (see `format_CDC_exchange_rewards` for this).
#' @details  Original file name of the right file from the exchange is
#' called "SPOT_TRADE.csv", make sure you have the right one. It can
#' usually be accessed with the following steps: (1) connect to the
#' CDC exchange. On the left menu, click on "Wallet", and choose the
#' "Transactions" tab. Pick your desired dates. Unfortunately, the CDC
#' exchange history export only supports 30 days at a time. So if you
#' have more than that, you will need to export each file and merge them
#' manually before you use this function.
#'
#' As of the new changes to the exchange (3.0) transactions before
#' November 1st, 2022, one can go instead through the "Archive" button
#' on the left vertical menu, choose dates (max 100 days), and
#' download trade transactions. It will be a zip file with several
#' transaction files inside. Choose the "SPOT_TRADE.csv".
#'
#' In newer versions of this transaction history file, CDC has added
#' three disclaimer character lines at the top of the file, which is
#' messing with the headers. Thus, when reading the file with
#' `read.csv()`, add the argument `skip = 3`. You will then be able to
#' read the file normally.
#' @param data The dataframe
#' @param list.prices A `list.prices` object from which to fetch coin prices.
#' @param force Whether to force recreating `list.prices` even though
#' it already exists (e.g., if you added new coins or new dates).
#' @return A data frame of exchange transactions, formatted for further processing.
#' @export
#' @examples
#' format_CDC_exchange_trades(data_CDC_exchange_trades)
#' @importFrom dplyr %>% rename mutate case_when filter select arrange bind_rows mutate_at
#' @importFrom rlang .data

format_CDC_exchange_trades <- function(data, list.prices = NULL, force = FALSE) {
  known.transactions <- c("SELL", "BUY")
  
  # Rename columns
  data <- data %>%
    rename(
      quantity = "Trade.Amount",
      description = "Side",
      comment = "Symbol",
      date = "Time..UTC."
    )
  
  # Check if there's any new transactions
  check_new_transactions(data, 
                         known.transactions = known.transactions,
                         transactions.col = "description")

  # Add single dates to dataframe
  data <- data %>%
    mutate(date = lubridate::as_datetime(.data$date))
  # UTC confirmed

  # Separate trade transactions
  data <- data %>%
    mutate(
      pair.currency1 = gsub("_.*", "", .data$comment),
      pair.currency2 = gsub(".*_", "", .data$comment)
    )

  # Determine if fees were paid in a third currency or not
  data <- data %>%
    mutate(
      third.currency =
        case_when(
          description == "BUY" ~ .data$Fee.Currency != .data$pair.currency1,
          description == "SELL" ~ .data$Fee.Currency != .data$pair.currency2
        )
    )

  # Determine spot rate and value of fees
  data.fees <- data %>%
    mutate(currency = .data$Fee.Currency)

  data.fees <- cryptoTax::match_prices(data.fees, list.prices = list.prices, force = force)
  
  if (any(is.na(data$spot.rate))) {
    warning("Could not calculate spot rate. Use `force = TRUE`.")
  }

  data$fees <- data.fees$Fee * data.fees$spot.rate
  
  # Create a "buy" object
  BUY <- data %>%
    filter(.data$description == "BUY") %>%
    mutate(
      transaction = "buy",
      currency = .data$pair.currency1
    ) %>%
    select(
      "date", "quantity", "currency", "transaction",
      "description", "comment", "fees"
    )

  # Create a second "buy" object for sell trades
  BUY2 <- data %>%
    filter(.data$description == "BUY") %>%
    mutate(
      transaction = "sell",
      currency = .data$pair.currency2,
      quantity = .data$Volume.of.Business,
      description = "SELL"
    ) %>%
    select(
      "date", "quantity", "currency", "transaction",
      "description", "comment"
    )

  # Create a "sell" object
  SELL <- data %>%
    filter(.data$description == "SELL") %>%
    mutate(
      transaction = "sell",
      currency = .data$pair.currency1
    ) %>%
    select(
      "date", "quantity", "currency", "transaction",
      "description", "comment", "fees"
    )

  # Create a second "sell" object
  SELL2 <- data %>%
    filter(.data$description == "SELL") %>%
    mutate(
      transaction = "buy",
      currency = .data$pair.currency2,
      quantity = .data$Volume.of.Business,
      description = "BUY"
    ) %>%
    select(
      "date", "quantity", "currency", "transaction",
      "description", "comment"
    )

  # Create a third "sell" object for third currencies...
  SELL3 <- data %>%
    filter(.data$third.currency == TRUE) %>%
    mutate(
      transaction = "sell",
      currency = .data$Fee.Currency,
      quantity = .data$Fee,
      total.price = .data$fees,
      description = "Trading fee paid with CRO"
    ) %>%
    select(
      "date", "quantity", "currency", "total.price", "transaction",
      "description", "comment"
    )

  SELL3 <- data.fees %>%
    filter(.data$third.currency == TRUE) %>%
    select("spot.rate", "rate.source") %>%
    cbind(SELL3)

  # Merge the "buy" and "sell" objects
  data <- merge_exchanges(BUY, BUY2, SELL, SELL2, SELL3)

  # Determine spot rate and value of coins
  data <- cryptoTax::match_prices(data, list.prices = list.prices, force = force)

  data <- data %>%
    mutate(total.price = ifelse(is.na(.data$total.price),
      .data$quantity * .data$spot.rate,
      .data$total.price
    ))

  # CORRECT SPOT RATE FOR COIN TO COIN TRANSACTIONS [for sales]
  # Replace total.price first, then in a second step spot.rate
  
  coin.prices <- data %>%
    filter(.data$transaction %in% c("buy")) %>%
    mutate(transaction = "sell")
  
  # Recreate the SELL object because we need the calculated total prices
  SELL <- data %>%
    filter(.data$transaction %in% c("sell"),
           !grepl("Trading fee paid with", .data$description))
  
  # These are the prices I want to replace
  SELL[which(SELL$date %in% coin.prices$date), "total.price"]
  
  # These are the correct prices
  coin.prices[which(coin.prices$date %in% SELL$date), "total.price"]
  
  # Let's replace them
  SELL[which(SELL$date %in% coin.prices$date), "total.price"] <- coin.prices[which(
    coin.prices$date %in% SELL$date
  ), "total.price"]
  
  # Now let's recalculate spot.rate
  SELL <- SELL %>%
    mutate(spot.rate = .data$total.price / .data$quantity)
  
  # Let's also replace the rate.source for these transactions
  SELL[which(SELL$date %in% coin.prices$date), "rate.source"] <- "coinmarketcap (buy price)"
  
  # Temporarily remove trading fees
  trading.fees <- data %>%
    filter(grepl("Trading fee paid with", .data$description))
  
  data <- data %>%
    filter(!grepl("Trading fee paid with", .data$description))
  
  # Replace these transactions in the main dataframe
  data[which(data$transaction == "sell"), ] <- SELL
  
  # Arrange in correct order
  data <- data %>% 
    bind_rows(trading.fees) %>%
    mutate(exchange = "CDC.exchange") %>% 
    arrange(date, desc(.data$total.price), .data$transaction)
  
  # Reorder columns properly
  data <- data %>%
    select(
      "date", "currency", "quantity", "total.price", "spot.rate", "transaction", 
      "fees", "description", "comment", "exchange", "rate.source"
    )
  
  # Return result
  data
}
