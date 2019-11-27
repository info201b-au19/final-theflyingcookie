library(shiny)
library("dplyr")
library("ggplot2")
library("ggmap")
library("mapproj")
library("leaflet")
library("knitr")

data_df <-read.csv("../data/AB_NYC_2019.csv",stringsAsFactors = FALSE)



my_server <- function(input, output) {
    # Assign a value to the `message` key in the `output` list using
    # the renderText() method, creating a value the UI can display
    output$message <- renderText({
        # This block is like a function that will automatically rerun
        # when a referenced `input` value changes
        
        # Use the `username` key from `input` to create a value
        message_str <- paste0("Hello ", input$username, "!")
        
        # Return the value to be rendered by the UI
        message_str
    })
    
    output$map <- renderLeaflet({
        
        feature <- input$mapFeature
        slider <- input$mapSlider
        
        
        # Adding some parameters (such as labels,radius, latitude) for maps to display.
        locations <- data.frame(
            radius = (slider), #(data_df$num_killed + data_df$num_injured)*
            label = paste(feature,": \n",data_df[[feature]], sep=""),
            latitude = data_df$latitude,
            longitude = data_df$longitude
        )
        
        # generates the map, setting location to New York and 
        # incorporating the previously created parameters.
        NYC_maps<-leaflet(data = locations) %>% 
            addProviderTiles("CartoDB.Positron") %>%
            setView(lat = 40.747231,lng = -73.893146,zoom = 10.0) %>% 
            addCircles(
                lat = ~latitude,   # a formula specifying the column to use for latitude
                lng = ~ longitude, # a formula specifying the column to use for longitude
                popup = ~label,    # a formula specifying the information to pop up
                radius = ~radius,      # radius for the circles, in meters
                stroke = FALSE    # remove the outline from each circle
            )
        
        NYC_maps
        
    })
}





