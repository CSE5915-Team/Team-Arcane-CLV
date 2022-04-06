library("shinycssloaders")
corrolation_matrix_whisker_page <- function() {
  fluidPage(
    # Application title
    titlePanel("Correlation Matrix"),
    # Fluid rows layout
    fluidRow(
      plotOutput("corrolation_matrix") %>% withSpinner(type = 5)
    )
  )
}