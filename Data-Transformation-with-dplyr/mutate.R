library(nycflights13)
library(tidyverse)

flights_sml <- flights %>%
  select(year:day,
         ends_with("delay"),
         distance,
         air_time)

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60)

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours)

transmute(flights_sml,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours)

transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100)

(x <- 1:10)
lag(x)
lead(x)
x - lag(x)

cumsum(x)
cummean(x)

(y <- c(1, 2, 2, NA, 3, 4))
min_rank(y)
min_rank(desc(y))

# Exercises

# 1.

flights %>% mutate(dep_time_min = 60 * (dep_time %/% 100) + dep_time %% 100,
                   sched_dep_time_min = 60 * (sched_dep_time %/% 100) + sched_dep_time %% 100) %>%
  select(year:dep_time, dep_time_min, sched_dep_time, sched_dep_time_min, everything())

# 2.

flights %>% mutate(expected_air_time = arr_time - dep_time) %>%
  select(arr_time, dep_time, air_time, expected_air_time)

# The problem is that arr_time and dep_time are based on the local time zone in which the flight arrived and departed, respectively.
# Additionally you'd have to convert from HMIN to minutes. So for example, if the flight departed EWR (Newark, EST) at 5:15am EST and
# arrived at IAH (Houston, CT, one hour behind EST) at 8:30am CT, then the total flight time was
# 8:30am CT - 5:15am EST = 9:30am EST - 5:15am EST = 4 hours 15 minutes = 255 minutes air time

# 3.

# I would expect dep_delay to be the difference between dep_time and sched_dep_time in minutes.

# 4.

most_delayed <- flights %>%
  filter(!is.na(dep_delay)) %>%
  arrange(desc(dep_delay)) %>%
  mutate(rank = min_rank(desc(dep_delay))) %>%
  filter(rank <= 10) %>%
  select(rank, everything())

# We want to handle ties by assigning them the same rank value. min_rank uses a tie method that compares the minimum value for a variable.
# So if multiple observations are equal on a value, they all have the minimum value of that value, and are thus given the same rank.

# 5.

1:3 + 1:10
# [1]  2  4  6  5  7  9  8 10 12 11

# Since the first vector 1:3 is shorter than the second, it is recycled until it meets the length of 1:10 (i.e. it is extended to be
# c(1, 2, 3, 1, 2, 3, 1, 2, 3, 1)). Since 1:3 is not recycled evenly (it doesn't terminate on 3, the last value of the sequence),
# R throws a warning message.

# 5.

?sin
