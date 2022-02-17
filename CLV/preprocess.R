# Reads through the given csv file and removes bad data

#########  Packages  ##########
library("janitor")
library("openxlsx")
library("dplyr")
##########  Logic  ###########
generate_clean_data <- function(){
  # file names
  bad_data_file <- "Rawdata.csv"
  clean_data_file <- "Cleandata.csv"
  
  # Preprocess data
  bad_data <- read.csv(bad_data_file, stringsAsFactors = FALSE) # Bad data
  
  # remove unused columns
  bad_data <- subset(bad_data,
                     select = -c(prev_dprt_dt, gst_jnr,
                                 gst_chld, gst_ifnt, trip_ids))
  
  # remove nulls
  bad_data <- subset(bad_data, bad_data$hshold_lifestage_last != "NULL"
                     & bad_data$trip_seq_nb != "NULL"
                     & bad_data$bkng_dt != "NULL")
  
  # fix date fields
  bad_data <- mutate(bad_data, bkng_dt =
                       paste(substr(bkng_dt, 2, 3), substr(bkng_dt, 5, 7), sep = ""))
  
  bad_data <- mutate(bad_data, bkng_dt = convertToDate(c(bkng_dt)))
  
  bad_data <- mutate(bad_data, arvl_dt =
                       paste(substr(arvl_dt, 2, 3), substr(arvl_dt, 5, 7), sep = ""))
  
  bad_data <- mutate(bad_data, arvl_dt = convertToDate(c(arvl_dt)))
  
  # make newid_trips easier to read
  newid_trips <- unique(bad_data$newid_trips)
  customer_id <- seq_len(length(newid_trips))
  new_key <- data.frame(newid_trips, customer_id)
  
  
  bad_data <- merge(bad_data, new_key, by = "newid_trips", ALL = TRUE)
  bad_data <- subset(bad_data, select = -c(newid_trips))
  
  # compute the first and last arrival date per customer
  min_dates <- bad_data %>%
    group_by(customer_id) %>%
    summarise(min_arvl_dt = min(arvl_dt))
  
  max_dates <- bad_data %>%
    group_by(customer_id) %>%
    summarise(max_arvl_dt = max(arvl_dt))
  
  bad_data <- merge(bad_data, min_dates, by = "customer_id", ALL = TRUE)
  bad_data <- merge(bad_data, max_dates, by = "customer_id", ALL = TRUE)
  
  # compute the days as customer
  bad_data$customer_lifetime <-
    difftime(bad_data$max_arvl_dt, bad_data$min_arvl_dt)
  head(bad_data)
  clean_data <- bad_data
  
  # Write clean data to file
  write.csv(clean_data, clean_data_file, row.names = FALSE)
  
  print("Done.")
}



