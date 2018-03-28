library(nycflights13)
library(tidyverse)

flights %>%
  group_by(year, month, day) %>%
  filter(rank(desc(arr_delay)) < 10)

popular_dests <- flights %>%
  group_by(dest) %>%
  filter(n() > 365)

popular_dests %>%
  filter(arr_delay > 0) %>%
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>%
  select(year:day, dest, arr_delay, prop_delay)

# Exercises

# 2

flights %>%
  mutate(on_time = (arr_delay <= 0 & !is.na(arr_delay))) %>%
  group_by(tailnum) %>%
  mutate(tot_on_time = sum(on_time)) %>%
  mutate(flights = n()) %>%
  mutate(prop = tot_on_time / flights) %>%
  mutate(mean_delay = mean(arr_delay, na.rm = TRUE)) %>%
  select(tot_on_time, prop, mean_delay, flights, tailnum, everything()) %>%
  arrange(tot_on_time, prop, desc(mean_delay), flights, tailnum)

flights %>%
  group_by(tailnum) %>%
  filter(all(is.na(arr_delay))) %>%
  select(tailnum, everything())

# 3

flights %>%
  mutate(on_time = (arr_delay <= 0 & !is.na(arr_delay))) %>%
  mutate(time_of_day = ifelse(sched_dep_time <= 600, "redeye",
                              ifelse(sched_dep_time <= 1200, "morning",
                                     ifelse(sched_dep_time <= 1800, "afternoon",
                                            "night")))) %>%
  group_by(time_of_day) %>%
  summarize(flights = n(),
            prop_on_time = mean(on_time)) %>%
  arrange(prop_on_time)

flights %>%
  ggplot(mapping = aes(x=factor(hour), fill = (arr_delay>0 | is.na(arr_delay)))) +
  geom_bar()

# It looks like evening / night flights have the most delays. It's best to fly a redeye or early in the morning.

# 4

flights %>%
  filter(arr_delay > 0 & !is.na(arr_delay)) %>%
  group_by(dest) %>%
  mutate(tot_dest_delay = sum(arr_delay)) %>%
  ungroup() %>%
  mutate(prop_delay = arr_delay / tot_dest_delay) %>%
  select(tailnum, dest, tot_dest_delay, arr_delay, prop_delay, everything()) %>%
  arrange(desc(prop_delay))

# 5

flights %>%
  filter(!is.na(dep_delay)) %>%
  group_by(origin) %>%
  arrange(sched_dep_time) %>%
  mutate(prev_delay = lag(dep_delay)) %>%
  filter(!is.na(prev_delay)) %>%
  ggplot(mapping = aes(x = prev_delay, y = dep_delay)) +
  geom_point()

# 6

flights %>%
  filter(!is.na(air_time)) %>%
  group_by(dest) %>%
  mutate(min_distance = min(distance)) %>%
  mutate(min_air_time = ifelse(near(distance, min_distance), air_time, NA)) %>%
  mutate(min_air_time = min(min_air_time, na.rm = TRUE)) %>%
  mutate(rel_time = air_time / min_air_time) %>%
  filter(rel_time < 1) %>%
  select(dest, origin, min_distance, min_air_time, distance, air_time, rel_time, everything()) %>%
  arrange(rel_time)

flights %>%
  filter(!is.na(air_time)) %>%
  group_by(dest, origin) %>%
  mutate(med_flight = median(air_time)) %>%
  mutate(rel_time = air_time / med_flight) %>%
  select(dest, origin, distance, med_flight, air_time, rel_time, everything()) %>%
  arrange(desc(rel_time))

# 7

flights %>%
  group_by(dest) %>%
  mutate(n_carrier = n_distinct(carrier)) %>%
  filter(n_carrier >= 2) %>%
  ungroup() %>%
  group_by(carrier) %>%
  summarize(attract = max(n_carrier),
            dests = n_distinct(dest)) %>%
  arrange(desc(attract), desc(dests))