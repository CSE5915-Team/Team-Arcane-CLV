pam_cluster <- function(input, output, session, data) {

  df <- subset(data,
               select = c(income_1_avg, income_2_avg, networth_1_avg,
                          networth_2_avg, nght_cnt, tot_amt,
                          gst_cnt_sum, new_lifestage_id))

  # Now, we want to cluster with the optimal number of clusters
  pam <- pam(df, k = input$pam_cluster_num)
  # visualize our clusters
  cluster_plot <- fviz_cluster(pam, data = df,
                               geom = "point",
                               ellipse.type = "convex",
                               ggtheme = theme_bw()
  )
  return(cluster_plot)
}
