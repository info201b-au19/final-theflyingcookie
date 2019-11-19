library("dplyr")

data_df <- read.csv("data/AB_NYC_2019.csv",stringsAsFactors = FALSE)


# The Variable for Summary Information.

# number of rows in dataset
nrows <- nrow(data_df)

#number of columns in dataset
ncol <- ncol(data_df)

# Airbnb rented for the maximum price.
max_price <- data_df %>%
  summarize(max = max(price,na.rm = TRUE))%>%
  pull(max)

# Since some Airbnb's don't charge per night, they can cliam to have zero in price. 
# This is the minimum price.
min_price <- data_df %>%
  summarize(price= min(price,na.rm = TRUE))%>%
  pull(price)

# The number of private rooms that were hosted on the Airbnb platform.
num_Private_rooms <- data_df %>%
  mutate(number = 1)%>%
  filter(room_type=="Private room")%>%
  summarize(sum = sum(number,na.rm = TRUE))%>%
  pull(sum)%>%
  paste()

# The number of Entire homes/apts  that were hosted on the Airbnb platform.
num_Entire_homes <- num_private_rooms <- data_df %>%
  mutate(number = 1)%>%
  filter(room_type=="Entire home/apt")%>%
  summarize(sum = sum(number,na.rm = TRUE))%>%
  pull(sum)%>%
  paste()

# The number of shared rooms that were hosted on the Airbnb platform.
num_Shared_rooms <- num_private_rooms <- data_df %>%
  mutate(number = 1)%>%
  filter(room_type=="Shared room")%>%
  summarize(sum = sum(number,na.rm = TRUE))%>%
  pull(sum)

# Most popular neighbourhood to host a room on the Airbnb platform.
most_popular_neighbourhood <- data_df%>%
  mutate(number = 1)%>%
  group_by(neighbourhood)%>%
  summarize(sum = sum(number,na.rm = TRUE))%>%
  filter(sum == max(sum,na.rm = TRUE))%>%
  pull(neighbourhood)
  
# Most popular neighbourhood group to host a room on the Airbnb platform.
most_popular_neighbourhood_group <- data_df%>%
  mutate(number = 1)%>%
  group_by(neighbourhood_group)%>%
  summarize(sum = sum(number,na.rm = TRUE))%>%
  filter(sum == max(sum,na.rm = TRUE))%>%
  pull(neighbourhood_group)
  
# Total number of reviews that guests provided for the Airbnb dataset.
total_reviews <- data_df%>%
  summarize(sum = sum(number_of_reviews,na.rm = TRUE))%>%
  pull(sum)