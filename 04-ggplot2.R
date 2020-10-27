library(tidyverse)
library(ggplot2)
library(medicaldata)

# install.packages("remotes")
# remotes::install_github("higgi13425/medicaldata")

blood <- blood_storage

blood

class(blood)

ggplot(data = blood, mapping = aes(x = Recurrence)) + geom_bar()

ggplot(data = blood) + geom_bar(mapping = aes(x = Recurrence))

ggplot() + geom_bar(data = blood, mapping = aes(x = Recurrence))

ggplot(data = blood) + geom_boxplot(aes(x = as.factor(TVol), y = Age))

ggplot(blood) +
  geom_violin(aes(x = as.factor(TVol), y = Age)) +
  geom_jitter(aes(x = as.factor(TVol), y = Age))

ggplot(blood) +
  geom_point(aes(x = PVol, y = PreopPSA, color = as.factor(sGS))) +
  facet_wrap(~ RBC.Age.Group)

ggplot(blood) +
  geom_point(aes(x = PVol, y = PreopPSA, color = as.factor(sGS))) +
  facet_grid(Recurrence ~ RBC.Age.Group) +
  theme_minimal()
