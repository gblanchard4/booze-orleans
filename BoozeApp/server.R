library(shiny)
library(leaflet)
library(RColorBrewer)
library(scales)
library(lattice)
library(plyr)
library(rgdal)
library(RSocrata)

# Data
booze <- read.socrata('https://data.nola.gov/resource/uiry-as9x.json')
hood_shape <- readOGR("data/ZillowNeighborhoods-LA/", "ZillowNeighborhoods-LA", verbose = FALSE)

# DWI Data
dwi.all <- read.csv(file = "data/dwi.geo.csv")
names(dwi.all) <- c("date","address","lat","lon","freq")
dwi.all$date <- as.Date(dwi.all$date, "%m/%d/%Y")


# Define server logic
shinyServer(function(input, output, session) {
  
#   filteredData <- reactive({
#     quakes[quakes$mag >= input$range[1] & quakes$mag <= input$range[2],]
#   })
  
  filteredDWI <- reactive({
    #dwi.2011[dwi.2011$date %in% c(as.Date(input$dateRange[1]),as.Date(input$dateRange[2])),]
    dwi.2011[dwi.2011$date >= as.Date(input$dateRange[1]) & dwi.2011$date <= as.Date(input$dateRange[2]),]
  })
  
  
  # Create Map
  output$map <- renderLeaflet({
    leaflet() %>%
    addTiles(
      urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
      attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
    ) %>%
    setView(
      lng = -90.08385663199994, 
      lat = 29.980464294000058, 
      zoom = 11
    ) %>%
    addMarkers(
      data = booze,
      booze$location_1.longitude,
      booze$location_1.latitude,
      popup = paste(booze$trade_name, booze$address, sep=": "),
      clusterOptions = markerClusterOptions()
    ) %>%
    addPolygons(
      data = hood_shape,
      weight = 2,
      color = '#FF0000',
      fill = FALSE
    )
  })
  
  
  observe({ 
        DWI <- filteredDWI()
        
        leafletProxy("map") %>%
        clearMarkers() %>%
        addCircleMarkers(
          data = DWI,
          lng =  DWI$lon,
          lat = DWI$lat,
          weight = 1,
          radius= 5,
          fillOpacity = 0.5,
          color = '#F1234',
          popup = paste(as.character(DWI$address), as.character(DWI$date), sep=": ")#,
          #clusterOptions = markerClusterOptions()
          
        )
  })
  
  observe({
    output$dateRangeText  <- renderText({
      paste("Date Range is", 
            paste(as.character(input$dateRange), collapse = " to ")
      )
    })
  })

  
})
