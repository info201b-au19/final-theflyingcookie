# A table of  aggregated data (e.g., that has been "grouped" by one of your features)
library("dplyr")

data_df <-read.csv("data/AB_NYC_2019.csv",stringsAsFactors = FALSE)

aggregate_table <- 
  summarize(
    group_by(data_df, neighbourhood_group),
    average_price = round(mean(price, na.rm = FALSE), digits = 2),
    average_min_nights_req = round(mean(minimum_nights, na.rm = FALSE), digits = 1),
    average_avail_nights = round(mean(availability_365, na.rm = FALSE), digits = 1)
  )