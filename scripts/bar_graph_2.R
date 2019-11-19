#Load in library
library("dplyr")
library("ggplot2")
library("tidyr")
library("scales")

# Pull in dataset
data_df <- read.csv("data/AB_NYC_2019.csv", stringsAsFactors = FALSE)

# Finds the average price for each neighborhood group
averaged <- data_df %>%
  group_by(neighbourhood_group) %>%
  mutate(avg_price = round(mean(price), 2))

# Removes all duplicate rows for which the average price is the same.
# This leaves data for each neighborhood group and narrows down the dataset.
averaged <- averaged[!duplicated(averaged$avg_price), ]

  
# Creates bar graph
avg_price_bar_graph <-
  ggplot(averaged) +
  geom_col(mapping = aes(x = neighbourhood_group, y = avg_price)) +
  theme(plot.title = element_text(hjust = 0.5)) + #center the title
  scale_y_continuous(labels = dollar) + #makes the y-axis labels in dollars
  labs(
    title = "Average Price of NYC Airbnb Listings by Neighborhood Areas",
    x = "Neighborhood Group", # x-axis label
    y = "Average Price of NYC Airbnb Listings" # y-axis label
  )
