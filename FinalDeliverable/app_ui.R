#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library("dplyr")
library("ggplot2")
library("ggmap")
library("mapproj")
library("leaflet")
library("knitr")


data_df <-read.csv("AB_NYC_2019.csv",stringsAsFactors = FALSE)


title <- tabPanel(
    "Title Page", 
    titlePanel("Title"), 
    
    
    sidebarLayout(
        sidebarPanel(
            # A static content element: a 2nd level header that displays text
            h2("Greetings from Shiny"),
            
            # A widget: a text input box (save input in the `username` key)
            textInput(inputId = "username", label = "What is your name?"),
            
            # An output element: a text output (for the `message` key)
            textOutput(outputId = "message"),
            # Widget 1: first page feature selection.
            
            selectInput(
                inputId = "selectedInput",
                label = "Select the feature you would like to explore",
                choices = c("snail","nail","ail")
            ),
            
        ),
        mainPanel(
            h3("Header size 3 here "),
            p("blah blah blah blah blah"),            
        )
    )
)


page_one <- tabPanel(
    "First Page" ,
    titlePanel("Page 1"), 
    
    
    sidebarLayout(
        sidebarPanel(
            # Wideget 1: first state for comparison
            selectInput(
                inputId = "pieStateInput",
                label = "Select a state you would like to explore",
                choices = c("snail","nail","ail")
            )
        ),
        mainPanel(
            h3("Header size 3 here "),
            p("blah blah blah blah blah"),           
        )
    )
)

page_two <- tabPanel(
    "Map" ,
    titlePanel("Map"), 
    
    
    sidebarLayout(
        sidebarPanel(
            # Wideget 1: first state for comparison
            selectInput(
                inputId = "mapFeature",
                label = "Select a feature you would like to explore",
                choices = colnames(data_df)
            ),
            
            sliderInput(
                inputId = "mapSlider",
                label = "Select radius size",
                min = 50,
                max = 200,
                step = 10,
                value = 100
            )
            
        ),
        mainPanel(
            h2("New York City, 2019"),
            p("This interactive map pinpoints every house that was hosted on the Airbnb website in New York City in 2019.
              Select a feature and click on any point on the map to see the feature-value for that paticular house."),
            leafletOutput(outputId = "map"),
            p("(You're looking at over 48,000 data points, so it may take a second to laod)")
            
        )
    )
)



ui <- navbarPage(
    "My Application", 
    title,         
    page_one,
    page_two
    
)



