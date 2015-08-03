library(shiny)
library(leaflet)
library(RColorBrewer)
library(scales)
library(lattice)
library(plyr)
library(rgdal)


# Data
library(RSocrata)
booze <- read.socrata('https://data.nola.gov/resource/uiry-as9x.json')
hood_shape <- readOGR("data/ZillowNeighborhoods-LA/", "ZillowNeighborhoods-LA", verbose = FALSE)
# Define server logic
shinyServer(function(input, output, session) {
  
  # Create Map
  output$map <- renderLeaflet({
    leaflet(
     
    ) %>%
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
      data=hood_shape,
      weight=2,
      color ='#FF0000',
      fill = FALSE
    )
  })
  
  #Select Shape
  #output$shape <- renderText({
  #  paste("You have selected", input$shape)
  #})
  
  # Default Observation
  observe({
      map <- leafletProxy("map")
  })
#   # Neighborhood Layer
#   observe({
#     if (input$shape == 'Neighborhoods')
#     leafletProxy("map") %>% clearShapes() %>%
#       addPolygons(
#         data=zip_shape,
#         weight=2,
#         color ='#FF0000',
#         fill = FALSE
#       )
#   })
#   # School Layer
#   observe({
#     if (input$shape == 'School Districts')
#       leafletProxy("map") %>% clearShapes() %>%
#       addPolygons(
#         data=school_shape,
#         weight=2,
#         color ='#FF0000',
#         fill = FALSE
#       )
#   })

  
})
