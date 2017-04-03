# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny) # Creates the applet
library(leaflet) # Loads the map functionality
library(lubridate) # Deals with dates/times

source("Code/DataObjects.R")

shinyServer(function(input, output) {

  # Debugging function - render the data in a table
  output$data <- renderTable({

    # Convert input$time to a datetime from a string
    # and then create a logical index for rows containing
    # information on lights which have already been installed
    idx <- led_data$Date <= ymd(input$time)

    # Show the data corresponding to the index
    lightSample[idx,]
  })


  # This part draws the initial map.
  # Updates are done below.
  output$map <- renderLeaflet({
    # Map themes: https://leaflet-extras.github.io/leaflet-providers/preview/

    # Initialize map
    leaflet() %>%
      # Add openstreetmap map tiles
      addTiles(urlTemplate =
                 "//{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png") %>%
      # Zoom in on Nebraska
      fitBounds( # Fit to NE state lines (ish)
        lng1 = ne_boundary$long[1],
        lng2 = ne_boundary$long[2],
        lat1 = ne_boundary$lat[1],
        lat2 = ne_boundary$lat[2]
      )
  })

  # Update the map with all lights that have been upgraded
  # as of input$time
    observeEvent(input$time, {

      # Convert input$time to a datetime from a string
      # and then create a logical index for rows containing
      # information on lights which have already been installed
      idx <- led_data$Date <= ymd(input$time)

      # Note:
      # This code redraws all objects that have been previously drawn.
      # This is not optimal necessarily, but is the easiest way to
      # handle situations where a user might go "backwards in time"
      # using the slider.

      # Work with the "map" object
      leafletProxy("map") %>%
        # Clear shapes that are already on the map
        clearShapes() %>%
        # Add circles at long, lat which correspond to already
        # installed lights
        addCircles(lng = led_data$Long[idx], lat = led_data$Lat[idx],
                   radius = 2,
                   color = "yellow",
                   fillColor = "yellow",
                   fillOpacity = .5)
    })

})
