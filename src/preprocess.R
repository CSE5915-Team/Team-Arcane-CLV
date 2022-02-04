# Reads through the given csv file and removes bad data


#########  Packages  ##########
# May need to run `install.packages("janitor")` prior to running the script
library("janitor")

########## Functions ##########

# Append vector to a list
lappend <- function(lst, ...) {
  lst <- c(lst, list(...))
  return(lst)
}

#' Checks if the row contains NULL values
#' 
#' @description 
#' Looks through all cells in the row and checks if NULL exists in them.
#' Ignores the columns 'hshold_lifestage_last' and 'prev_dprt_dt' as those
#' columns can legally contain NULL values
#' 
#' @param row the row being checked
#' 
#' @return TRUE if an illegal NULL value exists, FALSE otherwise
check_if_bad <- function(row) {
  is_good <- TRUE
  row_len <- length(row)
  
  # Go through and check if any NULL values exist
  for (i in 1:row_len) {
    cell <- c(row[i])
    
    # Ignore values in 'hshold_lifestage_last' and 'prev_dprt_dt'
    if (names(cell) != "hshold_lifestage_last" & names(cell) != "prev_dprt_dt") {
      if (cell == "NULL") {
        is_good <- FALSE
      }
    }
  }
  
  return(!is_good)
}

#' Generates clean data in a dataframe
#' 
#' @description 
#' Goes through the bad data and ignores all rows that ruin data quality
#' Conditions that ruin data quality:
#' - Containing illegal NULL values
#' 
#' @param bad_data the bad data coming from an excel file
#' @param num_rows the total number of rows
#' 
#' @return a dataframe containing clean data
get_clean_data <- function(bad_data, num_rows) {
  df <- data.frame()
  
  # Go through each row
  for (i in 1:num_rows) {
    row = bad_data[i, ]
    
    # Check if the row is bad
    if (!check_if_bad(row)) {
      df <- rbind(df, row)
    }
  }
  
  return(df)
}

get_bad_dupes <- function(dupes) {
  bad_dupes <- list()
  len_dupes <- nrow(dupes) 
  half_len <- floor(len_dupes / 2)
  
  for (i in 1:half_len) {
    bad_dupe <- dupes[2 * i, ]
    bad_info <- c(bad_dupe["newid_trips"], bad_dupe["arvl_dt"], bad_dupe["tot_amt"])
    bad_dupes <- lappend(bad_dupes, bad_info)
  }
  
  return(bad_dupes)
}

# TODO: Figure out how to implement this removal process quickly
#remove_duplicates <- function(clean_data, bad_dupes) {
#  tot_rows <- length(bad_dupes)
#  print(bad_dupes[1])
#  positions <- list()
#  
#  return(clean_data)
#}


##########  Logic  ###########

# Clean data file name
clean_data_file <- "Cleandata.csv"

# Bad data file name
bad_data_file <- "Rawdata.csv"

# Preprocess data
bad_data <- read.csv(bad_data_file) # Bad data

tot_rows <- lengths(bad_data)[1] # Total number of rows

clean_data <- get_clean_data(bad_data, tot_rows) # Clean data

dupes <- get_dupes(clean_data, newid_trips, arvl_dt) # Get dupes
print(dupes)
bad_dupes <- get_bad_dupes(dupes) # Get list of duplicates to remove
#clean_data <- remove_duplicates(clean_data, bad_dupes)

# Write clean data to file
write.csv(clean_data, clean_data_file, row.names = FALSE)
print('Done.')