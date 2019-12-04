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
library("plotly")


data_df <-read.csv("AB_NYC_2019.csv",stringsAsFactors = FALSE)


title <- tabPanel(
    "Overview", 
    titlePanel("Overview of Project"), 
    sidebarLayout(
        sidebarPanel(
            # A static content element: a 2nd level header that displays text
            h2("Questions Our Project Investigated"),
            p()
            
        ),
        mainPanel(
            h3("Introduction to the Project"),
            p("The purpose of this project is to evaluate how Airbnb listing information compares within NYC.
            Airbnb is gaining marketshare in the tourist accommodation market, which has been dominated by 
            hotels, hostels, and motels in the past, and pricing has changed overtime, since it has become
            much more accessible to a larger audience of people. Services such as Uber, Doordash, Fiverr, where
            individuals offer services is only something that has come about relatively recently, and as one of
            the most prominent 'brokers', our group believes it is important to find the impact Airbnb will have
            on the future."), 
            
            h3("Data Source"),
            a("NYC Airbnb Dataset from Kaggle", href = "https://www.kaggle.com/dgomonov/new-york-city-airbnb-open-data"),
            
            p(),
            p(),
            
            img(src = "https://video-images.vice.com/articles/5c3cfa75a4786f0007380ad0/lede/1547500483819-shutterstock_665040679-copy.jpeg?crop=1xw%3A0.843644544431946xh%3Bcenter%2Ccenter&resize=2000%3A*",
                height="90%", width="90%"),
        )
    )
)


page_one <- tabPanel(
    "Pie Graph" ,
    titlePanel("Pie Graph"), 
    
    
    sidebarLayout(
        sidebarPanel(
            # Wideget 1: first state for comparison
            selectInput(
                inputId = "pieStateInput",
                label = "Select a neighbourhood you would like to explore",
                choices = unique(data_df$neighbourhood_group)
            )
        ),
        mainPanel(
            h3("Header size 3 here "),
            p("blah blah blah blah blah"),
            plotOutput("pie")
        )
    )
)

page_two <- tabPanel(
    "Map" ,
    titlePanel("Map"), 
    
    
    sidebarLayout(
        sidebarPanel(
            # Widget 1: first state for comparison
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
            # Widget 1: first state for comparison
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
            plotlyOutput(outputId = "barGraph")
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

