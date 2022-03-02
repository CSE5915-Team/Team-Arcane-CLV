library("factoextra")

kMeansElbow <- function(input, output, session, data) {

df <- subset(data,
             select = c(income_1_avg, income_2_avg, networth_1_avg,
                        networth_2_avg, nght_cnt, tot_amt,
                        gst_cnt_sum, new_lifestage_id))  
# first, we want to calculate the optimal number of clusters  
elbowPlot <- fviz_nbclust(df, kmeans, method = "wss") +
  geom_vline(xintercept = 4, linetype = 2)+
  labs(subtitle = "Elbow method")


return(elbowPlot)
}