# Program: server.R
# Author: Larry Riggen
# Creation Date: 2017-12-03
# Purpose:
#
# This server.R program is part of an Shiny application that pulls the high and low daily temperature
# over the last 30 day for 1 to 3 Indiana airport Nation Oceanic and Atmospheric Administration
# (NOAA) weather sites. The 3 sites to choose from are:
#
#               SOUTH BEND MICHIANA RGNL AP (USW00014848) in northern Indiana
#               INDIANAPOLIS INTERNATIONAL AIRPORT (USW00093819) in central Indiana
#               EVANSVILLE REGIONAL AP (USW00093819) in southern Indiana
#
# For the weather stations selected by checkboxes, a graph of the max and min temperature for each
# of the last 30 days is generated. A table of statistics for the max and min daily temperature for
# each selected site is also display.
#

library(shiny)
library(plotly)

# Define a ui that takes checkbox input and displays a plot of high and low temperatures over the last
# 30 days for 1 to 3 Indiana USA airports. The ui also displays a table of statistics for the 
# high and low temperature reading for each selected airport
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Compare High and Low Temperatures (Celcius) over Last 30 days for Selected Indiana Weather Stations"),
  
  # Sidebar with check box selection for 1 to 3 NOAA stations
  sidebarLayout(
    sidebarPanel(
        tags$div(class="header", checked=NA,
               tags$p("Instructions")),
         tags$div(class="header", checked=NA,
               tags$p("   1. Select one or more Stations from the list below using the checkboxes")),
         tags$div(class="header", checked=NA,
               tags$p("   2. Click the Click to Compare button")),
         checkboxGroupInput("stations", "Stations", 
                           choiceNames   = list("SOUTH BEND MICHIANA RGNL AP (USW00014848)","INDIANAPOLIS (USW00093819)","EVANSVILLE REGIONAL AP (USW00093817)"),
                           choiceValues  = list("USW00014848","USW00093819","USW00093817")),
         actionButton("Compare", "Click to Compare"),
    
         tags$div(class="header", checked=NA,
                  tags$p("Please be patient, it my take several minutes to pull the data from the NOAA server"))
         
    ),
    

    mainPanel(
      # show an interactive plot 
      plotlyOutput("comparisonplot"),
      # show a table of statistics
      tableOutput("statstbl")


    )
  )
))
