# Inferential Analysis between Time of Day and Tip Percentage for Taxi rides in New York City

## Authors
- Alexander Hinton
- Mengzhe Huang
- Yijia Qin 

## Summary
In this data analysis project We are trying to answer the question of whether the time of day, and day of the week are associated with tip generosity of riders in New York City taxis.

The original source of our data is [New York Open Data](https://data.cityofnewyork.us/Transportation/2017-Yellow-Taxi-Trip-Data/biws-g3hs), which provides a comprehensive dataset of all taxi rides in New York City. We have used a $1M$ observation sample of rides in February, 2017 from this dataset, which can be seen on this public [Github repo](https://raw.githubusercontent.com/jamesh4/yellow_tripdata_2017_02/master/taxi_smaller.csv)

After an [EDA](https://github.com/UBC-MDS/DSCI522_GR406/blob/master/src/eda.ipynb) of the data, we fit an interactive linear model using the tip percentage as our independent variable, and found significant associations between time of day and mean tip percentage while controlling for a handful of potential confounders. 

## Report
The final report can be read [here](https://github.com/UBC-MDS/DSCI522_GR406/blob/master/doc/report.md).

## Usage and flowchart
To run the analysis from beginning to end on your local machine, clone this repo, make sure all dependencies are installed and run the following commands from the root directory of the project. <br>
WARNING: Due to the size of the dataset and the visualizations made, the full process may take around 10 minutes. Please be patient :) 

```
# download data from web
python src/load_csv.py https://raw.githubusercontent.com/jamesh4/yellow_tripdata_2017_02/master/taxi_smaller.csv data/taxis.csv

# clean and process the data
Rscript src/data_cleaning.R data/taxis.csv data/taxis_clean.csv

# create EDA visualizations
Rscript src/eda.R data/taxis_clean.csv fig/

# statistical modelling
Rscript src/modelling.R data/taxis_clean.csv results/

# generate report
Rscript -e "rmarkdown::render('doc/report.Rmd')"
```

A flowchart for the process can be seen below:

![flow chart](https://github.com/UBC-MDS/DSCI522_GR406/blob/master/fig/GR406_project_flow.png)


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
