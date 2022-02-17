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
library(tidyverse)
library(lintr)
font_add("Arial Narrow", regular = "ARIALN.TTF")
font_add("Arial", regular = "arial.ttf")
showtext_auto()

source("preprocess.R", local = TRUE)
# generate clean data
generate_clean_data()

source("edaPage.R", local = TRUE)
source("aboutPage.R", local = TRUE)
source("eda_plot1_module.R", local = TRUE)
source("eda_plot2_module.R", local = TRUE)
source("eda_plot3_module.R", local = TRUE)

data <- read.csv("Cleandata.csv")

# Define UI for application that draws a histogram
ui <- navbarPage("Customer Lifetime Value",
  tabPanel("About",
    about_page()
  ),
  tabPanel("EDA",
    eda_page()
  )
)
  

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  print("Plot Render Beginning.")
  # generate clean data
  output$plot_render_1 <- plot1_server(input, output, session)

  output$plot_render_2 <- plot2_server(input, output, session)

  output$plot_render_3 <- plot3_server(input, output, session)

  print("Plot Render Done.")
}

# Run the application
shinyApp(ui, server)
