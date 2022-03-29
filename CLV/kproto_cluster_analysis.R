kproto_cluster_table <- function(input, output, session, data){
  x1 <- as.factor(data$hshold_lifestage_last)
  x2 <- as.numeric(data$income_1_avg)
  x3 <- as.numeric(data$income_2_avg)
  x4 <- as.numeric(data$networth_1_avg)
  x5 <- as.numeric(data$networth_2_avg)
  x8 <- as.numeric(data$nght_cnt)
  x9 <- as.numeric(data$tot_amt)
  x10 <- as.numeric(data$customer_lifetime)
  x11 <- as.numeric(data$churn_flag)
  df <- data.frame(x1, x2, x3, x4, x5, x8, x9, x10, x11)
  
  set.seed(123)
  
  # Now, we want to cluster with the optimal number of clusters
  k_proto_cluster <- kproto(df, k = input$kProto_cluster_num, iter.max = 10)
  names <- paste("Cluster ", 1:input$kProto_cluster_num, sep="")
  proportions <- c()
  df['cluster'] <- k_proto_cluster$cluster
  for(x in 1:input$kProto_cluster_num) {
    cluster_subset <- 
      total_clust <- nrow(subset(df, cluster == x, select=x11))
    total_churn <- nrow(subset(df, cluster == x & x11 == 1, select=x11))
    prop = total_churn/total_clust
    proportions <- c(proportions, prop)
  }
  table_frame = data.frame(matrix(NA, nrow = 0, ncol = input$kProto_cluster_num))
  colnames(table_frame) <- names
  table_frame[1,] <- proportions
  return(table_frame)
}