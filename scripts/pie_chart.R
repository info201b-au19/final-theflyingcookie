library("dplyr")
library("ggplot2")

data <- read.csv("data/AB_NYC_2019.csv", stringsAsFactors = FALSE)

# Colors for the chart
mycols <- c("#0073C2FF", "#EFC000FF", "#CD534CFF")

# Select the information needed to make the chart
room_types <- data %>%
  group_by(room_type) %>%
  tally() %>%
  arrange(desc(room_type)) %>%
  mutate(prop = round(n / sum(n), 3) * 100)

# Making the donut pie chart
nyc_pie <- ggplot(room_types, aes(x = 2, y = n, fill = room_type)) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  coord_polar("y", start = 0) +
  scale_fill_manual(values = mycols) +
  theme_void() +
  xlim(0.5, 2.5) +
  labs(
    title = "NYC Airbnb rooms by type",
    fill = "Room Types"
  )