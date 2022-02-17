plot3_server <- function(input, output, session) {
  plot_render_3 <- renderPlotly({
    ggplotly(data %>%
     filter(hshold_lifestage_last %in% input$household_lifestage) %>%
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
  return(plot_render_3)
}