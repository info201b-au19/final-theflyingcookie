library("dplyr")

data_df <- read.csv("data/AB_NYC_2019.csv",stringsAsFactors = FALSE)


# The Variable for Summary Information.

nrows <- nrow(data_df)

ncol <- ncol(data_df)

max_price <- data_df %>%
  summarize(max = max(price,na.rm = TRUE))%>%
  pull(max)

# Yes, somehow the price is zero. Mention this in your report.
min_price <- data_df %>%
  summarize(price= min(price,na.rm = TRUE))%>%
  pull(price)


num_Private_rooms <- data_df %>%
  mutate(number = 1)%>%
  filter(room_type=="Private room")%>%
  summarize(sum = sum(number,na.rm = TRUE))%>%
  pull(sum)%>%
  paste()

num_Entire_homes <- num_private_rooms <- data_df %>%
  mutate(number = 1)%>%
  filter(room_type=="Entire home/apt")%>%
  summarize(sum = sum(number,na.rm = TRUE))%>%
  pull(sum)%>%
  paste()

num_Shared_rooms <- num_private_rooms <- data_df %>%
  mutate(number = 1)%>%
  filter(room_type=="Shared room")%>%
  summarize(sum = sum(number,na.rm = TRUE))%>%
  pull(sum)

most_popular_neighbourhood <- data_df%>%
  mutate(number = 1)%>%
  group_by(neighbourhood)%>%
  summarize(sum = sum(number,na.rm = TRUE))%>%
  filter(sum == max(sum,na.rm = TRUE))%>%
  pull(neighbourhood)
  
most_popular_neighbourhood_group <- data_df%>%
  mutate(number = 1)%>%
  group_by(neighbourhood_group)%>%
  summarize(sum = sum(number,na.rm = TRUE))%>%
  filter(sum == max(sum,na.rm = TRUE))%>%
  pull(neighbourhood_group)
  
total_reviews <- data_df%>%
  summarize(sum = sum(number_of_reviews,na.rm = TRUE))%>%
  pull(sum)