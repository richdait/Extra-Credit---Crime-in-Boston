library("shiny")
library("dplyr")
library("ggplot2")
library("ggmap")

# Read .csv file
df_exc <- read.csv("crime.csv", stringsAsFactors = FALSE)

# Data wrangling: format dates, filter to the year 2018, extract lat/long data
df_selected <- df_exc %>%
  group_by(INCIDENT_NUMBER) %>%
  filter(OFFENSE_DESCRIPTION == "VANDALISM") %>%
  filter(YEAR == "2018") %>%
  select(INCIDENT_NUMBER, OFFENSE_DESCRIPTION, YEAR, Lat, Long)