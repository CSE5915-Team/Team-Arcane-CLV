source("downloadClusteringData.R", local = TRUE)

k_mode_cluster <- function(input, output, session, df) {
  
  km <- kmodes(df, modes = input$kMode_cluster_num, iter.max=10, weighted = FALSE)
  kMode_Cluster_Plot <- clusplot(df, km$cluster, color=TRUE, shade=TRUE, lines=2, span=TRUE, stand=TRUE, labels=1)
  


  x <- km$cluster
  write.csv(x, "kmode.csv")
  
  
  return(kMode_Cluster_Plot)
  
  
}
