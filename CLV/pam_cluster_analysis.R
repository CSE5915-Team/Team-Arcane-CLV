pam_cluster_table <- function(input, output, session, data){
  df <- subset(data,
               select = c(income_1_avg, income_2_avg, networth_1_avg,
                          networth_2_avg, nght_cnt, tot_amt,
                          gst_cnt_sum, new_lifestage_id, churn_flag))
  
  set.seed(123)
  
  # Now, we want to cluster with the optimal number of clusters
  pam <- pam(df, k = input$pam_cluster_num)
  names <- paste("Cluster ", 1:input$pam_cluster_num, sep="")
  proportions <- c()
  df['cluster'] <- pam$cluster
  for(x in 1:input$pam_cluster_num) {
    cluster_subset <- 
    total_clust <- nrow(subset(df, cluster == x, select=churn_flag))
    total_churn <- nrow(subset(df, cluster == x & churn_flag == "Churn", select=churn_flag))
    prop = total_churn/total_clust
    proportions <- c(proportions, prop)
  }
  table_frame = data.frame(matrix(NA, nrow = 0, ncol = input$pam_cluster_num))
  colnames(table_frame) <- names
  table_frame[1,] <- proportions
  return(table_frame)
}