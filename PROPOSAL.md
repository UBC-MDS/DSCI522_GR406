
1. We acquired our dataset from https://data.world/new-york-city/yellow-tripdata-february-2017/workspace/file?filename=yellow_tripdata_2017-02.csv , which is a comprehensive dataset of rides from yellow and green cabs in NYC in February of 2017. This includes pickup and dropoff time stamps and location ID's, distance and duration of the ride, number of riders, fare, tip, and payment type. However, this dataset could not be downloaded directly with a url, and had to be reuploaded to a github repo; The size of the file greatly exceeded to the 100 MB size limit of github uploads, so the data was randomly sampled to include 1M lines from the original 9M.

2. Our research question will be inferential: we are trying to determine whether or not tip generosity is dependant on the time of the day/day of the week.

3. We will be sectioning the data into segements depending on the time that the trip took place in, and will be constructing many confidence intervals of the difference between mean tip percentages for each of these time segments.

4. For a data analysis table we could display summary stats and confidence intervals of the mean for tip percentage for each time segment. For the graph we could plot tip percentage over a certain timeframe to illustrate any trends.

5. A boxplot could be a visually informative way of showing the distribution of mean tip percentages of different time segments, and a time series could be a good way of showing tip percentage trends.