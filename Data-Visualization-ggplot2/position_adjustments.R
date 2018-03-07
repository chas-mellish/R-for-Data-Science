library(tidyverse)

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, color = cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))

ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) +
  geom_bar(alpha = 1 / 5, position = "identity")

ggplot(data = diamonds, mapping = aes(x = cut, color = clarity)) +
  geom_bar(fill = NA, position = "identity")

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")

ggplot(data = mpg) +
  geom_jitter(mapping = aes(x = displ, y = hwy))

# Exercises

# 1.

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point()

# The problem with the plot is that there is a lot of overlap of close values in the hwy mpg variable.
# Adding jitter should clear things up.

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_jitter()

# 2. 

# The width and height parameters control the amount of jittering.

# 3.

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_jitter()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_count()

# geom_jitter and geom_count both allow you to get a sense of how close data points are
# within a scatter plot. However, geom_jitter retains all of the original data points,
# jiggling them around a central bin. geom_count shows the number of points clustering around
# a bin by weighting the size of the bin on the graph by the number of points in the area.

# 4.

?geom_boxplot

# The default position is dodge

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot(mapping = aes(color = drv))