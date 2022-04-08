k_means_cluster <- function(input, output, session, df) {
      
    # Now, we want to cluster with the optimal number of clusters
    kmean <-kmeans(df, input$kmeans_cluster_num, iter.max = 20, nstart = 100)
    # visualize our clusters
    cluster_plot <- fviz_cluster(kmean, data = df, 
                 geom = "point",
                 ellipse.type = "convex", 
                 ggtheme = theme_bw()
    )
    
  
    x <- kmean$cluster
    write.csv(x, "kmeans.csv")
    
    
    return(cluster_plot)
}