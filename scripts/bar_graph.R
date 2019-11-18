library("dplyr")
library("ggplot2")
library("tidyr")

data_df <-read.csv("data/AB_NYC_2019.csv",stringsAsFactors = FALSE)

sorted <- data_df %>%
  group_by(neighbourhood_group) %>%
  tally()

bar_graph_NYC <- 
  ggplot(sorted) +
  geom_col(
    mapping = aes(x = neighbourhood_group, y = n)
  ) +
  labs(
    title = "Number of NYC Airbnb Listings by Neighborhood Areas", 
    x = "Neighborhood Group", # x-axis label
    y = "Number of NYC Airbnb Listings" # y-axis label
  )