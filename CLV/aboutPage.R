about_page <- function() {
  fluidPage(
    # uses the readme for github
    fluidRow(
      htmltools::includeMarkdown("../README.md")
    )
  )
}