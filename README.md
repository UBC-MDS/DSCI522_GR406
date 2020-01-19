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
    - MASS		7.3 - 51.4
    - tidyverse	1.3.0
    - broom		0.5.2
    - repr		1.0.2
    - modelr	0.1.5
    - ggplot2	3.2.1
    - gridExtra	2.3
    - ggridges	0.5.1
    - GGally	1.4.0
    - docopt	0.6.1
    - RCurl		1.98 -  1.1
    
#### References
1. New York City Open Data, 2017 Yellow Taxi Trip Data, https://data.cityofnewyork.us/Transportation/2017-Yellow-Taxi-Trip-Data/biws-g3hs 

2. Data.World Open Data, Yellow Trip Data February 2017, https://data.world/new-york-city/yellow-tripdata-february-2017
