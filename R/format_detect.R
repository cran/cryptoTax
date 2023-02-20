#' @title Detect transaction file exchange and format it
#'
#' @description Detect the exchange of a given transaction file and format
#' it with the proper function for later ACB processing.
#' @param data The dataframe
#' @param list.prices A `list.prices` object from which to fetch coin prices.
#' @param force Whether to force recreating `list.prices` even though
#' it already exists (e.g., if you added new coins or new dates).
#' @param ... Used for other methods.
#' @return A data frame of exchange transactions, formatted for further processing.
#' @examples
#' format_detect(data_shakepay)
#' format_detect(data_newton)
#' format_detect(list(data_shakepay, data_newton))
#' @importFrom dplyr %>% rename mutate select filter bind_rows
#' @importFrom rlang .data

#' @export
format_detect <- function (data, ...) {
  UseMethod("format_detect", data)
}

#' @rdname format_detect
#' @export
format_detect.data.frame <- function(data, list.prices = NULL, force = FALSE, ...) {
  
  # Extract data col names
  data.names <- toString(names(data))
  
  # Generate string list of exchanges
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
  
  # Extract col names of all exchanges
  exchanges.cols <- lapply(data_exchanges, function(x) {
    toString(names(eval(parse(text = x))))
  }) %>% 
    stats::setNames(exchanges)
  
  # Generate logical condition to identify right exchange
  condition <- names(which(data.names == exchanges.cols))
  
  if (all(condition == c("CDC_exchange_rewards", "CDC_wallet"))) {
    if (any(unlist(lapply(c("Supercharger", "Interest", "APR", "Rebate"), grepl, data$Description)))) {
      condition <- "CDC_exchange_rewards"
    } else if (any(unlist(lapply(c("Validator", "Auto Withdraw"), grepl, data$Description)))) {
      condition <- "CDC_wallet"
    }
  } else if (length(condition) == 0) {
    stop("Could not identify the correct exchange automatically. ",
         "Please use the appropriate function or 'format_generic()'.")
  } else if (length(condition) > 1) {
    stop("Matches multiple exchange names. Please report this bug so it can be fixed.")
  }
  
  # Apply right function
  formatted.data <- switch(
    condition,
    shakepay = {format_shakepay(data)},
    newton = {format_newton(data)},
    pooltool = {format_pooltool(data)},
    CDC = {format_CDC(data)},
    celsius = {format_celsius(data)},
    adalite = {format_adalite(data, list.prices = list.prices, force = force)},
    binance = {format_binance(data, list.prices = list.prices, force = force)},
    binance_withdrawals = {format_binance_withdrawals(data, list.prices = list.prices, force = force)},
    blockfi = {format_blockfi(data, list.prices = list.prices, force = force)},
    CDC_exchange_rewards = {format_CDC_exchange_rewards(data, list.prices = list.prices, force = force)},
    CDC_exchange_trades = {format_CDC_exchange_trades(data, list.prices = list.prices, force = force)},
    CDC_wallet = {format_CDC_wallet(data, list.prices = list.prices, force = force)},
    coinsmart = {format_coinsmart(data, list.prices = list.prices, force = force)},
    exodus = {format_exodus(data, list.prices = list.prices, force = force)},
    gemini = {format_gemini(data, list.prices = list.prices, force = force)},
    presearch = {format_presearch(data, list.prices = list.prices, force = force)},
    uphold = {format_uphold(data, list.prices = list.prices, force = force)},
  )
  
  message("Exchange detected: ", condition)
  
  formatted.data
}

#' @rdname format_detect
#' @export
format_detect.list <- function(data, list.prices = NULL, force = FALSE, ...) {
  formatted.data <- lapply(data, format_detect, list.prices = list.prices, force = force)
  formatted.data <- merge_exchanges(formatted.data)
  formatted.data
}