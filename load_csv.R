# author: James Huang
# date: 2020-01-17

"This script downloads a file from a url specified by the user, 
and saves it to a file in a filepath specified by the user.

Usage: quick_csv_stat.R <url> <file_path>
" -> doc

library(tidyverse)
library(docopt)

opt <- docopt(doc)

main <- function(url, file_path){
  
  df <- read_csv(url)

  write.csv(df, file = file_path)
}

main(opt$url, opt$file_path)