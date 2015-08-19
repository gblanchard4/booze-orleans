library(shiny)
library(leaflet)

source("helpers.R")

# Define UI for application that draws a histogram
shinyUI(bootstrapPage(
    # Application title
    titlePanel("Booze-Orleans"),
  
  
    # Controls
    sidebarLayout(
      sidebarPanel(
        tags$div(
          class="header",
          checked=NA,
          tags$p("Shape files from"),
          tags$a(href="http://www.zillow.com/howto/api/neighborhood-boundaries.htm","Zillow"),
          tags$p("are licensed under"),
          tags$a(href="http://creativecommons.org/licenses/by-sa/3.0/","CC")
        ),
        tags$div(
          class="header",
          checked=NA,
          tags$p("Data from "),
          tags$a(href="http://data.nola.gov","data.nola.gov")
        ),
        h4("DWI DATE"),
        dateRangeInput(
          "dateRange",
          "DWI Date Range",
          start = "01-01-2011",
          end = "01-01-2015", 
          format = "mm-dd-yyyy",
          startview = "month",
          weekstart = 0,
          language = "en",
          separator = " to ")
        
      ),

      # Show a plot of the generated distribution
      mainPanel(
        h2("New Orleans Alcohol Beverage Outlets"),
        leafletOutput("map"),
        verbatimTextOutput("dateRangeText")
      )
    )
))