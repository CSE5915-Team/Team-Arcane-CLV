library("shinycssloaders")
corrolation_matrix_whisker_page <- function() {
  fluidPage(
    # Application title
    titlePanel("Correlation Matrix"),
    # Fluid rows layout
    fluidRow(
      plotOutput("Correlation_matrix") %>% withSpinner(type = 5)
    ),
    fluidRow(
      titlePanel("Whisker plots for Churn/Non-Churn") %>% withSpinner(type = 5)
    ),
    fluidRow(
      plotOutput("whisker_plot")
    )
  )
}