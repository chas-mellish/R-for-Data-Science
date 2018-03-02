# Do cars with big engines user more fuel than cars with small engines?

library(tidyverse)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

# Exercises

# 1.
# It's an empty plot.

# 2.
print(paste0("There are ", nrow(mtcars), " rows in mtcars"))
print(paste0("Meanwhile, there are ", ncol(mtcars), " columns in mtcars"))

# 3.
# The drv variable tells us if the vehicle operates as front-wheel dirve, rear-wheel drive, or four-wheel drive

# 4.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = cyl, y = hwy))