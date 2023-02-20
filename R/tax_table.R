#' @title Format tax table for final HTML report
#'
#' @description Format tax tables for the final rmd/html report.
#' @param table The table to format
#' @param repeat.header Logical, whether to repeat headers at the bottom.
#' @param type Type of table, one of 1 (default), 2, or 3.
#' @return A flextable object, with certain formatting features. 
#' @export
#' @examples 
#' all.data <- format_shakepay(data_shakepay)
#' formatted.ACB <- format_ACB(all.data, verbose = FALSE)
#' x <- get_sup_losses(formatted.ACB, 2021)
#' tax_table(x)
#' @importFrom dplyr %>% filter arrange mutate select summarize desc
#' @importFrom rlang .data

tax_table <- function(table, repeat.header = FALSE, type = 1) {
  rlang::check_installed(c("flextable", "rmarkdown"),
    reason = "for this function."
  )

  flex.table <- flextable::flextable(table) %>%
    flextable::theme_apa() %>%
    flextable::set_table_properties(layout = "autofit") %>%
    flextable::bold(part = "header")

  if (isTRUE(repeat.header)) {
    flex.table <- flex.table %>%
      repeat_header()
  }

  if (type == 2) {
    # Count number of decimals and get index
    small.index <- which(decimalplaces(table$total.quantity) == 0)
    exactly.one <- which(table$total.quantity == 1)

    flex.table <- flex.table %>%
      flextable::colformat_double(j = "total.quantity", digits = 7) %>%
      flextable::colformat_double(
        i = small.index,
        j = "total.quantity", digits = 2
      ) %>%
      flextable::colformat_double(
        i = exactly.one,
        j = "total.quantity", digits = 0
      )
  } else if (type == 3) {
    flex.table <- flex.table %>%
      flextable::bold(part = "header") %>%
      flextable::bold(i = nrow(table))
    if (nrow(table) > 1) {
      flex.table <- flextable::hline(flex.table, i = nrow(table) - 1)
      }
  }
  flex.table
}

repeat_header <- function(table) {
  # Add footer with column names
  table <- table %>%
    flextable::add_footer_row(
      values = table$col_keys,
      colwidths = rep(1, length(table$col_keys))
    ) %>%
    flextable::bold(i = nrow(table$body$dataset)) %>%
    flextable::bold(part = "header") %>%
    flextable::bold(part = "footer") %>%
    flextable::hline(i = nrow(table$body$dataset) - 1) %>%
    flextable::hline(part = "footer") %>%
    flextable::fontsize(part = "all", size = 12) %>%
    flextable::font(part = "all", fontname = "Times New Roman") %>%
    flextable::align(align = "center", part = "all")
  table
}

# Function to count number of decimals
decimalplaces <- function(x) {
  ifelse(abs(x - round(x)) > .Machine$double.eps^0.5,
    nchar(sub("^\\d+\\.", "", sub("0+$", "", as.character(x)))),
    0
  )
}
