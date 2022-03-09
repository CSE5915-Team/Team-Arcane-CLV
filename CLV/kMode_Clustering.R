library("cluster")
library("fpc")
library("klaR")
kModeCluster <- function(input, output, session, data) {
  
  df <- subset(data,
               select = c(income_1_avg, income_2_avg, networth_1_avg,
                          networth_2_avg, nght_cnt, tot_amt,
                          gst_cnt_sum, new_lifestage_id))    
  
  km <- kmodes(df, modes = input$kMode_cluster_num, iter.max=10, weighted = FALSE)
  kMode_Cluster_Plot <- clusplot(df, km$cluster, color=TRUE, shade=TRUE, lines=2, span=TRUE, stand=TRUE, labels=1)
  return(kMode_Cluster_Plot)
  
  
}
