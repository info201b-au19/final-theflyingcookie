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
    "Overview", 
    titlePanel("Overview of Project"), 
    sidebarLayout(
        sidebarPanel(
            # A static content element: a 2nd level header that displays text
            h2("Questions Our Project Investigated"),
            
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

page_three <- tabPanel(
    "Bar Graph" ,
    titlePanel("Bar Graph"), 
    
    sidebarLayout(
        sidebarPanel(
            # Wideget 1: first state for comparison
            selectInput(
                inputId = "barFeature",
                label = "Select a feature you would like to explore",
                choices = c("num_listings", "avg_price")
            ),
            
        ),
        mainPanel(
            h2("New York City, 2019"),
            p("This bar graph shows us the average price per Airbnb and the 
              number of listings for each neighbourhood group in New York City."
            ),
            plotOutput(outputId = "barGraph")
        )
    )
)

summary <- tabPanel(
    "Summary" ,
    titlePanel("Summary Takeaways"), 
    
    
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

ui <- navbarPage(
    "My Application", 
    title,         
    page_one,
    page_two,
    page_three,
    summary
)



