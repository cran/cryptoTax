#' @title Calculate superficial capital losses
#'
#' @description Calculate superficial capital losses to be substracted from total capital losses.
#' @param data The data
#' @param transaction Name of transaction column
#' @param quantity Name of quantity column
#' @param cl The number of cores to use.
#' @return A data frame of formatted transactions, with added columns
#' with information about superficial losses.
#' @export
#' @examples
#' data <- data_adjustedcostbase1
#' format_suploss(data)
#' @importFrom dplyr mutate %>% filter summarize bind_rows distinct transmute ungroup group_by select arrange rename add_row
#' @importFrom lubridate %within%
#' @importFrom rlang .data

format_suploss <- function(data,
                           transaction = "transaction",
                           quantity = "quantity",
                           cl = NULL) {
  out <- data %>%
    add_quantities(transaction = transaction, quantity = quantity) %>%
    sup_loss_single_df(transaction = transaction, quantity = quantity) %>%
    bind_rows() %>%
    arrange(date)
  out
}

add_quantities <- function(data, transaction = "transaction", quantity = "quantity") {
  data %>%
    mutate(
      quantity.negative = ifelse(.data[[transaction]] == "sell",
        .data[[quantity]] * -1,
        .data[[quantity]]
      ),
      total.quantity = cumsum(.data$quantity.negative)
    ) %>%
    select(-"quantity.negative")
}
# Need to round to 18 decimals otherwise we don't get the same
# results as the for loop option. The reason is that there are
# some hidden decimals after 18 which leads to negative values
# later since They were probably not taken into account by the
# exchange when trading. So they gave a few decimals extra.
# It is safe to ignore and will prevent false alarms about
# negative values. Have to check though if rounding to 18 decimals
# won't create other problems elsewhere.

sup_loss_single_df <- function(data, transaction = "transaction", quantity = "quantity") {
  data.range <- data %>%
    mutate(suploss.range = suploss_range(.data$date))
  list.ranges <- data.range %>%
    filter(.data[[transaction]] == "buy") %>%
    select("suploss.range")
  # Calculate the sum of buy quantities for each range of 60 days...
  list.ranges.df <- check_suploss(data.range)
  quantity.60days <- lapply(list.ranges.df, function(x) {
    x %>%
      mutate(quantity.buy = ifelse(.data[[transaction]] == "buy",
        .data[[quantity]],
        0
      )) %>%
      summarize(quantity.60days = sum(.data$quantity.buy))
  }) %>% bind_rows()
  if (nrow(quantity.60days) == 0) {
    quantity.60days <- data.range %>%
      ungroup() %>%
      transmute(quantity.60days = NA)
  }

  # Now calculate share.left60
  share.left60 <- lapply(list.ranges.df, function(x) {
    x %>%
      utils::tail(1) %>%
      ungroup() %>%
      select("total.quantity") %>%
      rename(share.left60 = "total.quantity")
  }) %>% bind_rows()
  if (nrow(share.left60) == 0) {
    share.left60 <- data.range %>%
      ungroup() %>%
      transmute(share.left60 = NA)
  }

  data.range2 <- data.frame(data.range, quantity.60days, share.left60)
  data.range3 <- data.range2 %>%
    rowwise() %>%
    mutate(
      sup.loss = any(.data$date %within% list.ranges),
      sup.loss = ifelse(.data[[transaction]] != "sell",
        FALSE,
        .data$sup.loss
      ),
      sup.loss.quantity = ifelse(.data$sup.loss == TRUE,
        .data[[quantity]],
        0
      )
    ) %>%
    ungroup()
  data.range3
}

suploss_range <- function(date) {
  after.30 <- date + lubridate::days(30)
  before.30 <- date - lubridate::days(30)
  range <- lubridate::interval(before.30, after.30)
  range
}

check_suploss <- function(data) {
  # data <- data %>%
  #  filter(transaction == "sell")
  # Should we filter for sell transactions to increase efficiency?
  if (nrow(data) > 0) {
    list.ranges.df <- lapply(seq(nrow(data)), function(x) {
      data %>%
        filter(date %within% .data$suploss.range[x])
    })
  } else {
    list.ranges.df <- list()
  }
  list.ranges.df
}
