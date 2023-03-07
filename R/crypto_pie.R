#' @title Make a pie chart of your crypto revenues
#'
#' @description Format a .csv file from Newton for later ACB processing.
#' @param table.revenues The revenue table to plot
#' @param by To plot by which element, one of `c("exchange", "revenue.type")`.
#' @return A ggplot2 object in the form of a pie chart.
#' @export
#' @examples
#' shakepay <- format_shakepay(data_shakepay)
#' newton <- format_newton(data_newton)
#' all.data <- merge_exchanges(shakepay, newton)
#' formatted.ACB <- format_ACB(all.data, verbose = FALSE)
#' table.revenues <- report_revenues(formatted.ACB)
#' crypto_pie(table.revenues)
#' crypto_pie(table.revenues, by = "revenue.type")
#' @importFrom dplyr %>% filter arrange mutate select summarize desc
#' @importFrom rlang .data

crypto_pie <- function(table.revenues, by = "exchange") {
  if (by == "exchange") {
    # Modify dataframe appropriately
    pie.data <- table.revenues %>%
      filter(.data$exchange != "total") %>%
      arrange(desc(.data$exchange)) %>%
      mutate(position = cumsum(.data$total.revenues) - 0.5 * .data$total.revenues)

    # Define the number of colors for pastel palette
    nb.cols <- nrow(table.revenues)
    mycolors <- grDevices::colorRampPalette(
      RColorBrewer::brewer.pal(8, "Pastel1")
    )(nb.cols)

    # Combine exchange with revenue!
    pie.data <- pie.data %>%
      mutate(my.label = paste0("$", .data$total.revenues, "\n", .data$exchange))
  }

  # Add option for revenue.type
  if (by == "revenue.type") {
    table.revenues <- table.revenues %>%
      filter(.data$exchange != "total") %>%
      select("airdrops":"mining") %>%
      summarize(across(tidyselect::where(is.numeric), \(x) sum(x, na.rm = TRUE))) %>%
      round(2) %>%
      t() %>%
      as.data.frame() %>%
      filter(.data$V1 != 0)
    table.revenues[, 2] <- rownames(table.revenues)
    colnames(table.revenues) <- c("total.revenues", by)

    pie.data <- table.revenues %>%
      select("total.revenues":"revenue.type") %>%
      arrange(desc(.data$revenue.type)) %>%
      mutate(position = cumsum(.data$total.revenues) - 0.5 * .data$total.revenues)

    # Define the number of colors for pastel palette
    nb.cols <- nrow(table.revenues)
    mycolors <- grDevices::colorRampPalette(RColorBrewer::brewer.pal(8, "Pastel1"))(nb.cols)

    # Combine exchange with revenue!
    pie.data <- pie.data %>%
      mutate(my.label = paste0("$", .data$total.revenues, "\n", .data$revenue.type))
  }

  # Make the actual pie chart!
  pie <- pie.data %>%
    ggplot2::ggplot(ggplot2::aes(x = "", y = .data$total.revenues, fill = .data[[by]])) +
    ggplot2::geom_col(width = 2.5, colour = "black", linewidth = 1.5) +
    ggplot2::scale_fill_manual(values = mycolors) +
    ggplot2::coord_polar("y") +
    ggrepel::geom_label_repel(ggplot2::aes(y = .data$position, label = .data$my.label),
      size = 5, nudge_x = 1.5, show.legend = FALSE,
      label.padding = 0.5, box.padding = 0.5
    ) +
    ggplot2::theme_void() +
    ggplot2::theme(legend.position = "none")
  pie
}
