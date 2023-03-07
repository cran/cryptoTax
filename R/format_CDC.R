#' @title Format Crypto.com App file
#'
#' @description Format a .csv transaction history file from Crypto.com for later
#' ACB processing.
#' @details Be aware that CDC unfortunately does not include the withdrawal
#' fees in their exported transaction files (please lobby to include this feature).
#' This function attempts to guess some known withdrawal fees at some point in time
#' but depending on when the withdrawals were made, the withdrawal fees are most
#' certainly inaccurate. You will have to make a manual correction for the
#' withdrawal fees after using `format_CDC`, on the resulting dataframe.
#' @param data The dataframe
#' @return A data frame of exchange transactions, formatted for further processing.
#' @export
#' @examples
#' format_CDC(data_CDC)
#' @importFrom dplyr %>% rename mutate rowwise filter select arrange bind_rows case_when
#' @importFrom rlang .data

format_CDC <- function(data) {
  # Known transactions ####
  known.transactions <- c(
    "crypto_earn_program_withdrawn", "rewards_platform_deposit_credited",
    "crypto_earn_extra_interest_paid", "crypto_earn_interest_paid",
    "reimbursement", "crypto_withdrawal", "mco_stake_reward", "referral_card_cashback",
    "crypto_transfer", "transfer_cashback", "card_cashback_reverted",
    "crypto_earn_program_created", "crypto_viban_exchange", "admin_wallet_credited",
    "card_top_up", "crypto_wallet_swap_credited", "crypto_wallet_swap_debited",
    "viban_purchase", "supercharger_reward_to_app_credited", "supercharger_withdrawal",
    "crypto_to_exchange_transfer", "supercharger_deposit", "crypto_exchange",
    "exchange_to_crypto_transfer", "crypto_deposit", "lockup_upgrade",
    "reimbursement_reverted", "mobile_airtime_reward", "crypto_payment",
    "pay_checkout_reward", "gift_card_reward", "crypto_purchase",
    "referral_gift", "lockup_lock"
  )

  # Rename columns ####
  data <- data %>%
    rename(
      quantity = "Amount",
      currency = "Currency",
      description = "Transaction.Kind",
      comment = "Transaction.Description",
      date = "Timestamp..UTC."
    )
  
  # Check if there's any new transactions
  check_new_transactions(data, 
                         known.transactions = known.transactions,
                         transactions.col = "description",
                         description.col = "comment")
  
  # Add single dates to dataframe ####
  data <- data %>%
    mutate(date = lubridate::as_datetime(.data$date))
  # UTC confirmed

  # Correct LUNA to LUNC balance conversions
  data <- data %>%
    mutate(
      currency = ifelse(.data$currency == "LUNA", "LUNC", .data$currency),
      currency = ifelse(.data$currency == "LUNA2", "LUNA", .data$currency)
    )

  # Convert USD value to CAD ####
  data.tmp <- data %>%
    cryptoTax::USD2CAD()
  
  if (is.null(data.tmp)) {
    message("Could not fetch exchange rates from the exchange rate API.")
    return(NULL)
  }
  
   data <- data.tmp %>%
    mutate(
      CAD.rate = ifelse(
        .data$Native.Currency == "USD",
        .data$CAD.rate,
        1),
      rate.source = ifelse(
        .data$Native.Currency == "USD",
        "exchange (USD conversion)",
        "exchange"),
      total.price = .data$Native.Amount * .data$CAD.rate
    )

  # Create a "buy" object ####
  BUY <- data %>%
    filter(.data$description == "crypto_purchase") %>%
    mutate(
      transaction = "buy",
      spot.rate = .data$total.price / .data$quantity
    ) %>%
    select(
      "date", "quantity", "currency", "total.price", "spot.rate",
      "transaction", "description", "comment", "rate.source"
    ) %>%
    filter(.data$currency != "CAD")

  # Create a second "buy" object ####
  BUY2 <- data %>%
    filter(.data$description == "crypto_exchange") %>%
    mutate(
      currency = .data$To.Currency,
      quantity = .data$To.Amount,
      transaction = "buy",
      spot.rate = .data$total.price / .data$quantity
    ) %>%
    select(
      "date", "quantity", "currency", "total.price", "spot.rate",
      "transaction", "description", "comment", "rate.source"
    ) %>%
    filter(.data$currency != "CAD")

  # Create a "credit card purchase" object ####
  CREDIT <- data %>%
    filter(.data$description == "viban_purchase") %>%
    mutate(
      total.price = abs(.data$total.price),
      quantity = .data$To.Amount,
      currency = .data$To.Currency,
      transaction = "buy",
      spot.rate = .data$total.price / .data$quantity
    ) %>%
    select(
      "date", "quantity", "currency", "total.price", "spot.rate",
      "transaction", "description", "comment", "rate.source"
    )

  # Create a "EARN" object ####
  EARN <- data %>%
    filter(
      .data$description %in% c(
        "reimbursement",
        "referral_card_cashback",
        "crypto_earn_interest_paid",
        "crypto_earn_extra_interest_paid",
        "mco_stake_reward",
        "transfer_cashback",
        "mobile_airtime_reward",
        "pay_checkout_reward",
        "gift_card_reward",
        "referral_gift",
        "rewards_platform_deposit_credited",
        "card_cashback_reverted",
        "reimbursement_reverted",
        "admin_wallet_credited",
        "supercharger_reward_to_app_credited"
      )
    ) %>%
    # Mission Rewards Deposit for last one
    mutate(
      transaction = "revenue",
      revenue.type = replace(
        .data$description,
        .data$description %in% c(
          "reimbursement", # Card cashback
          "referral_card_cashback", # Card cashback
          "card_cashback_reverted", # Card cashback
          "reimbursement_reverted", # Card cashback
          "mobile_airtime_reward", # Pay cashback (phone top-up)
          "pay_checkout_reward", # Pay cashback (internet purchase)
          "gift_card_reward"
        ), # Pay cashback (gift card)
        "rebates"
      ),
      revenue.type = replace(
        .data$revenue.type,
        .data$revenue.type %in% c(
          "crypto_earn_interest_paid",
          "crypto_earn_extra_interest_paid",
          "mco_stake_reward"
        ),
        "interests"
      ),
      revenue.type = replace(
        .data$revenue.type,
        .data$revenue.type %in% c(
          "transfer_cashback",
          "rewards_platform_deposit_credited"
        ),
        # Mission Rewards Deposit for last one
        "rewards"
      ),
      revenue.type = replace(
        .data$revenue.type,
        .data$revenue.type %in% c("referral_gift"),
        "referrals"
      ),
      revenue.type = replace(
        .data$revenue.type,
        .data$revenue.type %in% c("admin_wallet_credited"),
        "forks"
      ),
      total.price = abs(.data$total.price),
      spot.rate = abs(.data$total.price / .data$quantity)
    ) %>%
    select(
      "date", "quantity", "currency", "total.price", "spot.rate",
      "transaction", "revenue.type", "description", "comment", "rate.source"
    )

  # Correct EARN object for TCAD! Spot.rate = 1, and correct price accordingly...
  EARN <- EARN %>%
    mutate(
      spot.rate = ifelse(.data$currency == "TCAD",
        1,
        .data$spot.rate
      ),
      total.price = ifelse(.data$currency == "TCAD",
        .data$spot.rate * .data$quantity,
        .data$total.price
      )
    )

  # Create a "sell" object ####
  SELL <- data %>%
    filter(.data$description %in% c(
      "crypto_viban_exchange",
      "card_top_up",
      "crypto_payment"
    )) %>%
    mutate(
      quantity = abs(.data$quantity),
      total.price = abs(.data$total.price),
      transaction = "sell",
      spot.rate = .data$total.price / .data$quantity
    ) %>%
    select(
      "date", "quantity", "currency", "total.price", "spot.rate",
      "transaction", "description", "comment", "rate.source"
    )

  # Correct EARN object for TCAD! Spot.rate = 1, and correct price accordingly...
  SELL <- SELL %>%
    mutate(
      spot.rate = ifelse(.data$currency == "TCAD",
        1,
        .data$spot.rate
      ),
      total.price = ifelse(.data$currency == "TCAD",
        .data$spot.rate * .data$quantity,
        .data$total.price
      )
    )

  # Create a second "sell" object for exchanges ####
  SELL2 <- data %>%
    filter(.data$description %in% c("crypto_exchange")) %>%
    mutate(
      quantity = abs(.data$quantity),
      total.price = abs(.data$total.price),
      transaction = "sell",
      spot.rate = .data$total.price / .data$quantity
    ) %>%
    select(
      "date", "quantity", "currency", "total.price", "spot.rate",
      "transaction", "description", "comment", "rate.source"
    )

  # Correct EARN object for TCAD! Spot.rate = 1, and correct price accordingly...
  SELL2 <- SELL2 %>%
    mutate(
      spot.rate = ifelse(.data$currency == "TCAD",
        1,
        .data$spot.rate
      ),
      total.price = ifelse(.data$currency == "TCAD",
        .data$spot.rate * .data$quantity,
        .data$total.price
      )
    )

  # Create a "withdrawals" object ####
  WITHDRAWALS <- data %>%
    filter(.data$description == "crypto_withdrawal") %>%
    mutate(
      withdraw.fees = case_when(
        .data$comment == "Withdraw LTC (LTC)" ~ 0.001,
        .data$comment == "Withdraw LTC" ~ 0.001,
        .data$comment == "Withdraw CRO (CRO)" ~ 0.001,
        .data$comment == "Withdraw CRO" ~ 0.001,
        .data$comment == "Withdraw ETH (BSC)" ~ 0.0005,
        .data$comment == "Withdraw ETH" ~ 0.005,
        .data$comment == "Withdraw BTC" ~ 0.0004,
        .data$comment == "Withdraw ADA" ~ 0.8,
        .data$comment == "Withdraw ADA (Cardano)" ~ 0.8,
        .data$comment == "Withdraw CRO (Crypto.org)" ~ 0.001,
        .data$comment == "Withdraw CRO (Cronos)" ~ 0.2,
        .data$comment == "Withdraw USDC (BSC)" ~ 1
      ),
      spot.rate = abs(.data$Native.Amount / .data$quantity),
      quantity = .data$withdraw.fees,
      total.price = .data$quantity * .data$spot.rate,
      transaction = "sell"
    ) %>%
    select(
      "date", "quantity", "currency", "total.price", "spot.rate",
      "transaction", "description", "comment", "rate.source"
    )

  if (any(is.na(WITHDRAWALS$quantity))) {
    WITHDRAWALS.na <- unique(WITHDRAWALS[is.na(WITHDRAWALS$quantity), "currency"])
    WITHDRAWALS.na <- paste(WITHDRAWALS.na, collapse = ", ")
    warning(
      "Some withdrawal fees could not be detected automatically. ",
      "You will have to make manual corrections for: ", WITHDRAWALS.na
    )
  }

  # Actually withdrawal fees should be like "selling at zero", so correct total.price
  # WITHDRAWALS <- WITHDRAWALS %>%
  #  mutate(total.price = 0)

  # Merge the "buy" and "sell" objects ####
  data <- merge_exchanges(BUY, BUY2, CREDIT, EARN, SELL, SELL2, WITHDRAWALS) %>%
    mutate(exchange = "CDC")

  # Reorder columns properly
  data <- data %>%
    select(
      "date", "currency", "quantity", "total.price", "spot.rate", "transaction", 
      "description", "comment", "revenue.type", "exchange", "rate.source"
    )
  
  # Return result
  data
}
