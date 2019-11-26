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
    "Second Page" ,
    titlePanel("Page 2"), 
    
    
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
    page_two
    
)



