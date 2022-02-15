source("EDAChartData/chart1.R", local = TRUE)
data <- read.csv("Cleandata.csv")

eda_page <- fluidPage(
  # Application title
  titlePanel("Exploratory Data Analysis"),
  # Fluid rows layout
  fluidRow(
    column(6,
      # Basic pie chart
      plotlyOutput("plot_render_1")
      ),
    column(6,
      plotlyOutput("plot_render_2")
      )
  ),
  fluidRow(
    column(6,
      plotlyOutput("plot_render_3")
      ),
    column(6,
      sliderInput("income",
                  "Total Income",
                  width = "100%",
                  min = min(data["income_1_avg"]),
                  max = max(data["income_1_avg"]),
                  value = c(min(data["income_1_avg"]), max(data["income_1_avg"])))
      )
  )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  
    
    data2<-data[data$income_1_avg>=input$income[1] & data$income_1_avg<=input$income[2],] #This creates a dataframe of only the data points in which the
                                                                                          #income_1_avg is within the range of the slider
    ggplot1 <- ggplot(data2, aes(x = nght_cnt, y = tot_amt, color = hshold_lifestage_last)) +
      ggtitle("Night count vs. Total Amount") +
      geom_point(size = 3) +
      geom_smooth(method = lm, color = "red", se = FALSE) +
      theme_ipsum() +
      xlab("Night Count") +
      ylab("Total Amount ($)") +
      labs(color = "Household Lifestage") +
      theme(plot.title = element_text(hjust = 0.5, family = "Arial", face = "bold", size = 16))
    plot1 <- ggplotly(ggplot1)
    
    
    
    ggplot2 <- ggplot(data2, aes(x = nght_cnt, y = (income_1_avg + income_2_avg), color = hshold_lifestage_last)) +
      ggtitle("Night Count vs. Sum of Income Averages") +
      geom_point(size = 3) +
      geom_smooth(method = lm, color = "red", se = FALSE) +
      theme_ipsum() +
      xlab("Night Count") +
      ylim(0, 600000) +
      ylab("Sum of Income Averages ($)") +
      labs(color = "Household Lifestage") +
      theme(plot.title = element_text(hjust = 0.5, family = "Arial", face = "bold", size = 16))
    plot2 <- ggplotly(ggplot2)
    
    output$plot_render_1 <- renderPlotly(plot1)
    output$plot_render_2 <- renderPlotly(plot2)
  
  


  #plot3_font <- list(size = 16, x = 0.5, family = "Arial")
  #plot3 <- plot_ly(type = "scatter", mode = "markers", data = iris, x = ~Sepal.Length, y = ~Petal.Length, color = ~Species) %>%
  # layout(title = list(text = "<b>Sample Chart 3</b>", font = plot3_font))
  # output$plot_render_3 <- renderPlotly(plot3)
  
  
}




