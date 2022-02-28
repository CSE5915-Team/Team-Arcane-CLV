# Binary Graph plot render
churn_vs_not_churn_plot_server <- function(data){
  bar_graph <- ggplot(data, aes(x = churn_flag)) +
    geom_bar() +
    ggtitle("Churn vs Not Churn") +
    theme(plot.title = element_text(hjust = 0.5, family = "Arial", face = "bold", size = 16)) +
    xlab("Churn Flag") +
    ylab("Number of Customers") +
    coord_flip()
  
  return(renderPlot({bar_graph}))
}