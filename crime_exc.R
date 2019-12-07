library("shiny")
library("dplyr")
library("ggplot2")
library("ggmap")
library("shiny")

options(repos=structure(c(CRAN="https://github.com/richuwm3git/extra_credit")))


# Read .csv file
df_exc <- read.csv("crime.csv", stringsAsFactors = FALSE)

# Data wrangling: group by incident #, filter by offense type and select particular columns
# for display
df_selected <- df_exc %>%
  group_by(INCIDENT_NUMBER) %>%
  filter(OFFENSE_DESCRIPTION == "ARSON") %>%
  select(INCIDENT_NUMBER, OFFENSE_DESCRIPTION, YEAR, DAY_OF_WEEK, 
         Lat, Long)

# Render a vertical bar chart with the frequency in which arson occurs by day of the week 
ggplot(data = df_selected) +
  geom_col(mapping = aes(x = YEAR,
                  y = OFFENSE_DESCRIPTION, fill = DAY_OF_WEEK), alpha = .8) + 
  labs(title = "The Frequency (Measured in Days of the Week) in Which Arson Occurred in Boston from 2015 - 2018", 
       x = "Year", y = "Arson", color = "Urbanity") +
  theme(plot.title = element_text(hjust = 0.5))



# Create the background of map tiles
base_plot <- qmplot(
  data = df_selected,           # Name of the data frame
  x = Long,                     # Data feature for longitude
  y = Lat,                      # Data feature for latitude
  geom = "blank",               # Don't display data points (yet)
  maptype = "toner-background", # Map tiles to query
  darken = .1,                  # Darken the map tiles just a little bit
  legend = "topleft"             # Location of legend on page
)

# Add the locations (Long, Lat) of where arson occurred on the map
base_plot +
  geom_point(mapping = aes(x = Long, y = Lat), color = "brown", alpha = .9) +
  labs(title = "Arson in Boston from 2015 - 2018") +
  theme(plot.margin = margin(.3, 0, 0, 0, "cm"), plot.title = element_text(hjust = 0.5))