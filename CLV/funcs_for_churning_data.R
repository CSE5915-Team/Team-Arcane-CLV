# creates new churned data set
generate_after_churn_new_data <- function(data, churn){
  # modify data for ecdf 
  data <- modify_data_for_ecdf(data)
  # orders the diff_btwn_dates_in_days in increasing order based on the days
  data[order(data$diff_btwn_dates_in_days, decreasing = FALSE), ]
  ecdf_percentiles <- ecdf(data$diff_btwn_dates_in_days)
  data <- data%>%mutate(churn_probabilities =
                          1 - ecdf_percentiles(data$diff_btwn_dates_in_days))
  # orders new dataframe by customer_id for neatness
  data[order(data$customer_id, decreasing = FALSE), ]
  
  # add churn flag
  data <- add_churn_flag(data)
  
  # writes new dataframe to file
  write.csv(data, "Cleandata_after_churn.csv", row.names = FALSE)
  
  return(data) # for-testing purposes
}
#
add_churn_flag <- function(data){
  ecdf_percentiles <- ecdf(data$diff_btwn_dates_in_days)
  data <- data%>%mutate(ecdf_probabilities = ecdf_percentiles(data$diff_btwn_dates_in_days))
  data <- transform(data, churn_flag= ifelse(ecdf_probabilities>0.2, "Not Churn", "Churn"))
  return(data)
}

# Adds a column for number of days since each customer visited from first who stopped
modify_data_for_ecdf <- function(data){
  minDate <- min(data$max_arvl_dt)
  data <- data%>%mutate(diff_btwn_dates_in_days =
                          as.numeric(difftime(max_arvl_dt, minDate, units = "days")))
  return(data)
}
