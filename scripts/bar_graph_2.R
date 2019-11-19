#Load in library
library("dplyr")
library("ggplot2")
library("tidyr")

# Pull in dataset
data_df <-read.csv("data/AB_NYC_2019.csv",stringsAsFactors = FALSE)

# Finds the average price for each neighborhood group
averaged <- data_df %>%
  group_by(neighbourhood_group) %>%
  mutate(avg_price = mean(price)) 
  
# Creates bar graph
avg_price_bar_graph <- 
  ggplot(averaged) +
  geom_col(
    mapping = aes(x = neighbourhood_group, y = avg_price)
  ) +
  labs(
    title = "Average Price of NYC Airbnb Listings by Neighborhood Areas", 
    x = "Neighborhood Group", # x-axis label
    y = "Average Price of NYC Airbnb Listings" # y-axis label
  )
