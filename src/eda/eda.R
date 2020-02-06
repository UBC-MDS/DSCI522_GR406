# author: Yijia Qin
# date: 2020-01-21

"This script generates EDA outputs given data saved in a filepath given by the user,
and output them to a filepath given by the user.

Usage: script3.R <inbound_file_path> <outbound_file_path>

Options:
<inbound_file_path>            Path where data will be read from locally 
<outbound_file_path>           Path where outputs will be saved locally
" -> doc

# Load libraries
options(tidyverse.quiet = TRUE)
library(tidyverse)
library(docopt)
library(MASS)
library(broom)
# Plots
library(ggplot2)
library(gridExtra)
library(ggridges)
library(GGally)
theme_set(theme_light())
# Dates
library(lubridate)

# Parse command line arguments
opt <- docopt(doc)

# Define main function
main <- function(data_in, files_to){
  
  # Read in data
  taxi <- read_csv(data_in, col_types = cols())
  
  # Summary tip percentage every hour
  hour_summary_stats <- taxi %>%
    group_by(pu_hour) %>%
    summarise(pu_hour_mean = mean(tip_pct))
  
  # FIRST GRAPH
  # plot hour vs. mean
  time_of_day <- hour_summary_stats %>%
    ggplot(aes(pu_hour, pu_hour_mean)) +
    geom_line() +
    geom_point() +
    labs(x = "Time Passengers Picked Up", y = "Mean tip percentage (%)",
         title = "Mean Tip Percentages by Hours in a Day") +
    theme(axis.title = element_text(size = 18),
          axis.text.x= element_text(size = 16),
          axis.text.y= element_text(size = 16),
          plot.title = element_text(size = 20))
  
  # SECOND GRAPH
  # mean tip percentage vs. day of a week
  day_of_week <- taxi %>%
    mutate(pu_wday = factor(pu_wday, 
                            levels = c("Monday", "Tuesday", "Wednesday", "Thursday", 
                                       "Friday", "Saturday", "Sunday"))) %>% 
    group_by(pu_wday) %>%
    summarise(pu_wday_mean = mean(tip_pct)) %>%
    ggplot(aes(factor(pu_wday), pu_wday_mean)) +
    geom_bar(stat = 'identity') +
    coord_cartesian(ylim = c(12, 16)) +
    labs(x = "Trip on day of a week", y = "Mean tip percentage (%)",
         title = "Mean Tip Percentages by Days of a Week") +
    theme(axis.title = element_text(size = 18),
          axis.text.x= element_text(size = 16),
          axis.text.y= element_text(size = 16),
          plot.title = element_text(size = 20))
  
  # THRID GRAPH
  # Heatmap of weekday group x time of day group on tip percentage
  text_layer <- taxi %>%
    group_by(pu_time_of_day_group, pu_wday_group) %>%
    summarise(mean_tip = round(mean(tip_pct),2))
  
  heatmap <- text_layer %>%
    ggplot(aes(pu_time_of_day_group, pu_wday_group)) +
    geom_tile(aes(fill=mean_tip)) +
    geom_text(aes(label=mean_tip), data=text_layer) +
    labs(x = "", y = "", fill = "Tip percentage (%)",
         title = "Heatmap of Weekday and Time of Day Interaction") +
    theme(axis.text.x= element_text(size=14),
          axis.text.y= element_text(size=14),
          legend.text=element_text(size=12),
          legend.title=element_text(size=15),
          plot.title = element_text(size=17)) +
    scale_fill_distiller(limits=c(14, 16), direction=1)
  
  # weekday vs. weekend summary statistics
  wkday_gp_sample_stat <- taxi %>% 
    group_by(pu_wday_group) %>% 
    summarise(mean_tip = mean(tip_pct))
  
  # FOURTH GRAPH
  # weekday vs. weekend boxplot
  day_of_week_group <- taxi %>%
    filter(tip_pct <= 25 & tip_pct >= 0) %>%
    ggplot(aes(factor(pu_wday_group), tip_pct)) +
    geom_boxplot() +
    stat_summary(fun.y = "mean", geom = "point", shape = 2, size=3) +
    geom_text(data = wkday_gp_sample_stat, aes(label = round(mean_tip, 4), x = as.factor(pu_wday_group), y = mean_tip-0.03)) +
    labs(x = "", y = "Tip percentage", title = "Boxplot of Tip Percentage with Means")
  
  # Output Filepath Check
  results_folder <- substr(files_to, 1, 8)
  try({
    dir.create(results_folder)
  })
  
  try({
    dir.create(files_to)
  })
  
  ggsave(paste0(files_to, "/time_of_day.png"), time_of_day, width = 9, height = 7)
  ggsave(paste0(files_to, "/day_of_week.png"), day_of_week, width = 9, height = 7)
  ggsave(paste0(files_to, "/heat_map.png"), heatmap, width = 8, height = 4)
  ggsave(paste0(files_to, "/day_of_week_group.png"), day_of_week_group, width = 10, height = 8)
}

# Call main function
main(opt$inbound_file_path, opt$outbound_file_path)