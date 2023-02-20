.onAttach <- function(libname, pkgname) {
  options("pboptions" = list(
    type = if (interactive()) "timer" else "none",
    char = "[=-]",
    txt.width = 50,
    gui.width = 300,
    style = 5,
    initial = 0,
    title = "Progress bar (cryptoTax)",
    label = "Superficial losses in progress",
    nout = 100L,
    min_time = 2
  ))
  invisible(NULL)
}
