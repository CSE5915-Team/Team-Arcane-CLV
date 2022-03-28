kmeans_cluster_table <- function(input, output, session, data){
  df <- subset(data,
               select = c(income_1_avg, income_2_avg, networth_1_avg,
                          networth_2_avg, nght_cnt, tot_amt,
                          gst_cnt_sum, new_lifestage_id, churn_flag))
  
  set.seed(123)
  
  km <-kmeans(df, input$kmeans_cluster_num, iter.max = 20, nstart = 100)
  
  names <- paste("Cluster ", 1:input$kmeans_cluster_num, sep="")
  proportions <- c()
  df['cluster'] <- km$cluster
  for(x in 1:input$kmeans_cluster_num) {
    cluster_subset <- 
      total_clust <- nrow(subset(df, cluster == x, select=churn_flag))
    total_churn <- nrow(subset(df, cluster == x & churn_flag == 1, select=churn_flag))
    prop = total_churn/total_clust
    proportions <- c(proportions, prop)
  }
  table_frame = data.frame(matrix(NA, nrow = 0, ncol = input$kmeans_cluster_num))
  colnames(table_frame) <- names
  table_frame[1,] <- proportions
  return(table_frame)
}