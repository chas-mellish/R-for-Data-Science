library(tidyverse)

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip()

nz <- map_data("nz")
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black")
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black") +
  coord_quickmap()

bar <- ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut),
           show.legend = FALSE,
           width = 1) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

# Exercises

# 1.

bar <- ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) +
  geom_bar(width = 1) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar
bar + coord_polar()

# 2.

?labs

# labs() allows you to modify the axis labels for a plot

# 3.

# coord_map and coord_quickmap do about the same things, but coord_map allows you to choose the type of projection
# you want to use for your map. coord_quickmap has a default approximation method that allows you to compute
# the projection quickly.

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black") +
  coord_map()

# 4.

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() +
  geom_abline() +
  coord_fixed()

# The plot shows that hwy miles per gallon is always greater than city miles per gallon. In normal
# lingo, cars run more efficiently on the highway than they do in the city. coord_fixed is important
# because it retains the aspect ratio between the x and y values; without it, the relationship
# would look distorted. geom_abline creates a line on the plot with a default slope of 1 and 
# intercept of 0. It's the identity line in this case which allows us to draw the conclusion we did.