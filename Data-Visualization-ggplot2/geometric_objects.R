# A geom is the geometrical object that a plot uses to represent data.

library(tidyverse)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv, linetype = drv))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv), show.legend = FALSE)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

# The last group of code would be better as a global mapping
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth()

# Override global data by passing a data argument to a sublayer of the plot
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)

# Exercises

# 1. 

# Line chart: geom_line
# Boxplot: geom_boxplot
# Histogram: geom_histogram
# Area chart: geom_area

# 2.

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)

# 3.

# show.legend = FALSE suppresses the legend from appearing on the graph. If you remove it, the legend key
# will appear on the plot. He included it earlier in the chapter to show how when using an aesthetic that
# uses groups that isn't the group aesthetic, you have to manually suppress the legend. If for example
# you use color, size, shape, etc. by a category in the data then the plot will automatically generate
# a legend.

# 4.

# The se argument to geom_smooth() allows you to toggle the standard error bars on or off for the plot.

# 5.

# Yes, both commands generate the same plot. The first way, only supplying the data globally, causes
# each geom layer to inherit the same data that we supply locally to each geom layer in the second
# way.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

ggplot() +
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# 6.

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(mapping = aes(group = drv), se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(mapping = aes(color = drv), se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(mapping = aes(linetype = drv), se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point()