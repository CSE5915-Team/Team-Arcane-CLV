corrolation_matrix_whisker_page <- function() {
  fluidPage(
    # Application title
    titlePanel("Corrolation Matrix"),
    # Fluid rows layout
    fluidRow(
      plotOutput("corrolation_matrix")
    ),
    fluidRow(
      titlePanel("Whisker plots for Churn/Non-Churn")
    ),
    fluidRow(
      plotOutput("whisker_plot")
    )
  )
}