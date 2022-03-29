k_means_cluster <- function(input, output, session, data) {

    df <- subset(data,
                   select = c(income_1_avg, income_2_avg, networth_1_avg,
                              networth_2_avg, nght_cnt, tot_amt,
                              gst_cnt_sum, new_lifestage_id, churn_flag))
    set.seed(123)
      
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