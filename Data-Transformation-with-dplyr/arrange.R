library(nycflights13)
library(tidyverse)

# Exercises

# 1.

# Since TRUE has a value of 1, if we arrange a column by is.na() in _descending_ order we'll pop the 
# NAs to the top.

arrange(flights, desc(is.na(dep_time)))

# 2.

most_delayed <- flights %>%
  arrange(desc(dep_delay))

earliest_flights <- flights %>%
  arrange(dep_time)

# 3.

fastest <- flights %>%
  arrange(air_time)

# 4.

longest_dist <- flights %>%
  arrange(desc(distance))

shortest_dist <- flights %>%
  arrange(distance)