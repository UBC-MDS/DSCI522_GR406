# Project Proposal

### 1. Dataset and Datasource

We are using a comprehensive dataset of all taxi rides from yellow and green cabs in New York City for the month of February, 2017.  The dataset was downloaded from [data.world](https://data.world/new-york-city/yellow-tripdata-february-2017/workspace/file?filename=yellow_tripdata_2017-02.csv), and provided to them by the City of [New York Open Data Portal](https://opendata.cityofnewyork.us/), which provides all New York City public data, based on the [New York City open data law](https://opendata.cityofnewyork.us/open-data-law/). <br>
The data provides many features about each observation, including:<br>
- Pickup and dropoff time stamps
- Pickup and dropoff location Id's
- Distance and duration of each trip
- Fare
- Tip
- Payment method

The dataset could not be downloaded directly with a url, and thus had to be reuploaded to a github repo. The size of the file greatly exceeded the 100 MB size limit of github uploads, so the data was randomly sampled to include 1M observations from the original 9M observations. The location of the file we are using in the analysis can be found and downloaded [here](https://raw.githubusercontent.com/jamesh4/yellow_tripdata_2017_02/master/taxi_smaller.csv).

### 2.(a) Research Question

We have identified an `inferential` research question. We will attempt to determine if tip generosity of taxi cab riders is dependant on the time of the day, and day of the week. <br>

#### 2.(b) Purpose/Use case of research questions
Taxi cab drivers often have significant autonomy in determining their working hours. Therefore knowing which times of the day and week are expected to have the highest tip percentage would be valuable information in optimizing their working schedules.

##### Clarification of purpose and response

### 3. Analysis Plan

To approach our research question, we will segment all rides into different times of the day: middle of the night, morning, afternoon, and evening. We will also divide our data into weekday rides, and weekend rides. We will create an additional variable, which will be call `tip percentage`, calculated as the rider's `tip` divided by the total `fare` of the ride.<br>
In order to determine if there is a significant association between time of day/ day of week and tip percentage we will conduct an `ANOVA` analysis. The null hypothesis will be that all time group means have equal `tip percentage`, with the alternative hypothesis being that different groups have different mean `tip percentage`. Given the results of this analysis, we may conduct further follow up analysis (determine which individual groups have significant differences from the others, for example).

#### 4. Potential tables and figures for EDA
An appropriate data analysis table would be to display summary statistics 
for the mean tip percentage of each time segment. This data could also be demonstrated visually and effectively using a bar graph of group means. 

#### 5. Potential tables and figures to demonstrate results
A boxplot with confidence intervals for the mean of each group could be a visually informative way of showing the distribution of mean tip percentages of different time segments. A small summary table showing the results of the F-test in the `ANOVA` analysis is also important so the reader can be informed of the statistical significance of any findings.


#### References
1. New York City Open Data, 2017 Yellow Taxi Trip Data, https://data.cityofnewyork.us/Transportation/2017-Yellow-Taxi-Trip-Data/biws-g3hs 

2. Data.World Open Data, Yellow Trip Data February 2017, https://data.world/new-york-city/yellow-tripdata-february-2017
