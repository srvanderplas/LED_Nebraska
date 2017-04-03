
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny) # Creates the applet
library(leaflet) # Loads the map functionality
library(shinythemes) # Theme shiny applet

source("Code/DataObjects.R")
dates <- unique(led_data$Date)

shinyUI(fluidPage(

  # Application title
  titlePanel("LED Streetlights"),

  # Create a row to hold the map and slider option
  fluidRow(
    # Create a column to hold the map that takes up 10/12 columns
    column(
      width = 10,
      # Call the map object "map" and make it 100% of the 10 columns
      # and 600 px high
      leafletOutput("map", width = "100%", height = '600px')
    ),
    # Create a column to hold the slider that takes up 2/12 columns
    column(
      width = 2,
      sliderInput(
        # Call the input variable time
        inputId = "time",
        # User-readable label
        label = "Date Installed",
        # Slider start value
        min = ymd("2014-01-01"),
        # Slider end value
        max = max(dates),
        # Change dates by 2 week periods
        step = 14,
        # Default value on app load
        value = min(dates),
        # Animation speed - change dates every 100 milliseconds
        animate = animationOptions(interval = 100)
      )
    )
  ),
  theme = shinytheme("darkly") # Use dark shiny theme for prettiness
))
