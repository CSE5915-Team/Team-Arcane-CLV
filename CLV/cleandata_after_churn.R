
# Adds a column where each cell is the number of days each customer visited since the first customer who stopped visiting
modify_data_for_ecdf <- function(data){
  
  minDate <- min(data$max_arvl_dt) # finds the earliest date
  
  data <- data%>%mutate(diff_btwn_dates_in_days = difftime(max_arvl_dt, minDate, units = "days")) # calculates the difference in days between the minDate and 
                                                                                                  # the date when each person last visited
  
  #data %>% distinct(customer_id, .keep_all = TRUE) # in case we only want one row for each customer
  
  return(data)
  
}

# creates new churned data set
generate_after_churn_new_data <- function(data, churn){
  
  data[order(data$diff_btwn_dates_in_days, decreasing = FALSE), ] # orders the diff_btwn_dates_in_days in increasing order based on the days 
  
  data <- data %>% top_frac(1 - churn) # creates a new dataframe by returning the top 80% of the ecdf graph
  
  data[order(data$customer_id, decreasing = FALSE), ] # orders new dataframe by customer_id for neatness
  
  write.csv(data, "Cleandata_after_churn.csv", row.names = FALSE) # writes new dataframe to file
  
}