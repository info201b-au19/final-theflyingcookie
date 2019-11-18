library("dplyr")
library("ggplot2")

data <- read.csv("data/AB_NYC_2019.csv", stringsAsFactors = FALSE)

mycols <- c("#0073C2FF", "#EFC000FF", "#868686FF", "#CD534CFF")

room_types <- data %>%
  group_by(room_type) %>%
  tally() %>%
  mutate(percent = round(n / sum(n), 3) * 100) %>%
  mutate(lab.ypos = cumsum(percent) - 0.5 * percent)

neighbourhood <- data %>%
  group_by(neighbourhood_group) %>%
  tally()

location <- data %>%
  group_by(neighbourhood) %>%
  tally()

nyc_pie <- ggplot(room_types, aes(x = "", y = n, fill = room_type)) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  coord_polar("y", start = 0) +
  geom_text(aes(y = lab.ypos, label = percent), color = "white") +
  scale_fill_manual(values = mycols) +
  theme_void()

nyc_pie
