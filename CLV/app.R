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
source("edaAfterChurnPage.R", local = TRUE)

source("eda_plot1_func.R", local = TRUE)
source("eda_plot2_func.R", local = TRUE)
source("eda_plot3_func.R", local = TRUE)

source("funcs_for_churning_data.R", local = TRUE)
source("churn_eda_plot1_func.R", local = TRUE)
source("churn_eda_plot2_func.R", local = TRUE)
source("churn_eda_plot3_func.R", local = TRUE)
source("corrolationMatrix.R", local = TRUE)
source("kMeans_Clustering.R", local = TRUE)
source("churn_vs_not_churn_plot_render.R", local=TRUE)
source("ecdf_plot_func.R", local = TRUE)

data <- read.csv("Cleandata.csv")

# Define UI for application that draws a histogram
ui <- navbarPage("Customer Lifetime Value",
  tabPanel("About", about_page()),
  tabPanel("EDA", eda_page()),
  tabPanel("EDA After Churn", eda_after_churn_page())
)
  

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  # generate clean data
  print("Plot Rendering Beginning.")
  output$plot_render_1 <- plot1_server(input, output, session)
  output$plot_render_2 <- plot2_server(input, output, session)
  output$plot_render_3 <- plot3_server(input, output, session)
  
  data <- modify_data_for_ecdf(data)
  output$ecdf_plot_render <- ecdf_plot_server(data)
  data <- add_churn_flag(data)
  output$churn_vs_not_churn_plot_render <- churn_vs_not_churn_plot_server(data) 
  generate_after_churn_new_data(data, 0.2)
  churned_data <- read.csv("Cleandata_after_churn.csv")
  
  #Plots for all the graphs based on the churned data
  output$churn_plot_render_1 <- churn_plot1_server(input, output, session, churned_data)
  output$churn_plot_render_2 <- churn_plot2_server(input, output, session, churned_data)
  output$churn_plot_render_3 <- churn_plot3_server(input, output, session, churned_data)
  output$churn_plot_render_4 <- renderPlot({corrolationMatrix(input, output, session, churned_data)})
  print("Plot Rendering Done.")
}

# Run the application
shinyApp(ui, server)
