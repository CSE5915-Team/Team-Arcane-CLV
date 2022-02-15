#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(plotly)
library(hrbrthemes)
library(showtext)
font_add("Arial Narrow", regular = "ARIALN.TTF")
font_add("Arial", regular = "arial.ttf")
showtext_auto()
source("edaPage.R", local = TRUE)
# Define UI for application that draws a histogram
ui <- navbarPage("Customer Lifetime Value",
       tabPanel("EDA",
        eda_page
       )
     )
  

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$plot_render_1 <- renderPlotly(plot1)
  output$plot_render_2 <- renderPlotly(plot2)
  output$plot_render_3 <- renderPlotly(plot3)
}

# Run the application
shinyApp(ui = ui, server = server)
