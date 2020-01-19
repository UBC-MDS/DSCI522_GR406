# Inferential Analysis between Time of Day and Tip Percentage for Taxi rides in New York City

## Authors
- Alexander Hinton
- Mengzhe Huang
- Yijia Qin 

## Aims of the Project
Determine whether there is a significant association between time of day, and the mean tip percentage for patrons riding taxis in New York City. 

## Dataset
Original source is [New York Open Data](https://data.cityofnewyork.us/Transportation/2017-Yellow-Taxi-Trip-Data/biws-g3hs), smaller sample of the data used in the analysis on a public [Github repo](https://raw.githubusercontent.com/jamesh4/yellow_tripdata_2017_02/master/taxi_smaller.csv).

## Included in this repo
- [Proposal](https://github.com/UBC-MDS/DSCI522_GR406/blob/master/PROPOSAL.md), project outline and aims
- [Download script]() downloads a .csv file from a specified URL and saves to disk
- [EDA]() preliminary exploratory analysis of the data

### Dependencies
- R version 3.6.1 and R packages:
    - MASS
    - tidyverse
    - broom
    - repr
    - modelr
    - ggplot2
    - gridExtra
    - ggridges
    - GGally
    - docopt