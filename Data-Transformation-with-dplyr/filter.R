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
  mutate(tau = sched_arr_time - sched_dep_time) %>%
  mutate(t = arr_time - dep_time) %>%
  filter(dep_delay >= 60, tau - t > 30) %>%
  select(-c(tau, t))

red_eye <- flights %>%
  filter(dep_time >= 0 & dep_time <= 360)

# 2.

# Between let's you easily filter when a value is greater than or equal to a lower bound and less
# than or equal to an upper bound (i.e. x >= l & x <= u).

red_eye <- flights %>%
  filter(between(dep_time, 0, 360))

# 3.

(summary <- flights %>%
    filter(is.na(dep_time)) %>%
    summarize(n = n()))

# 8255 flights have a missing departure time. dep_delay, arr_time, arr_delay, air_time also have missing values.
# These missing rows probably correspond to flights that were cancelled.

# 4. 

# NA ^ 0 = 1 is not missing because anything to the power of 0 is 1 (0 ^ 0 is often defined as being 1.
# You can make a case that inf ^ 0 = 1 from lim(n->inf)(n^(1/n)) = 1, even though inf ^ 0 is indeterminate).
# NA | TRUE = TRUE is not missing because no matter what we substitue for NA the expression will evaluate to TRUE.
# FALSE & NA = FALSE is also not missing for the same reason as the last example, it's just that the expression will
# evaluate to FALSE.
# The general rule is that whenever the output of an expression involving NA is independent of the value of the NA,
# then R will evaluate the result. NA * 0 is NA since inf * 0 is indeterminate.
