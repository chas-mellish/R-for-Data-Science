library(nycflights13)
library(Lahman)
library(tidyverse)

summarize(flights, delay = mean(dep_delay, na.rm = TRUE))

by_day <- group_by(flights, year, month, day)
summarize(by_day, delay = mean(dep_delay, na.rm = TRUE))

delays <- flights %>%
  group_by(dest) %>%
  summarize(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
    ) %>%
  filter(count > 20, dest != "HNL")

ggplot(data = delays, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))

delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarize(
    delay = mean(arr_delay)
  )

ggplot(data = delays, mapping = aes(x = delay)) +
  geom_freqpoly(bindwidth = 10)

delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarize(
    delay = mean(arr_delay),
    count = n()
  )

ggplot(data = delays, mapping = aes(x = count, y = delay)) +
  geom_point(alpha = 1/10)

delays %>%
  filter(count > 25) %>%
  ggplot(mapping = aes(x = count, y = delay)) +
  geom_point(alpha = 1/10)

batting <- as_tibble(Lahman::Batting)

batters <- batting %>%
  group_by(playerID) %>%
  summarize(
    ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    ab = sum(AB, na.rm = TRUE)
  )

batters %>%
  filter(ab >  100) %>%
  ggplot(mapping = aes(x = ab, y = ba)) +
  geom_point() +
  geom_smooth(se = FALSE)

not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(
    avg_delay1 = mean(arr_delay),
    avg_delay2 = mean(arr_delay[arr_delay > 0])
  )

not_cancelled %>%
  group_by(dest) %>%
  summarize(distance_sd = sd(distance)) %>%
  arrange(desc(distance_sd))

not_cancelled %>%
  group_by(month, day, year) %>%
  summarize(
    first = min(dep_time),
    last = max(dep_time)
  )

not_cancelled %>%
  group_by(month, day, year) %>%
  summarize(
    first = first(dep_time),
    last = last(dep_time)
  )

not_cancelled %>%
  group_by(year, month, day) %>%
  mutate(r = min_rank(desc(dep_time))) %>%
  filter(r %in% range(r))

not_cancelled %>%
  group_by(dest) %>%
  summarize(carriers = n_distinct(carrier)) %>%
  arrange(desc(carriers))

not_cancelled %>%
  count(dest)

not_cancelled %>%
  count(tailnum, wt = distance)

not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(n_early = sum(dep_time < 500))

not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(hour_perc = mean(arr_delay > 60))

daily <- group_by(flights, year, month, day)
(per_day <- summarize(daily, flights = n()))
(per_month <- summarize(per_day, flights = sum(flights)))
(per_year <- summarize(per_month, flights = sum(flights)))

daily %>%
  ungroup() %>%
  summarize(flights = n())

# Exercises

# 1.

# Arrival delay is more important than departure delay. A plane can make up time while in flight. Also people care more about when
# they get to their destination; leaving a few minutes late isn't as bad as arriving a few minutes late.

# A flight is 15 minutes early 50% of the time and 15 minutes late 50% of the time.

(el <- not_cancelled %>%
  mutate(early = arr_delay <= 0) %>%
  group_by(early) %>%
  summarize(
    flights = n(),
    mean = mean(arr_delay),
    sd = sd(arr_delay),
    mad = mad(arr_delay),
    med = median(arr_delay),
    q1 = quantile(arr_delay, 0.25),
    q2 = quantile(arr_delay, 0.75),
    max = max(arr_delay)
  ))

not_cancelled %>%
  mutate(early = arr_delay <= 0) %>%
  ggplot() +
  geom_boxplot(mapping = aes(x = early, y = arr_delay))

# Even excluding flights that are exactly on time, we see that flights are far more likely to be delayed by way
# more than the time that they are likely to be early. Of course, flights are more likely to be early or on time
# than they are to be delayed. That is, of course, among flights that weren't cancelled.

# A flight is always 10 minutes late

late <- not_cancelled %>%
  group_by(tailnum) %>%
  summarize(
    ten_min_late = mean(near(arr_delay, 10))
  ) %>%
  filter(ten_min_late == 1.0)

# 2.

not_cancelled %>%
  count(dest)

# Alternative

not_cancelled %>%
  mutate(n = 1) %>%
  group_by(dest) %>%
  summarize(n = sum(n))

not_cancelled %>%
  count(tailnum, wt = distance)

# Alternative

not_cancelled %>%
  group_by(tailnum) %>%
  summarize(n = sum(distance))

# 3.

# That definition requires the evaluation of two variables for every observation: the dep_delay and the arr_delay.
# The dep_delay is more important. If the dep_delay is not available then that's an indication that the plane never
# departed.

# 4.

cancelled <- flights %>%
  mutate(cancelled = is.na(dep_delay)) %>%
  group_by(year, month, day) %>%
  summarize(
    prop = mean(cancelled),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
  summarize(corr = cor(prop, delay))

# 5.

carrier <- not_cancelled %>%
  group_by(carrier) %>%
  summarize(
    flights = n(),
    mean_delay = mean(arr_delay),
    med_delay = median(arr_delay)
  ) %>%
  arrange(desc(mean_delay))

flights %>%
  group_by(carrier, dest) %>%
  summarize(n())

# 6.

# Counting cancelled flights as flights delayed more than one hour...

flights %>%
  group_by(tailnum) %>%
  arrange(year, month, day, dep_time) %>%
  mutate(delay = ifelse(is.na(arr_delay), 61, arr_delay)) %>%
  mutate(hour_delay = delay > 60) %>%
  mutate(cumsum = cumsum(hour_delay)) %>%
  summarize(flights_before_hour_delay = sum(cumsum == 0))

# 7.

flights %>%
  count(dest, sort = TRUE)

# The sort argument puts observations with the highest counts at the top of the data frame (it sorts by descending n).
# That's useful when you are generating counts by group to see which groups have the highest number of observations.
