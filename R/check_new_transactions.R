#' @title Check for new transactions
#'
#' @description Check for new transactions for a given exchange
#' @param data The dataframe
#' @param known.transactions A list of known transactions
#' @param transactions.col The name of the transaction column
#' @param description.col The name of the description column,
#' if available.
#' @return A warning, if there are new transactions. Returns
#' nothing otherwise.
#' @export
#' @examples
#' data <- data_CDC[1:5, ]
#' known.transactions <- c("crypto_purchase", "lockup_lock")
#' check_new_transactions(data, 
#'                        known.transactions = known.transactions,
#'                        transactions.col = "Transaction.Kind",
#'                        description.col = "Transaction.Description")
#' @importFrom dplyr %>% rename mutate select filter bind_rows
#' @importFrom rlang .data

check_new_transactions <- function(data, 
                                   known.transactions, 
                                   transactions.col,
                                   description.col = NULL) {
  
  if (!transactions.col %in% names(data)) {
    stop("Column '", transactions.col, "' not found in data frame. Double-check for typos.")
  } else if (!is.null(description.col) && !description.col %in% names(data)) {
    stop("Column '", description.col, "' not found in data frame. Double-check for typos.")
  }
  
  new.transactions <- !unique(data[[transactions.col]]) %in% known.transactions
  
  if (any(new.transactions)) {
    new.transactions.names <- unique(data[[transactions.col]])[new.transactions]
    new.transactions.names <- paste(new.transactions.names, collapse = ", ")
    
    if (!is.null(description.col)) {
      new.des.names <- data %>%
        filter(!data[[transactions.col]] %in% known.transactions) %>%
        pull(.data[[description.col]]) %>%
        unique()
      new.des.names <- paste(new.des.names, collapse = ", ")  
      new.des.names <- paste0(". Associated descriptions: ", new.des.names)
    } else {
      new.des.names <- ""
    }
    
    warning(
      "New transaction types detected! These may be unaccounted for: ",
      new.transactions.names, new.des.names
    )
  }
  
}
