churn_plot1_server <- function(input, output, session, data) {
  churn_plot_render_1 <- renderPlotly({
    ggplotly(data %>%
               filter(hshold_lifestage_last == input$churn_household_lifestage) %>%
               filter((income_1_avg + income_2_avg) > input$churn_income[1]) %>%
               filter((income_1_avg + income_2_avg) < input$churn_income[2]) %>%
               filter((networth_1_avg + networth_2_avg) > input$churn_networth[1]) %>%
               filter((networth_1_avg + networth_2_avg) < input$churn_networth[2]) %>%
               filter(nght_cnt > input$churn_night_count[1]) %>%
               filter(nght_cnt < input$churn_night_count[2]) %>%
               ggplot(aes(x = customer_lifetime, y = churn_probabilites, color = hshold_lifestage_last)) +
               ggtitle("Churn Probability vs. Customer Lifetime") +
               geom_point(size = 1) +
               geom_smooth(method = lm, color = "red", se = FALSE) +
               theme_ipsum() +
               xlab("Customer Lifetime") +
               labs(color = "Household Lifestage") +
               theme(plot.title = element_text(hjust = 0.5, family = "Arial",
                                               face = "bold", size = 16)))
  })
  return(churn_plot_render_1)
}