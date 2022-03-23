library("ggdendro")
h_cluster <- function(input, output, session, data) {
  
  df <- subset(data,
               select = c(income_1_avg, income_2_avg, networth_1_avg,
                          networth_2_avg, nght_cnt, tot_amt,
                          gst_cnt_sum, new_lifestage_id))
  
  # Now, we want to cluster with the optimal number of clusters
  d <- dist(df, method = "euclidean")
  
  hclus <- hclust(d, method = "complete" )
  # visualize our clusters
  cluster_plot <- ggdendrogram(hclus, rotate= FALSE, size = 2)
  
  return(cluster_plot)
}