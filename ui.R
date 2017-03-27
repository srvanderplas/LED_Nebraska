
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(leaflet)
library(shinythemes)

load("./Data/FakeData.Rdata")

shinyUI(fluidPage(

  # Application title
  titlePanel("LED Streetlights"),


  fluidRow(
    column(
      width = 10,
      leafletOutput("map", width = "100%", height = '600px')
    ),
    column(
      width = 2,
      sliderInput(
        "time",
        "Month",
        min = min(dates),
        max = max(dates),
        value = min(dates),
        animate = animationOptions(interval = 100)
      )
    )
  ),
  theme = shinytheme("darkly")
))
