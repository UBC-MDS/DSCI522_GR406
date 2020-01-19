# author: MDS DSCI522 GR406
# date: 2020-01-17

"This script downloads a file from a url specified by the user, 
and saves it to a file in a filepath specified by the user.

Usage: load_csv.R <url> <file_path>

Options:
<url>            URL to download data (in CSV format) from 
<file_path>      Path where data will be saved locally
" -> doc

options(tidyverse.quiet = TRUE)
library(tidyverse)
library(docopt)
library(RCurl)

opt <- docopt(doc)

main <- function(url, file_path){
   
  # Check for valid URL before saving  
  if (url.exists(url)){
      df <- read_csv(url)
      write.csv(df, file = file_path)
  }
  
  else(
      print("The provided URL does not exist.")
  )
  
}

main(opt$url, opt$file_path)