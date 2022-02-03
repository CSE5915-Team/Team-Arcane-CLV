# Reads through the given excel sheet and removes bad data


#########  Packages  ##########
if(!require("readxl")) {
  install.packages("readxl")
  library("readxl")
}

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
#' - Containing NULL values
#' - Having duplicated (newid_trips, arvl_dt) pairs
#' 
#' @param bad_data the bad data coming from an excel file
#' @param num_rows the total number of rows
#' 
#' @return a dataframe containing clean data
get_clean_data <- function(bad_data, num_rows) {
  df <- data.frame()
  #id_date_pairs = list()
  
  # Go through each row
  for (i in 1:num_rows) {
    row = bad_data[i, ]
    
    # TODO: Implement check for duplicate newid_trips and arvl_dt pairs
    #id_date = c(row["newid_trips"], row["arvl_dt"])
    #if (match(id_date, id_date_pairs)) {
    #
    #} else {
    #  id_date_pairs <- lappend(id_date_pairs, id_date)
    #}
    
    
    # Check if the row is bad
    if (!check_if_bad(row)) {
      df <- rbind(df, row)
    }
  }
  
  return(df)
}


##########  Logic  ###########

# Clean data file name
clean_data_file <- "Cleandata.csv"

# Bad data file name
bad_data_file <- "Rawdata.xlsx"

# Bad data sheet name
sheet_name <- "Dataset"

# Preprocess data
bad_data <- read_excel(bad_data_file, sheet = sheet_name) # Bad data

tot_rows <- lengths(bad_data)[1]# Total number of rows

clean_data <- get_clean_data(bad_data, tot_rows) # Clean data

# Write clean data to file
write.csv(clean_data, clean_data_file, row.names = FALSE)