# author: Alexander Hinton
# date: 2020-01-22

"This script loads a clean data file from disk, runs a linear model and saves it to
an output location. 

Usage: modelling.R <inbound_file_path> <outbound_directory> 

Options:
<inbound_file_path>         Path where raw data can be read from locally
<outbound_directory>        Path where clean data will be saved locally 
" -> doc

# Load libraries
options(tidyverse.quiet = TRUE)
library(tidyverse)
library(docopt)

# Parse command line arguments
opt <- docopt(doc)

# Define main function
main <- function(inbound_file, outbound_dir){
  oldw <- getOption("warn")
  options(warn = -1)
  # read in the clean data
  df <- read_csv(inbound_file, col_types = cols())
  
  # Fit the model
  interactive_mod <- lm(tip_pct ~ trip_distance + total_amount + PUBorough + pu_time_of_day_group*pu_wday_group, 
                        data = df)
  # Create summary table
  interactive_model_summary <- broom::tidy(interactive_mod) %>%
                                  mutate(term = str_replace(term, "pu_time_of_day_group", ""),
                                   term = str_replace(term, "pu_wday_group", ""),
                                   term = str_replace(term, ":", "*")) %>% tail(7) %>%
                                    mutate_if(is.numeric, funs(as.character(signif(., 3)))) 
  
  # Create results out directory
  try({
    dir.create(outbound_dir)
  })
  
  # Save model to file 
  saveRDS(interactive_mod, 
          file = paste0(outbound_dir,"/interactive_model.rds"))
  
  # Save summary table
  saveRDS(interactive_model_summary, 
          file = paste0(outbound_dir,"/summary_table.rds"))
  
}

# Call main function
main(opt$inbound_file_path, opt$outbound_directory)
