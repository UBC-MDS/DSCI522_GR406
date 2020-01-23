# author: Alexander Hinton
# date: 2020-01-22

"This script loads a clean data file from disk, runs a linear model and saves it to
an output location. 

Usage: modelling.R <inbound_file_path> <outbound_file_path> 

Options:
<inbound_file_path>         Path where raw data can be read from locally
<outbound_file_path>        Path where clean data will be saved locally 
" -> doc

# Load libraries
options(tidyverse.quiet = TRUE)
library(tidyverse)
library(docopt)

# Parse command line arguments
opt <- docopt(doc)

# Define main function
main <- function(inbound_file, outbound_file){
  oldw <- getOption("warn")
  options(warn = -1)
  # read in the clean data
  df <- read_csv(inbound_file, col_types = cols())
  
  # Fit the model
  interactive_mod <- lm(tip_pct ~ trip_distance + total_amount + PUBorough + pu_time_of_day_group*pu_wday_group, 
                        data = df)
  # Save model to file 
  saveRDS(interactive_mod, 
          file = paste0(outbound_file, "/intractive_model.rds"))
}

# Call main function
main(opt$inbound_file_path, opt$outbound_file_path)
