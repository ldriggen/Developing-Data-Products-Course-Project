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
library(rnoaa)
library(plotly)


shinyServer(function(input, output) {

    # create a data frame of the max and min daily temperatures for the selected sites.
    IndianaLowHighTemp_30Days<-eventReactive(input$Compare,{
      for (i in 1:length(input$stations)) {
      if (i==1) {
        allTemps<-meteo_tidy_ghcnd(input$stations[[i]], var = c("TMIN","TMAX"), date_min = as.Date(Sys.Date()) - 30)
      }
      else {
        Temps<-meteo_tidy_ghcnd(input$stations[[i]], var = c("TMIN","TMAX"), date_min = as.Date(Sys.Date()) - 30)   
        allTemps=rbind(allTemps,Temps)
      }
    }
    allTempsDF<-data.frame(allTemps)
    
    TMIN <- allTempsDF[!is.na(allTempsDF$tmin),c("id","date","tmin")]
    TMIN$Measurement <- paste(TMIN$id,"- Minimum")
    TMIN$Value <- TMIN$tmin/10
    TMAX <- allTempsDF[!is.na(allTempsDF$tmax),c("id","date","tmax")]
    TMAX$Measurement <-  paste(TMAX$id,"- Maximum")
    TMAX$Value <- TMAX$tmax/10
    
    TMIN <- TMIN[,!names(TMIN) %in% c("tmin")]
    TMAX <- TMAX[,!names(TMAX) %in% c("tmax")]
    
    
    rbind(TMIN,TMAX)
    })
 
    # create a table of statistics for the max and min daily temperatures at each site selected 
    sitestats<-reactive({tapply(IndianaLowHighTemp_30Days()$Value, as.factor(IndianaLowHighTemp_30Days()$Measurement),summary)})
    output$statstbl <- renderTable({do.call("rbind",sitestats()) },
      rownames = TRUE)
    
    # create an interactive plot comparing the max and min daily temperatures by site    
    output$comparisonplot <-renderPlotly({plot_ly(IndianaLowHighTemp_30Days(), x = ~date, y = ~Value, color = ~Measurement, type='scatter',mode='lines+markers')})
    
})
