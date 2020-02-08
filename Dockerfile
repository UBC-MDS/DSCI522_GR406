# author: Alexander Hinton
# date: 2020-02-06
#
# This docker image loads all the requirements for use in the NYC Taxi project
# Rocker/tidyverse is the base image, upon which other R packages are installed.
# Python3 and other required python packages are subsequently installed.
# Usage for this docker image is explained in the Readme

# Use tidvyverse as base image
FROM rocker/tidyverse

RUN apt-get update

# Install R packages
RUN Rscript -e "install.packages('repr')"
RUN Rscript -e "install.packages('modelr')"
RUN Rscript -e "install.packages('ggridges')"
RUN Rscript -e "install.packages('GGally')"
RUN Rscript -e "install.packages('docopt')"
RUN Rscript -e "install.packages('kableExtra')"
RUN Rscript -e "install.packages('gridExtra')"


# Install python 3
RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

# python package dependencies
RUN apt-get install -y python3-tk

# install python packages
RUN pip3 install docopt
RUN pip3 install pandas
RUN pip3 install validators