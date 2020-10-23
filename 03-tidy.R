library(tidyverse)

tumor <- read_csv("data/tumorgrowth_long.csv")
tumor

tumor_tidy <- tumor %>%
  pivot_longer(`0`:last_col(), names_to = "day", values_to = "size")

tumor_tidy %>%
  group_by(Group, day) %>%
  summarize(avg_size = mean(size, na.rm = TRUE)) %>%
  mutate(day = as.numeric(day)) %>%
  arrange(Group, day)

names(tumor)

tb <- read_csv("data/tb_long.csv")

tb %>%
  select(starts_with(c('m', 'f')))

tb_long <- tb %>%
  pivot_longer(starts_with(c('m', 'f')))
tb_long

tb_tidy <- tb_long %>%
  separate(name, into = c("sex", "age_group"), sep = 1)

tb_tidy

cms <- read_csv("data/cms_utilization.csv")

cms_long <- cms %>%
  pivot_longer(`2007`:last_col(), names_to = "year")
cms_long

cms_tidy <- cms_long %>%
  pivot_wider(names_from = variable, values_from = value)
