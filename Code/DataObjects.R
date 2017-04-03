# Script to define data objects

# Define the rectangle that contains NE
ne_boundary <- data.frame(long = c(-104.07, -95.35), lat = c(39.95, 43.01))

library(readxl) # read in data from Excel
library(tidyverse) # data manipulation functions

# Read in LED replacement data
led_data <- read_excel("Data/LED_Lights_4-3-2017.xlsx") %>%
  # Make date a date object instead of a datetime object
  mutate(Date = floor_date(`Date Installed`, unit = "day") %>%
           as.Date())
