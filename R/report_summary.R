#' @title Summary of gains and losses
#'
#' @description Provides a summary of realized capital gains and losses (and total).
#' @param formatted.ACB The formatted ACB data.
#' @param today.data whether to fetch today's data.
#' @param tax.year Which tax year(s) to include.
#' @param local.timezone Which time zone to use for the date of the report.
#' @param list.prices A `list.prices` object from which to fetch coin prices.
#' @param force Whether to force recreating `list.prices` even though
#' it already exists (e.g., if you added new coins or new dates).
#' @return A summary data frame, containing at least the following columns:
#' Type, Amount, currency.
#' @export
#' @examples
#' all.data <- format_shakepay(data_shakepay)
#' formatted.ACB <- format_ACB(all.data, verbose = FALSE)
#' report_summary(formatted.ACB, today.data = FALSE)
#' @importFrom dplyr %>% filter mutate group_by ungroup select summarize slice_tail arrange add_row rename
#' @importFrom rlang .data

report_summary <- function(formatted.ACB, today.data = TRUE, tax.year = "all",
                           local.timezone = Sys.timezone(), list.prices = NULL, force = FALSE) {
  if (today.data == TRUE & curl::has_internet() == FALSE) {
    message("You need Internet access to use the `today.data == TRUE` argument. The today.data argument has been set to `FALSE` automatically.")
    today.data <- FALSE
  }

  # Remove CAD
  formatted.ACB <- formatted.ACB %>%
    filter(.data$currency != "CAD")

  ACB.list <- formatted.ACB %>%
    group_by(.data$currency) %>%
    filter(.data$date == max(.data$date)) %>%
    slice_tail() %>%
    select("date", "currency", "total.quantity", "ACB.share", "ACB")

  # Filter for year, if necessary!
  if (tax.year != "all") {
    formatted.ACB.year <- formatted.ACB %>%
      mutate(datetime.local = lubridate::with_tz(.data$date, tz = local.timezone)) %>%
      filter(lubridate::year(.data$datetime.local) == tax.year)

    message(
      "gains, losses, and net have been filtered for tax year ",
      tax.year, " (time zone = ", local.timezone, ")"
    )
  } else {
    formatted.ACB.year <- formatted.ACB
  }

  # Total gains
  gains <- formatted.ACB.year %>%
    filter(.data$gains > 0) %>%
    ungroup() %>%
    select("gains") %>%
    summarize(gains = sum(.data$gains))

  gains <- formatC(unlist(gains), format = "f", big.mark = ",", digits = 2)

  # Total losses
  losses <- formatted.ACB.year %>%
    filter(.data$gains < 0) %>%
    ungroup() %>%
    select("gains") %>%
    summarize(losses = sum(.data$gains))

  losses <- formatC(unlist(losses), format = "f", big.mark = ",", digits = 2)

  # Get total capital gains (ACB.gains)
  net <- sum(formatted.ACB.year$gains, na.rm = TRUE)
  net.numeric <- net

  net <- formatC(net, format = "f", big.mark = ",", digits = 2)

  # total cost separately to accommodate today.data argument.
  total.cost <- formatC(sum(ACB.list$ACB), format = "f", big.mark = ",", digits = 2)

  if (today.data == TRUE) {
    # Make warning for GB, NFTs, etc.
    if (any(ACB.list$currency %in% "GB")) {
      message(
        "1. GB transactions are excluded from today's data because it is not listed on CoinMarketCap."
      )
    }
    if (any(grepl("NFT", ACB.list$currency))) {
      message(
        "2. NFTs are excluded from today's data because NFTs are not listed individually on CoinMarketCap."
      )
    }

    rates <- ACB.list %>%
      filter(
        .data$currency != "GB",
        !grepl("NFT", .data$currency)
      ) %>%
      mutate(
        date.temp = .data$date,
        date = last(list.prices$timestamp)
      )

    if (is.null(list.prices)) {
      stop("`list.prices` is NULL. It must be provided.")
    }
    
    rates <- cryptoTax::match_prices(rates, list.prices = list.prices, force = force)

    rates <- rates %>%
      mutate(
        rate.today = .data$spot.rate,
        value.today = round(.data$total.quantity * .data$rate.today, 2),
        unrealized.net = round(.data$value.today - .data$ACB, 2),
        unrealized.gains = ifelse(.data$unrealized.net > 0,
          .data$unrealized.net,
          NA
        ),
        unrealized.losses = ifelse(.data$unrealized.net < 0,
          .data$unrealized.net,
          NA
        )
      ) %>%
      select(
        "currency", "rate.today", "value.today", "unrealized.gains",
        "unrealized.losses", "unrealized.net"
      )

    unrealized.gains <- sum(rates$unrealized.gains, na.rm = TRUE)
    unrealized.losses <- sum(rates$unrealized.losses, na.rm = TRUE)
    unrealized.net <- sum(rates$unrealized.net, na.rm = TRUE)
    value.today <- sum(rates$value.today)
    percentage.up <- (value.today / sum(ACB.list$ACB) - 1) * 100
    all.time.up <- ((value.today + net.numeric) / sum(ACB.list$ACB) - 1) * 100

    unrealized.gains <- formatC(unlist(unrealized.gains), format = "f", big.mark = ",", digits = 2)
    unrealized.losses <- formatC(unlist(unrealized.losses), format = "f", big.mark = ",", digits = 2)
    unrealized.net <- formatC(unlist(unrealized.net), format = "f", big.mark = ",", digits = 2)
    value.today <- formatC(unlist(value.today), format = "f", big.mark = ",", digits = 2)
    percentage.up <- paste0(formatC(unlist(percentage.up), format = "f", big.mark = ",", digits = 2), "%")
    all.time.up <- paste0(formatC(unlist(all.time.up), format = "f", big.mark = ",", digits = 2), "%")

    # Get all nicely
    temp <- t(data.frame(
      gains, losses, net, total.cost,
      value.today, unrealized.gains,
      unrealized.losses, unrealized.net,
      percentage.up, all.time.up
    ))
  }

  if (today.data == FALSE) {
    # Get all nicely
    temp <- t(data.frame(gains, losses, net, total.cost))
  }

  results <- temp %>%
    as.data.frame() %>%
    rename("Amount" = "gains") %>%
    mutate(Type = rownames(temp)) %>%
    select("Type", "Amount")
  rownames(results) <- NULL

  results <- rbind(c("tax.year", tax.year), results)

  results <- cbind(results, currency = "CAD")

  results
}
