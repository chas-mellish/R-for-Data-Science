# Facets produce subplots, one for each subset of the data. They are particularly useful for categorical
# variables

library(tidyverse)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

# Exercises

# 1.
# Hmm, let's see. I assume it throws an error.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ cty)
# Nope it looks like it tries to bucket it into a reasonable number of bins and plots them.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(~ cty)
# The plot doesn't make a whole lot of sense with the default value for the grid. You
# probably have to adjust a bunch of settings.

# 2.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = drv, y = cyl)) +
  facet_grid(drv ~ cyl)
# The empty cells in the facet plot indicate that there are no cars in the data that have that
# combination of drive and cylinders. For example, there are no cars that are four-wheel drive
# and have 5 cylinders. You can see this more clearly with the command below.
mpg %>% group_by(drv, cyl) %>% summarize(count = n())

# 3.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

# These pieces of code let you slice the plots vertically or horizontally (depending on the
# orientation of the formula) by some other factor. It's an alternative to plotting the
# groups in buckets by row and column.

# 4.
# By using faceting, you can see the relationship between the independent and dependent variables
# of the plot more clearly _within_ each subgroup. However, one of the drawbacks is that
# you can't see the distinguishing features of each subgroup as clearly, making it more
# difficult to pick out the clusters. With a larger dataset it would be too impractical to determine
# the relationship between the variables by subgroup. It would be better to build some intuition
# using smaller subsets of the data and then perhaps constructing a model where you can see
# the effects each subgroup has on the relationship.

# 5.
# nrow and ncol dicatate the number of rows and columns the facet plots should be displayed in. For
# example, if you have 10 categories in which you're faceting, the ncol = 5 says that you want to
# display the 10 plots as a (2, 5) array.
# Facet grid does not have nrow and ncol arguments because it creates a series of panels based on
# the number of row and column facetting variables. If you have a LH categorical variable with
# four values and a RH categorical variable with five values, then facet_grid will generate a
# panel plot with four rows and five columns

# 6.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)
# Looking at variations of the above plot, it's easier to orient left to right than bottom to top.
# So putting the variable with more information with the columns makes the graphic easier to digest.