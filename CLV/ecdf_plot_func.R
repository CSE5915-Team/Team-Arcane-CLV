ecdf_plot_server <- function(data) {
  ecdf <- ggplot(data, aes(x = diff_btwn_dates_in_days)) +
    scale_y_continuous(breaks = seq(0, 1, by = 0.2)) +
    geom_vline(xintercept = c(2200), linetype = "dotted") +
    ggtitle("ECDF for customers who visted after the first person stopped") +
    theme(plot.title = element_text(hjust = 0.5, family = "Arial",
                                    face = "bold", size = 16)) +
    xlab("Days")
  return(renderPlot({ecdf + stat_ecdf()}))
}