#' @title Prepare the list of coins for prices
#'
#' @description Prepare the list of coins for prices.
#' @details The [crypto2::crypto_history] API is at times a bit capricious. You might
#' need to try a few times before it process correctly and without
#' errors.
#' @param coins Which coins to include in the list.
#' @param start.date What date to start reporting prices for.
#' @param end.date What date to end reporting prices for.
#' @param force Whether to force recreating `list.prices` even though
#' it already exists (e.g., if you added new coins or new dates).
#' @return A data frame, with the following columns: timestamp, id, slug, 
#' name, symbol, ref_cur, open, high, low, close, volume, market_cap, 
#' time_open, time_close, time_high, time_low, spot.rate2, currency, date2.
#' @export
#' @examples
#' my.coins <- c("BTC", "ETH")
#' my.list.prices <- prepare_list_prices(coins = my.coins, start.date = "2023-01-01")
#' head(my.list.prices)
#' @importFrom dplyr %>% rename mutate rowwise filter select bind_rows left_join arrange
#' @importFrom utils timestamp
#' @importFrom rlang .data

prepare_list_prices <- function(coins,
                                start.date,
                                end.date = lubridate::now("UTC"),
                                force = FALSE) {
  if (isFALSE(curl::has_internet())) {
    message("This function requires Internet access.")
    return(NULL)
  }
  
  # List all active coins
  if (!exists("coins.list")) {
  tryCatch(
    expr = {coins.list <- crypto2::crypto_list(only_active = TRUE)},
    error = function(e) {
      message("Could not reach the CoinMarketCap API at this time")
      return(NULL)
      },
    warning = function(w) {
      return(NULL)
    })
    
    if (!exists("coins.list")) {
      message("Could not reach the CoinMarketCap API at this time")
      return(NULL)
    }
    
    # Remove some bad coins from list (which share the same name with NANO or EFI for example)
    coins.list <- coins.list %>%
      filter(!(.data$slug %in% c("xeno-token", "earnablefi")))
    
    coins.list <<- coins.list
  }
  
  if (isTRUE(force) || !exists("list.prices")) {
    # Define coins from our merged data set

    if (is.null(coins)) {
      # For demonstration purposes
      coins <- c("BTC", "ETH")
    }

    my.coins <- coins
    names(my.coins) <- my.coins

    # Remove the NFTs, TCAD, CAD, GB
    my.coins <- my.coins[!grepl("NFT", my.coins)]
    my.coins <- my.coins[!grepl("TCAD", my.coins)]
    my.coins <- my.coins[!grepl("CAD", my.coins)]
    my.coins <- my.coins[!grepl("GB", my.coins)]
    # Remove TCAD/CAD (Market data is untracked: This project is featured as an 'Untracked Listing')

    # Correct for Nano!!
    my.coins <- gsub("NANO", "XNO", my.coins)

    # Filter old coins object for coins from our merged data set
    coins.temp <- coins.list %>%
      filter(.data$symbol %in% my.coins)

    # Dates cannot have hyphens in crypto2::crypto_history!
    start.date <- start.date %>%
      as.Date() %>%
      stringr::str_split("-", simplify = TRUE) %>%
      paste(collapse = "")

    end.date <- end.date %>%
      as.Date() %>%
      stringr::str_split("-", simplify = TRUE) %>%
      paste(collapse = "")

    tryCatch(
      expr = {
        coin_hist <- crypto2::crypto_history(
          coin_list = coins.temp,
          start_date = start.date,
          end_date = end.date,
          convert = "CAD",
          sleep = 0, # changed from 60
          finalWait = FALSE # changed from TRUE
        )
      },
      error = function(e) {
        message(c("Could not fetch crypto prices from the CoinMarketCap API. ",
                  "Please try again, perhaps with fewer coins."))
        return(NULL)},
      warning = function(w) {
        return(NULL)
        })

    if (!exists("coin_hist")) {
      message("'coin_hist' could not fetch correctly. Please try again.")
      return(NULL)
    }
    
    if (!"symbol" %in% names(coin_hist)) {
      message("'coin_hist' could not fetch correctly. Please try again.")
      return(NULL)
    }
        
    coin_hist <<- coin_hist
    
    list.prices <- coin_hist %>%
      rowwise() %>%
      mutate(
        spot.rate2 = mean(c(.data$open, .data$close)),
        currency = .data$symbol,
        date2 = lubridate::as_date(.data$timestamp)
      )
  } else {
    message(
      "Object 'list.prices' already exists. Reusing 'list.prices'. ",
      "To force a fresh download, use argument 'force = TRUE'."
    )
  }

  list.prices
}
