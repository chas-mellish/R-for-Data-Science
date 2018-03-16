library(nycflights13)
library(tidyverse)

# Exercises

# 1.

arrival_delay <- flights %>%
  filter(arr_delay >= 120)

houston <- flights %>%
  filter(dest %in% c("IAH", "HOU"))

ua_aa_dl <- flights %>%
  filter(carrier %in% c("UA", "AA", "DL"))

summer <- flights %>%
  filter(month %in% c(7, 8, 9))

arrive_late <- flights %>%
  filter(arr_delay > 120, dep_delay <= 0)

speeding_flight <- flights %>%
  filter(dep_delay >= 60)