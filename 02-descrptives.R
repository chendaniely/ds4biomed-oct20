library(tidyverse)

filtered <- read_csv("data/tumor_filtered.csv")

filtered %>%
  filter(Day == 0) %>%
  select(Size)

filtered %>%
  filter(Day == 0) %>%
  pull(Size) %>%
  mean()

filtered %>%
  filter(Group == 1, Day == 0) %>%
  pull(Size) %>%
  mean()

filtered %>%
  filter(Group == 2, Day == 0) %>%
  pull(Size) %>%
  mean()

filtered %>%
  filter(Group == 3, Day == 0) %>%
  pull(Size) %>%
  mean()

filtered %>%
  filter(Group == 4, Day == 0) %>%
  pull(Size) %>%
  mean()

filtered %>%
  filter(Group == 5, Day == 0) %>%
  pull(Size) %>%
  mean()

# average size, for day == 0, across all groups

filtered %>%
  filter(Day == 0) %>%
  group_by(Group) %>%
  summarize(avg_size = mean(Size),
            min_size = min(Size),
            max_size = max(Size),
            median_size = median(Size)
            )
