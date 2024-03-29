cox_regression <- function(input, data, filename, cluster_num) {
  # Get clusters for each entry
  print(filename)
  cluster <- read.csv(filename)[-1]
  
  # Change name of cluster column to 'cluster'
  colnames(cluster) <- c("cluster")
  
  # Add clusters to data
  cluster_data <- cbind(data, cluster)
  
  attach(cluster_data)
  
  clusters <- 1:cluster_num
  names <- paste("Cluster ", 1:cluster_num, sep="")
  
  # Cox regression plotting
  res.cox <- coxph(Surv(customer_lifetime, churn_flag) ~ cluster + income_1_avg + income_2_avg + networth_1_avg + networth_2_avg, data = cluster_data) 
  cluster_df <- with(cluster_data,
                        data.frame(cluster = clusters,
                                   income_1_avg = rep(mean(income_1_avg, na.rm = TRUE), cluster_num),
                                   income_2_avg = rep(mean(income_2_avg, na.rm = TRUE), cluster_num),
                                   networth_1_avg = rep(mean(networth_1_avg, na.rm = TRUE), cluster_num),
                                   networth_2_avg = rep(mean(networth_2_avg, na.rm = TRUE), cluster_num)               
                                   )
                        
                     )
  
  fit <- survfit(res.cox, newdata = cluster_df)
  coxPlot <- ggsurvplot(fit, data = cluster_data, conf.int = TRUE, legend.labs = names, ggtheme = theme_minimal())
  
  return(coxPlot) 
}