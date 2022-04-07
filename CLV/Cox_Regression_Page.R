library("shinycssloaders")

coxRegressionPage <- function() {
  fluidPage(
    titlePanel("Cox Regression"),
    fluidRow(
      plotOutput("coxreg") %>% withSpinner(type = 5)
    )
  )
}