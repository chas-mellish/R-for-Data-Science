# A stat is the algorithm used to calculate new values for a graph

library(tidyverse)

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

ggplot(data = diamonds) +
  stat_count(mapping = aes(x = cut))

demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)

ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

ggplot(data = diamonds) +
  stat_summary(mapping = aes(x = cut, y = depth),
               fun.ymin = min,
               fun.ymax = max,
               fun.y = median)

# Exercises

# 1.

# stat_summary's associated geom is geom_pointrange. We found that by doing ?stat_summary and seeing that
# the default geom argument is "pointrange"..

ggplot(data = diamonds) +
  geom_pointrange(mapping = aes(x = cut, y = depth),
                  stat = "summary",
                  fun.ymin = min,
                  fun.ymax = max,
                  fun.y = median)

# 2.

# geom_col uses the raw data to generate the heights of the bars for a bar chart, unlike geom_bar which
# computes the count of observations per bin and plots that as the height.

# 4.

# stat_smooth computes the following:
# y: predicted value for the x input
# ymin: the lower pointwise confidence interval around the mean
# ymax: the upper pointwise confidence interval around the mean
# se: standard error in the data
# The formula and level parameters control this behavior.

# 5.

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop..))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop..))

# The stat computes a prop = 1 for all cuts. By assigning some grouping, it could be any grouping, we're effectively
# telling it to show the proportion relative to other cuts.