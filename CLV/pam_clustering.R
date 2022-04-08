pam_cluster <- function(input, output, session, df) {

  # Now, we want to cluster with the optimal number of clusters
  pam <- pam(df, k = input$pam_cluster_num)
  # visualize our clusters
  cluster_plot <- fviz_cluster(pam, data = df,
                               geom = "point",
                               ellipse.type = "convex",
                               ggtheme = theme_bw()
  )
  
  x <- pam$cluster
  write.csv(x, "pam.csv")
  
  return(cluster_plot)
}
