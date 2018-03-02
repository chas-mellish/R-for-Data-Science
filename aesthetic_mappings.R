# The aesthetic function is mapping a variable to an aesthetic of the plot. It explains the relationship between
# the value of the variable and how it should be displayed and where it should be located on the plot. ggplot2
# handles the rest.

library(tidyverse)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

# Bad news bears
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

# Set aesthetic manually, ignoring the mapping based on a variable's value
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# Exercises

# 1.
# The points aren't blue because we're mapping the color aesthetic to the character string "blue", which
# takes on only one value. Hence the plot displays in only one color level which is chosen by ggplot2 to
# be the default (the default color is not blue).

# 2.
mpg

# Cateogrical variables: manufacturer, model, year, cyl, trans, drv, fl, class
# Continuous variables: displ, cty, hwy
# distinct(mpg, <VARNAME>) is helpful here too.

# 3.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = cty))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = cty))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = cty))

# Color forms a gradient. Size makes more sense, and the size now helps you visualize a third variable in the plot.
# Shape doesn't work at all, which makes sense since there are only a limited, discrete number of available shapes.
# Moreove, ggplot2 will only use six shapes at a time on a plot.

# 4.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class, shape = class))

# If you map the same variable to multiple aesthetics, it provides visual redundancy. You'll get multiple uniqueness
# in your plot. That is, not only will each variable be represented by a different color, it will also have a
# different shape

# 5.
# The stroke aesthetic modifies the width of the border. It works with filled shapes (i.e. shapes that have both
# a border and a fill)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), shape = 21, color = "black", fill = "red", stroke = 9)

# 6.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))

# When you map the aesthetic to something other than a variable name, in this case a vector of booleans,
# the aesthetic will be applied to the distinct values of that vector. After all, a variable of a dataframe
# is just a vector of values. This would be like us generating a new variable in mpg that is TRUE whenever
# displ < 5 and FALSE whenever it's greater.