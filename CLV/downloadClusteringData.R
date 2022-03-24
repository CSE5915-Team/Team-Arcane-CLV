
#Combines individual cluster dataframes into one dataframe

downloadClusterData <- function(kmeans, pam, kmode, kproto) {
  
  cluster_list <- list(kmeans, pam, kmode, kproto)
  #cluster_data <- cluster_list %>% reduce(full_join, by="")
  cluster_data <- Reduce(function(x, y) merge(x, y, all=TRUE), cluster_list)  
  return(cluster_data)
}