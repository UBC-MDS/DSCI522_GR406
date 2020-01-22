# author: Alexander Hinton
# date: 2020-01-21

"This script loads a file from disk and does the necessary cleaning and 
pre processing for usage in modelling. 

Usage: data_cleaning.R <inbound_file_path> <outbound_file_path> 

Options:
<inbound_file_path>         Path where raw data can be read from locally
<outbound_file_path>        Path where clean data will be saved locally 
" -> doc

# Load libraries
options(tidyverse.quiet = TRUE)
library(tidyverse)
library(docopt)
# dates
library(lubridate)

# Parse command line arguments
opt <- docopt(doc)

# Define main function
main <- function(raw_data_path, clean_data_path){
  oldw <- getOption("warn")
  options(warn = -1)
  df <- read_csv(raw_data_path, col_types = cols())
  
  # Read taxi zone info
  zone_info <- read_csv("data/taxi_zone.csv", col_types = cols()) %>% select(LocationID, Borough)
  options(warn = oldw)
  
  # Choose only credit card payments so we have tip information
  df <- df %>% filter(payment_type == 1) %>%
          # choose only columns which are relevant for the analysis
          select(tpep_pickup_datetime, tpep_dropoff_datetime, passenger_count,
                  RatecodeID, trip_distance, PULocationID, DOLocationID, tip_amount, total_amount) %>%
          # define tip percentage variable
          mutate(tip_pct = (tip_amount / total_amount))
  
  # Filter out NA values in tip_pct
  # These are due to the `total amount` having a value of 0 
  df <- df %>% filter(!is.na(tip_pct))
  
  # Group datetime objects
  df <- df %>% 
          # Get hour of the day and day of the week
          mutate(pu_hour = hour(tpep_pickup_datetime),
                  pu_wday = wday(tpep_pickup_datetime, label = TRUE, abbr = FALSE)) %>%
          # Group rides by time of the day into four groups
          mutate(pu_time_of_day_group = case_when(pu_hour >= 22 | pu_hour < 5   ~ "middle_night",
                                            (pu_hour >= 5 & pu_hour < 12)  ~ "morning",
                                            (pu_hour >= 12 & pu_hour < 18) ~ "afternoon",
                                            (pu_hour >= 18 & pu_hour <= 21  ) ~ "evening"),
          # Group by day of the week
           pu_wday_group = if_else((pu_wday == 'Saturday' | pu_wday == 'Sunday'), "weekend", "weekday"))
  
  # Join with taxi zone info
  df <- df %>% 
    left_join(zone_info, by = c("PULocationID" = "LocationID")) %>% 
    mutate(PUBorough = Borough) %>% 
    select(-Borough) %>% 
    left_join(zone_info, by = c("DOLocationID" = "LocationID")) %>%
    mutate(DOBorough = Borough) %>% 
    select(-Borough)
  
  # Write clean df to file
  write_csv(df, path = clean_data_path)
}

# Call main function
main(opt$inbound_file_path, opt$outbound_file_path)
