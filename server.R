# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(leaflet)
library(lubridate)

source("Code/DataObjects.R")

load("./Data/FakeData.Rdata") 

shinyServer(function(input, output) {
  
  load("./Data/FakeData.Rdata") 
  
  data.show <- reactive(
    lightSample %>% 
    filter(install.date <= ymd(input$time))
  )
  
  
  output$data <- renderTable({
    
    idx <- lightSample$install.date <= ymd(input$time)
    
    lightSample[idx,]
         
  })
  
  
  
  output$map <- renderLeaflet({
    
    # Map themes: https://leaflet-extras.github.io/leaflet-providers/preview/
    leaflet() %>% 
      addTiles(urlTemplate = 
                 "//{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png") %>% # Add openstreetmap map tiles
      fitBounds( # Fit to NE state lines (ish)
        lng1 = ne_boundary$long[1],
        lng2 = ne_boundary$long[2],
        lat1 = ne_boundary$lat[1],
        lat2 = ne_boundary$lat[2]
      )
    
    
  })
  
    observeEvent(input$time, {
      
      idx <- lightSample$install.date <= ymd(input$time)
      
      leafletProxy("map") %>%
        clearShapes() %>%
        addCircles(lng = lightSample$long[idx], lat = lightSample$lat[idx], 
                   radius = 2,
                   color = "yellow", 
                   fillColor = "yellow",
                   fillOpacity = .5)
    })

})
