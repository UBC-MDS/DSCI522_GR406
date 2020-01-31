# Load taxis_csv from web.
data/taxis.csv : src/load_csv.py
	python src/load_csv.py https://raw.githubusercontent.com/jamesh4/yellow_tripdata_2017_02/master/taxi_smaller.csv data/taxis.csv

# Clean and process the data
data/taxis_clean.csv : data/taxis.csv src/data_cleaning.R
	Rscript src/data_cleaning.R data/taxis.csv data/taxis_clean.csv

# Create EDA visualizations
fig : data/taxis_clean.csv src/eda/eda.R
	Rscript src/eda/eda.R data/taxis_clean.csv fig/

# Statistical modelling
results : data/taxis_clean.csv src/modelling.R
	Rscript src/modelling.R data/taxis_clean.csv results/

# Generate  markdown report
doc/report.md : results/ fig/ doc/report.Rmd
	Rscript -e "rmarkdown::render('doc/report.Rmd')"

clean :
	rm -f data/taxis.csv
	rm -f data/taxis_clean.csv
	rm -f fig/day_of_week_group.png
	rm -f fig/day_of_week.png
	rm -f fig/time_of_day.png
	rm -f fig/heat_map.png
	rm -f fig/GR406_project_flow.png
	rm -f results/summary_table.rds
	rm -f results/interactive_model.rds
	rm -f doc/report.md

all :
	make data/taxis.csv
	make data/taxis_clean.csv
	make fig
	make results
	make doc/report.md