library(tidyverse)

read_csv("data/medicaldata_tumorgrowth.csv")

tumor <- read_csv("data/medicaldata_tumorgrowth.csv")
tumor

library(readxl)

tumor_xl <- read_excel("data/medicaldata_tumorgrowth.xlsx")
tumor_xl

class(tumor)

spreadsheet_df <- read_csv("data/spreadsheets/exercise-010-050.csv")

tumor

select(tumor, Size)

select(tumor, Size, Group, Day)

tumor %>%
  select(Size)

tumor %>%
  select(Size, Group, Day)

filter(tumor, Group == 1)

filter(tumor, Group == 3)

tumor %>%
  filter(Group == 3)

tumor %>%
  filter(Group == 3, Day == 0)

tumor %>%
  filter(Group == 3 & Day == 0)

tumor %>%
  filter(Day == 0 | Day == 13)


tumor %>%
  select(Group, Day, Size) %>%
  filter(Size > 2000)

filter(select(tumor, Group, Day, Size), Size > 2000)


filtered <- tumor %>%
  select(Group, ID, Day, Size) %>%
  filter(Day == 0 | Day == 13)

filtered

write_csv(filtered, "data/tumor_filtered.csv")
