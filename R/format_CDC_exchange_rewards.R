#' @title Format CDC exchange file (FOR REWARDS ONLY)
#'
#' @description Format a .csv transaction history file from the
#' Crypto.com exchange for later ACB processing. Only processes
#' rewards and withdrawal fees, not trades (see
#' `format_CDC_exchange_trades` for this).
#'
#' To download the rewards/withdrawal fees data from the Crypto.com
#' exchange as a CSV file, copy and paste the code below and save it
#' as a bookmark in your browser.
#'
#' `javascript:(function(){function callback(){window.cdc()}var s=document.createElement("script");s.src="https://cdn.jsdelivr.net/gh/ConorIA/cdc-csv@master/cdc.js";if(s.addEventListener){s.addEventListener("load",callback,false)}else if(s.readyState){s.onreadystatechange=callback}document.body.appendChild(s);})()`
#'
#' Then log into the crypto.com exchange and click the bookmark you
#' saved. It will automatically download a CSV that contains Supercharger
#' rewards, withdrawal fees, CRO staking interest (if you have an
#' exchange stake), among others.
#'
#' Note that this code does not include the initial referral reward in CRO
#' for signup or on the Crypto.com exchange. It must be added manually.
#'
#' WARNING: DOES NOT DOWNLOAD TRADES, ONLY REWARDS, ONLY REWARDS AND WITHDRAWALS!
#'
#' @param data The dataframe
#' @param list.prices A `list.prices` object from which to fetch coin prices.
#' @param force Whether to force recreating `list.prices` even though
#' it already exists (e.g., if you added new coins or new dates).
#' @return A data frame of exchange transactions, formatted for further processing.
#' @export
#' @examples
#' format_CDC_exchange_rewards(data_CDC_exchange_rewards)
#' @importFrom dplyr %>% rename mutate filter select arrange
#' @importFrom rlang .data

format_CDC_exchange_rewards <- function(data, list.prices = NULL, force = FALSE) {
  known.transactions <- c("", "Reward", "referral_gift")
  # "referral_gift" is for our manual correction
  
  # Rename columns
  data <- data %>%
    rename(
      quantity = "Received.Amount",
      currency = "Received.Currency",
      description = "Label",
      comment = "Description",
      date = "Date"
    )
  
  # Check if there's any new transactions
  check_new_transactions(data, 
                         known.transactions = known.transactions,
                         transactions.col = "description",
                         description.col = "comment")
  
  # Add single dates to dataframe
  data <- data %>%
    mutate(date = lubridate::as_datetime(.data$date))
  # UTC confirmed

  # Add description to withdrawals
  data <- data %>%
    mutate(
      description = ifelse(grepl("Withdrawal", .data$comment),
        "Withdrawal",
        .data$description
      ),
      currency = ifelse(grepl("Withdrawal", .data$comment),
        .data$Sent.Currency,
        .data$currency
      )
    )

  # Create a "earn" object
  EARN <- data %>%
    filter(.data$description %in% c(
      "Reward",
      "referral_gift"
    )) %>%
    mutate(
      transaction = "revenue",
      revenue.type = replace(
        .data$description,
        .data$description %in% c("Reward"),
        "interests"
      ),
      revenue.type = replace(
        .data$revenue.type,
        .data$revenue.type %in% c("referral_gift"),
        "referrals"
      ),
      revenue.type = replace(
        .data$revenue.type,
        grepl("Rebate", .data$comment),
        "rebates"
      )
    ) %>%
    select(
      "date", "quantity", "currency", "transaction",
      "revenue.type", "description", "comment"
    )

  # Create a "withdrawals" object
  WITHDRAWALS <- data %>%
    filter(.data$description == "Withdrawal") %>%
    mutate(
      quantity = .data$Fee.Amount,
      transaction = "sell"
    ) %>%
    select(
      "date", "quantity", "currency", "transaction",
      "description"
    )

  # Merge the "buy" and "sell" objects
  data <- merge_exchanges(EARN, WITHDRAWALS) %>%
    mutate(exchange = "CDC.exchange")

  # Determine spot rate and value of coins
  data <- cryptoTax::match_prices(data, list.prices = list.prices, force = force)
  
  if (any(is.na(data$spot.rate))) {
    warning("Could not calculate spot rate. Use `force = TRUE`.")
  }

  data <- data %>%
    mutate(total.price = ifelse(is.na(.data$total.price),
      .data$quantity * .data$spot.rate,
      .data$total.price
    ))
  
  # Reorder columns properly
  data <- data %>%
    select(
      "date", "currency", "quantity", "total.price", "spot.rate", "transaction", 
      "description", "comment", "revenue.type", "exchange", "rate.source"
    )

  # Return result
  data
}
