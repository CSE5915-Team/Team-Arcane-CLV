library("factoextra")



kMeansCluster <- function(input, outputput, sesssion, data) {

df <- subset(data,
             select = c(income_1_avg, income_2_avg, networth_1_avg,
                        networth_2_avg, nght_cnt, tot_amt,
                        gst_cnt_sum, new_lifestage_id,))  
  
# first, we want to calculate the optimal number of clusters  
elbowPlot <- fviz_nbclust(df, kmeans, method = "wss") +
  geom_vline(xintercept = 4, linetype = 2)+
  labs(subtitle = "Elbow method")

# Now, we want to cluster with the optimal number of clusters
kmean <-kmeans(df, 4, iter.max = 10, nstart = 1)
# visualize our clusters
cluster_plot <- fviz_cluster(kmean, data = df, palette = c("#2E9FDF", "#00AFBB", "#E7B800"), 
             geom = "point",
             ellipse.type = "convex", 
             ggtheme = theme_bw()
)

return [elbowPlot, cluster_plot]
}
