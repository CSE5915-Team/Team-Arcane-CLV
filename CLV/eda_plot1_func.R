plot1_server <- function(input, output, session) {
  
  x_axis = reactive(
    if("tot_amt" %in% input$x_axis) return(data$tot_amt)
  )
  y_axis = reactive(
    if("nght_cnt" %in% input$y_axis) return(data$nght_cnt)
    )
  plot_render_1 <- renderPlotly({
   plot(x_axis, y_axis)
  })
  # 
  # plot_render_1 <- renderPlotly({
  #   w <- ggplotly(data %>%
  #     filter(hshold_lifestage_last %in% input$household_lifestage) %>%
  #     filter((income_1_avg + income_2_avg) > input$income[1]) %>%
  #     filter((income_1_avg + income_2_avg) < input$income[2]) %>%
  #     filter((networth_1_avg + networth_2_avg) > input$networth[1]) %>%
  #     filter((networth_1_avg + networth_2_avg) < input$networth[2]) %>%
  #     filter(nght_cnt > input$night_count[1]) %>%
  #     filter(nght_cnt < input$night_count[2]) %>%
  #     ggplot(aes(x = x_axis, y = y_axis, color = hshold_lifestage_last)) +
  #     geom_point(size = 1,
  #                aes(text = paste0("<b>", hshold_lifestage_last, "</b><br>",
  #                                  "X: ", x_axis, "<br>",
  #                                  "Y: ", y_axis, "<br>")
  #                )
  #     ) +
  #     geom_smooth(formula = y ~ x, method = lm, color = "red", se = FALSE) +
  #     theme_ipsum() +
  #     xlab(x_axis) +
  #     ylab(y_axis) +
  #     scale_y_continuous("Y",
  #                        breaks = scales::breaks_extended(8),
  #                        labels = scales::label_dollar())  +
  #     labs(color = "Household Lifestage") +
  #     theme(plot.title = element_text(hjust = 0.5, family = "Arial",
  #                                     face = "bold", size = 16)), tooltip = c("text"))
  #     text_2 <- paste0("Smoothed <br>", "X: ", x_axis, "<br>",
  #                    "Y: ", y_axis, "<br>")
  #   w %>%
  #     style(text = text_2, traces = 2)
  # })
  return(plot_render_1)
}