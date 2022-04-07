
#Combines individual cluster dataframes into one dataframe

downloadClusterData <- function(kmeans, pam, kmode, kproto) {
  
  cluster_list <- list(kmeans, pam, kmode, kproto)
  cluster_data <- Reduce(function(x, y) merge(x, y, all=TRUE), cluster_list)  
  return(cluster_data)
}

# Combines all the data to give one final data frame with data analysis
downloadAllData <- function(cluster_data, churned_data){
  df_list <- list(cluster_data, churned_data)
  xCol = c("customer_id")
  yCol = c("ID")
  all_data <- merge(churned_data, cluster_data, by.x = xCol, by.y = yCol , all.x = TRUE)
  return(all_data)
}