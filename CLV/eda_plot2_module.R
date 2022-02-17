plot2_server <- function(input, output, session) {
  plot_render_2 <- renderPlotly({
    w <- ggplotly(data %>%
      filter(hshold_lifestage_last %in% input$household_lifestage) %>%
      filter((income_1_avg + income_2_avg) > input$income[1]) %>%
      filter((income_1_avg + income_2_avg) < input$income[2]) %>%
      filter((networth_1_avg + networth_2_avg) > input$networth[1]) %>%
      filter((networth_1_avg + networth_2_avg) < input$networth[2]) %>%
      filter(nght_cnt > input$night_count[1]) %>%
      filter(nght_cnt < input$night_count[2]) %>%
      ggplot(aes(x = nght_cnt, y = (income_1_avg + income_2_avg),
                 color = hshold_lifestage_last)) +
      ggtitle("Total Income vs. Night Count") +
      geom_point(size = 1,
                 aes(
                   text = paste0("<b>", hshold_lifestage_last, "</b><br>",
                                 "Night Count: ", nght_cnt, "<br>",
                                 "Income Sum: ", scales::dollar(income_1_avg + income_2_avg), "<br>")
                 )
      ) +
      geom_smooth(method = lm, color = "red", se = FALSE) +
      theme_ipsum() +
      xlab("Night Count") +
      scale_y_continuous("Total Income ($)",
                         breaks = scales::breaks_extended(8),
                         labels = scales::label_dollar()
      ) +
      labs(color = "Household Lifestage") +
      theme(plot.title = element_text(hjust = 0.5,
                                      family = "Arial", face = "bold", size = 16)), tooltip = c("text"))
    text_2 <- paste0("Smoothed <br>", "Night Count: ", w$x$data[[2]]$x, "<br>",
                     "Income Sum: ", w$x$data[[2]]$y, "<br>")
    w %>%
      style(text = text_2, traces = 2)
  })
  return(plot_render_2)
}