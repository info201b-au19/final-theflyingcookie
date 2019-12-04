library(shiny)
library("dplyr")
library("ggplot2")
library("ggmap")
library("mapproj")
library("leaflet")
library("knitr")
library("plotly")

data_df <-read.csv("AB_NYC_2019.csv",stringsAsFactors = FALSE)

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
    
    #Get disired data from the dataset.
    sorted <- data_df %>%
        group_by(neighbourhood_group) %>%
        summarise(num_listings = n())
    
    #Get disired data from the dataset.
    averaged <- data_df %>%
        group_by(neighbourhood_group) %>%
        mutate(avg_price = round(mean(price), 2)) 
    
    averaged <- averaged[!duplicated(averaged$avg_price), ]
    
    combined_data <- left_join(sorted, averaged, by = "neighbourhood_group")
    
    
    #Generate the bar chart.
    output$barGraph <- renderPlotly({
        p <- ggplot(combined_data, aes(neighbourhood_group, 
                                       combined_data[[input$barFeature]], 
                                       text = paste0(input$barFeature, ": ", combined_data[[input$barFeature]]))) +
            geom_col() +
            theme(plot.title = element_text(hjust = 0.5)) +
            theme(axis.title.x = element_text(size = 16),
                  axis.title.y = element_text(size = 16),
                  title = element_text(size = 17)
            ) +
            labs(
                title = paste0(input$barFeature, " per Neighbourhood Group"),
                x = "Neighbourhood Group",
                y = input$barFeature
            ) 
        p <- ggplotly(p, tooltip = "text")
        p
    })
    
    
    output$pie <- renderPlotly({
        
        #Colors needed for the chart.
        mycols <- c("#0073C2FF", "#EFC000FF", "#CD534CFF")
        
        neighbourhood_choice <- input$pieNeighbourhoodInput
        
        #Get the disired data based on the user choice.
        room_types <- filter(data_df, neighbourhood_group == neighbourhood_choice)
        room_types <- group_by(room_types, room_type) %>%
            tally() %>%
            arrange(desc(room_type)) %>%
            mutate(prop = round(n / sum(n), 3) * 100)
        
        #Create the pie chart.
        p <- plot_ly(room_types, labels = ~room_type, values = ~n,
                     type = "pie",
                     marker = list(colors = mycols)
                     ) %>%
            layout(title = paste0("NYC Airbnb rooms by type in ", input$pieNeighbourhoodInput, " neighbourhood"),
                   xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                   yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
        p
    })
    
    output$table <- renderTable({
        
        aggregate_table <- 
            summarize(
                group_by(data_df, neighbourhood_group),
                average_price = round(mean(price, na.rm = FALSE), digits = 2),
                average_min_nights_req = round(mean(minimum_nights, na.rm = FALSE), digits = 1),
                average_avail_nights = round(mean(availability_365, na.rm = FALSE), digits = 1)
            ) %>%
            rename(
                "Neighborhood Area" = neighbourhood_group,
                "Average Price for a Room ($ USD)" = average_price,
                "Average Minimum of Nights Required for a Room" = average_min_nights_req,
                "Average Room Availability out of 365 Days (Days)" = average_avail_nights
            )
    })
}





