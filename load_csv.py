# author: James Huang
# date: 2020-01-21

"""This script downloads a csv from a specified url
and saves it to a specified file path

Usage: docopt.py <arg1> <arg2>

Options:
<arg1>             This is the url of the csv to import
<arg2>             This is the file path the csv will be saved to

"""

from docopt import docopt
import numpy as np
import pandas as pd
import validators


def main():
	opt = docopt(__doc__)

	url = opt['<arg1>']
	if validators.url(url):
		df = pd.read_csv(opt['<arg1>'])
		df.to_csv(opt['<arg2>'])
	else:
		print("This url is invalid.")

if __name__ == "__main__":
    main()