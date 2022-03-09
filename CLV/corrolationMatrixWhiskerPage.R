library("shinycssloaders")
corrolation_matrix_whisker_page <- function() {
  fluidPage(
    # Application title
    titlePanel("Corrolation Matrix"),
    # Fluid rows layout
    fluidRow(
      plotOutput("corrolation_matrix") %>% withSpinner(type = 5)
    ),
    fluidRow(
      titlePanel("Whisker plots for Churn/Non-Churn") %>% withSpinner(type = 5)
    ),
    fluidRow(
      plotOutput("whisker_plot")
    )
  )
}