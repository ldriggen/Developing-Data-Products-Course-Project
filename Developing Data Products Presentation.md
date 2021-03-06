Developing Data Products Presentation
========================================================
author: Larry Riggen  
date: December 05, 2017
autosize: true

Application Purpose
========================================================

This application interacts with a database hosted by the US National Oceanic and Atmospheric Administration (NOAA).

The R package rnoaa is used to pull the weather data from the NOAA site and is structured as follows

- One to three sites (at airports in northern, central, and southern Indiana) can be seleted for study
- High and low daily temperatures for the last 30 days are extracted from the NOAA database for the selected sites
- An interactive plot showing the high and low temperatures for selected site is displayed
- A table of statistics for high and low temperature at each site is displayed

Data from NoAA
========================================================
The code below shows the use of the rnoaa meteo_tidy_ghcnd function to pull the max and min temperatures
over the last 30 days for the Indianapolis, Indiana airport (site USW00093819 )


```r
library(rnoaa)
meteo_tidy_ghcnd("USW00093819",var= c("TMIN","TMAX"), date_min = as.Date(Sys.Date()) - 30)
```

```
# A tibble: 26 x 4
            id       date  tmax  tmin
 *       <chr>     <date> <dbl> <dbl>
 1 USW00093819 2017-11-05   228   117
 2 USW00093819 2017-11-06   117    78
 3 USW00093819 2017-11-07   100    61
 4 USW00093819 2017-11-08   111    17
 5 USW00093819 2017-11-09   128   -16
 6 USW00093819 2017-11-10    17   -32
 7 USW00093819 2017-11-11    56   -43
 8 USW00093819 2017-11-12    56     0
 9 USW00093819 2017-11-13    72    17
10 USW00093819 2017-11-14   106     0
# ... with 16 more rows
```

Example Results
========================================================
The image below is an example of the application

![plot of chunk unnamed-chunk-2](./Capture-app.png)

Future Development Plans
========================================================

I would like to expand the application to allow for the selection of the weather stations to
be selected from a map and to also select different measurements (e.g. precipitation, wind velocity,...)
