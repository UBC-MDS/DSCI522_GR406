# Load taxis_csv from web.
data/taxis.csv : src/load_csv.py
	python src/load_csv.py https://raw.githubusercontent.com/jamesh4/yellow_tripdata_2017_02/master/taxi_smaller.csv data/taxis.csv

# Clean and process the data
data/taxis_clean.csv : data/taxis.csv src/data_cleaning.R
	Rscript src/data_cleaning.R data/taxis.csv data/taxis_clean.csv

# Create EDA visualizations
results/fig/day_of_week_group.png results/fig/day_of_week.png results/fig/time_of_day.png results/fig/heat_map.png : data/taxis_clean.csv src/eda/eda.R
	Rscript src/eda/eda.R data/taxis_clean.csv results/fig/

# Statistical modelling
results/summary_table.rds results/interactive_model.rds : data/taxis_clean.csv src/modelling.R
	Rscript src/modelling.R data/taxis_clean.csv results/

# Generate  markdown report
doc/report.md : results/summary_table.rds results/interactive_model.rds results/fig/day_of_week_group.png results/fig/day_of_week.png results/fig/time_of_day.png results/fig/heat_map.png doc/report.Rmd
	Rscript -e "rmarkdown::render('doc/report.Rmd')"

clean :
	rm -f data/taxis.csv
	rm -f data/taxis_clean.csv
	rm -f results/fig/day_of_week_group.png
	rm -f results/fig/day_of_week.png
	rm -f results/fig/time_of_day.png
	rm -f results/fig/heat_map.png
	rm -f results/summary_table.rds
	rm -f results/interactive_model.rds
	rm -f doc/report.md
	rm -f doc/report.html

all :
	make data/taxis.csv
	make data/taxis_clean.csv
	make results/fig
	make results/summary_table.rds results/interactive_model.rds
	make doc/report.md