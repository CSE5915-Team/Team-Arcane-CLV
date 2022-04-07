library("ggdendro")
h_cluster <- function(input, output, session, df) {
  
  # Now, we want to cluster with the optimal number of clusters
  d <- dist(df, method = "euclidean")
  
  hclus <- hclust(d, method = "complete" )
  # visualize our clusters
  h_cluster_plot <- ggdendrogram(hclus, rotate= FALSE, size = 2)
  
  return(h_cluster_plot)
}