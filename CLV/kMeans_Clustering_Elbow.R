KMeansElbow <- function(input, output, session, df) {
  
  # first, we want to calculate the optimal number of clusters  
  elbowPlot <- fviz_nbclust(df, kmeans, method = "wss") +
    geom_vline(xintercept = 4, linetype = 2)+
    labs(subtitle = "Elbow method")
  
  
  return(elbowPlot)
}