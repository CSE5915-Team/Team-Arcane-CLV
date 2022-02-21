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
font_add("Arial Narrow", regular = "ARIALN.TTF")
font_add("Arial", regular = "arial.ttf")
showtext_auto()

source("preprocess.R", local = TRUE)
source("eda_after_churn.R", local =TRUE)
# generate clean data
generate_clean_data()

source("edaPage.R", local = TRUE)
source("eda_after_churn.R", local =TRUE)
# Define UI for application that draws a histogram
ui <- navbarPage("Customer Lifetime Value",
       tabPanel("EDA",
        eda_page
       ),
       tabPanel("EDA After Churn",
                eda_after_churn_page
       )
     )
  

# Define server logic required to draw a histogram
server <- function(input, output) {
  # generate clean data
  data <- read.csv("Cleandata.csv")
  output$plot_render_1 <- renderPlotly({
    ggplotly(data %>%
    filter(hshold_lifestage_last == input$household_lifestage) %>%
    filter((income_1_avg + income_2_avg) > input$income[1]) %>%
    filter((income_1_avg + income_2_avg) < input$income[2]) %>%
    filter((networth_1_avg + networth_2_avg) > input$networth[1]) %>%
    filter((networth_1_avg + networth_2_avg) < input$networth[2]) %>%
    filter(nght_cnt > input$night_count[1]) %>%
    filter(nght_cnt < input$night_count[2]) %>%
    ggplot(aes(x = nght_cnt, y = tot_amt, color = hshold_lifestage_last)) +
    ggtitle("Amount Spent vs. Night Count") +
    geom_point(size = 1) +
    geom_smooth(method = lm, color = "red", se = FALSE) +
    theme_ipsum() +
    xlab("Night Count") +
    scale_y_continuous("Total Amount ($)",
                       breaks = scales::breaks_extended(8),
                       labels = scales::label_dollar())  +
    labs(color = "Household Lifestage") +
    theme(plot.title = element_text(hjust = 0.5, family = "Arial",
                                    face = "bold", size = 16)))
  })
  output$plot_render_2 <- renderPlotly({
    ggplotly(data %>%
    filter(hshold_lifestage_last == input$household_lifestage) %>%
    filter((income_1_avg + income_2_avg) > input$income[1]) %>%
    filter((income_1_avg + income_2_avg) < input$income[2]) %>%
    filter((networth_1_avg + networth_2_avg) > input$networth[1]) %>%
    filter((networth_1_avg + networth_2_avg) < input$networth[2]) %>%
    filter(nght_cnt > input$night_count[1]) %>%
    filter(nght_cnt < input$night_count[2]) %>%
    ggplot(aes(x = nght_cnt, y = (income_1_avg + income_2_avg),
               color = hshold_lifestage_last)) +
    ggtitle("Total Income vs. Night Count") +
    geom_point(size = 1) +
    geom_smooth(method = lm, color = "red", se = FALSE) +
    theme_ipsum() +
    xlab("Night Count") +
    scale_y_continuous("Total Income ($)",
                       breaks = scales::breaks_extended(8),
                       labels = scales::label_dollar()
    ) +
    labs(color = "Household Lifestage") +
    theme(plot.title = element_text(hjust = 0.5,
                       family = "Arial", face = "bold", size = 16)))
  })
  output$plot_render_3 <- renderPlotly({
    ggplotly(data %>%
    filter(hshold_lifestage_last == input$household_lifestage) %>%
    filter((income_1_avg + income_2_avg) > input$income[1]) %>%
    filter((income_1_avg + income_2_avg) < input$income[2]) %>%
    filter((networth_1_avg + networth_2_avg) > input$networth[1]) %>%
    filter((networth_1_avg + networth_2_avg) < input$networth[2]) %>%
    filter(nght_cnt > input$night_count[1]) %>%
    filter(nght_cnt < input$night_count[2]) %>%
    filter(tot_amt <= 1000) %>%
    ggplot(aes(x = tot_amt)) +
    ggtitle("Amount Spent Histogram") +
    xlab("Amount Spent (bin = 100)") +
    ylab("Count") +
    geom_histogram(binwidth = 100))
  })
  
  source("cleandata_after_churn.R", local=TRUE)
  data <- modify_data_for_ecdf(data) 
  
  ecdf <- ggplot(data, aes(x = diff_btwn_dates_in_days)) + 
          scale_y_continuous(breaks = seq(0, 1, by = 0.2)) + 
          geom_vline(xintercept = c(2200), linetype="dotted") +
          ggtitle("ECDF for customers who visted after the first person stopped") +
          theme(plot.title = element_text(hjust = 0.5, family = "Arial",
                                    face = "bold", size = 16)) +
          xlab("Days")
  
  
  
  
  output$ecdf_plot_render <- renderPlot ({ecdf + stat_ecdf()})
  generate_after_churn_new_data(data, 0.2)
  
  
  
  churned_data <- read.csv("Cleandata_after_churn.csv")
  
  
   
  #Plots for all the graphs based on the churned data
  output$churn_plot_render_1 <- renderPlotly({
    ggplotly(churned_data %>%
               filter(hshold_lifestage_last == input$churn_household_lifestage) %>%
               filter((income_1_avg + income_2_avg) > input$churn_income[1]) %>%
               filter((income_1_avg + income_2_avg) < input$churn_income[2]) %>%
               filter((networth_1_avg + networth_2_avg) > input$churn_networth[1]) %>%
               filter((networth_1_avg + networth_2_avg) < input$churn_networth[2]) %>%
               filter(nght_cnt > input$churn_night_count[1]) %>%
               filter(nght_cnt < input$churn_night_count[2]) %>%
               ggplot(aes(x = nght_cnt, y = tot_amt, color = hshold_lifestage_last)) +
               ggtitle("Amount Spent vs. Night Count") +
               geom_point(size = 1) +
               geom_smooth(method = lm, color = "red", se = FALSE) +
               theme_ipsum() +
               xlab("Night Count") +
               scale_y_continuous("Total Amount ($)",
                                  breaks = scales::breaks_extended(8),
                                  labels = scales::label_dollar())  +
               labs(color = "Household Lifestage") +
               theme(plot.title = element_text(hjust = 0.5, family = "Arial",
                                               face = "bold", size = 16)))
  })
  output$churn_plot_render_2 <- renderPlotly({
    ggplotly(churned_data %>%
               filter(hshold_lifestage_last == input$churn_household_lifestage) %>%
               filter((income_1_avg + income_2_avg) > input$churn_income[1]) %>%
               filter((income_1_avg + income_2_avg) < input$churn_income[2]) %>%
               filter((networth_1_avg + networth_2_avg) > input$churn_networth[1]) %>%
               filter((networth_1_avg + networth_2_avg) < input$churn_networth[2]) %>%
               filter(nght_cnt > input$churn_night_count[1]) %>%
               filter(nght_cnt < input$churn_night_count[2]) %>%
               ggplot(aes(x = nght_cnt, y = (income_1_avg + income_2_avg),
                          color = hshold_lifestage_last)) +
               ggtitle("Total Income vs. Night Count") +
               geom_point(size = 1) +
               geom_smooth(method = lm, color = "red", se = FALSE) +
               theme_ipsum() +
               xlab("Night Count") +
               scale_y_continuous("Total Income ($)",
                                  breaks = scales::breaks_extended(8),
                                  labels = scales::label_dollar()
               ) +
               labs(color = "Household Lifestage") +
               theme(plot.title = element_text(hjust = 0.5,
                                               family = "Arial", face = "bold", size = 16)))
  })
  output$churn_plot_render_3 <- renderPlotly({
    ggplotly(churned_data %>%
               filter(hshold_lifestage_last == input$churn_household_lifestage) %>%
               filter((income_1_avg + income_2_avg) > input$churn_income[1]) %>%
               filter((income_1_avg + income_2_avg) < input$churn_income[2]) %>%
               filter((networth_1_avg + networth_2_avg) > input$churn_networth[1]) %>%
               filter((networth_1_avg + networth_2_avg) < input$churn_networth[2]) %>%
               filter(nght_cnt > input$churn_night_count[1]) %>%
               filter(nght_cnt < input$churn_night_count[2]) %>%
               filter(tot_amt <= 1000) %>%
               ggplot(aes(x = tot_amt)) +
               ggtitle("Amount Spent Histogram") +
               xlab("Amount Spent (bin = 100)") +
               ylab("Count") +
               geom_histogram(binwidth = 100))
  })
}

# Run the application
shinyApp(ui, server)
