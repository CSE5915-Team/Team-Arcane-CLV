about_page <- fluidPage(
  # uses the readme for github
  fluidRow(
    htmltools::includeMarkdown("../README.md")
  )
)
