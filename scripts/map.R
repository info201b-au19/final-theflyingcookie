library("dplyr")
library("ggplot2")
library("ggmap")
library("mapproj")
library("leaflet")
library("knitr")

data_df <-read.csv("data/AB_NYC_2019.csv",stringsAsFactors = FALSE)


locations <- data.frame(
  radius = (100), #(data_df$num_killed + data_df$num_injured)*
  label = paste("Room Type: \n",data_df$room_type,"  <br> Price:",data_df$price,sep=""),
  latitude = data_df$latitude,
  longitude = data_df$longitude
 )


NYC_map<-leaflet(data = locations) %>% 
   addProviderTiles("CartoDB.Positron") %>%
   setView(lat = 40.747231,lng = -73.893146,zoom = 10.0) %>% # focus on Seattle
   addCircles(
        lat = ~latitude,   # a formula specifying the column to use for latitude
        lng = ~ longitude, # a formula specifying the column to use for longitude
        popup = ~label,    # a formula specifying the information to pop up
        radius = ~radius,      # radius for the circles, in meters
        stroke = FALSE,     # remove the outline from each circle
        
        )
