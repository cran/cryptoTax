# cryptoTax 0.0.5

- Added CRAN requirements

# cryptoTax 0.0.4

- Added CRAN requirements

# cryptoTax 0.0.3

- Added CRAN requirements

# cryptoTax 0.0.2

**Breaking changes:**

- We get rid of the `format_wealtsimple()`, `format_BSC()`, `format_binance_trades()`, `crypto2fiat()`, and `fetch_prices()` functions, since their goal is better fulfilled by the new `format_generic()`, `format_binance()`, `match_prices()`, and `prepare_list_prices()` functions, respectively.

**New Features:**

- New `pkgdown` website with three vignettes: (1) calculating ACB, (2) full tax report, and (3) tax treatments and decisions.
- Informative progress bars with `format_ACB()` and `format_suploss()` since these functions are extremely slow with thousands of transactions.
- Added example data sets (ACB, cryptotaxcalculator, coinpanda, koinly, shakepay, CDC, CDC exchange rewards, CDC exchange trades, CDC wallet, adalite, binance, binance withdrawals, blockfi, celsius, coinsmart, exodus, newton, presearch, pooltool, gemini, uphold)
- Now detects new transaction types not accounted for
- New functions: 
    - `prepare_report()` to get all the required information for `print_report()` in one go.
    - `get_sup_losses` was it was the last missing piece to get all the info needed for `prepare_report()`.
    - `format_detect()`, to automatically detect the right exchange and process it with the corresponding function (also supports lists of exchanges).
    - `format_generic()`, to process most transaction history files not supported by existing functions.
    - `format_binance()`, a general version that works with the general transaction report and includes rewards (but not withdrawal fees). We thus get rid of `format_binance_trades()` since the former is superior (as it includes more transaction types).
    - `get_latest_transactions()`: get latest transaction date by exchange
    - `check_missing_transactions()`: show you rows with negative total balances to help identify missing transactions.
    - `format_dollars()`: to format numeric values with comma for thousands separator.

**Improvements:**

- `format_blockfi()` and `format_CDC_exchange_trades()` now correctly match prices for purchases and sales for trades (instead of relying on their corresponding daily spot rates).
- Consistently use plural for reward types.
- Massive improvements in speed by using joins for price lookups (instead of making a new API request for each row) for both prices of coins and USD to CAD conversions.
- When prices are fetched through `priceR` (for USD to CAD conversions), now indicates the source of the price accordingly (`rate.source = "exchange (USD conversion)"`)
- All `format_*` functions: now reorder columns in a consistent fashion + tests for all (and `ACB()`).
- `ACB_suploss()`: integrates the primary `ACB()` function, which accordingly gains a new logical argument, `suploss`.
- `format_suploss()`: integrates `ACB()` when `suploss = TRUE`, and gains a greatly improved code base.
- `add_quantities()`: switches from a for-loop to `dplyr` code.
- `ACB()`: 
    - new warning messages:
        - when not providing first buy transactions (so no ACB...)
        - when more than one currency are provided at a time
        - when insufficient columns are provided to calculate 'total.price'
- `report_revenues()` and `crypto_pie()`: Now support forks and mining.
- `format_newton()`: updated to the new format
- `format_CDC()`: 
    - new warning message when withdrawal fees could not be detected automatically.
    - new transaction types supported: forks ("admin_wallet_credited"), sales ("crypto_viban_exchange", "card_top_up", "crypto_wallet_swap_debited"), and supercharger rewards ("supercharger_reward_to_app_credited")
    - On coinmarketcap, after 2022-05-28, LUNA gets renamed to LUNC, and the LUNA2 fork gets renamed to LUNA. This is confusing because on CDC, they use the terms LUNA and LUNC (which are the same), and LUNA2, which is the new LUNA fork. Therefore, we now rename "LUNA" transactions (on CDC) to "LUNC", and "LUNA2" to "LUNA".

**Bug Fixes:**

- `format_shakepay()`: now correctly detects CAD referral rewards
- `format_binance()`: now correctly detects interest rewards
- `format_ACB()`: 
    - fixed a bug whereas a superficial loss of quantity = 0 would prevent the computation of the ACB.
    - corrected "Total time elapsed:" time unit to always be minutes
- `ACB()`: now correctly accept alternative column names
- Fixed a bug for NANO/XNO
- Fixed various R CMD check errors, warnings, and notes.

# cryptoTax 0.0.1

New package
