library(shiny)
library(leaflet)

source("helpers.R")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    # Application title
    titlePanel("Booze-Orleans"),
  
  
    # Controls
    sidebarLayout(
      sidebarPanel(
        h4("Neighborhood ABOs"),
        h3("Shape files from Zillow"),
        h3("Data from data.nola.gov")
        
#         selectInput("shape", 
#                     label = h3("Draw Areas"), 
#                     choices = c(
#                       "Neighborhoods",
#                       "Historical Districts",
#                       "School Districts",
#                       selected = "Zip Codes"
#                     )
#                   )
      ),

      # Show a plot of the generated distribution
      mainPanel(
        h2("New Orleans Alcohol Beverage Outlets"),
        leafletOutput("map")#,
        #textOutput("shape")
      )
    )
))