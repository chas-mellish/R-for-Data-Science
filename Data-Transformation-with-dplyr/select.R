library(nycflights13)
library(tidyerse)

# Exercises

# 2.

select(flights, year, year)
select(flights, year, month, year)

# If you include a variable twice in a select call, you get a data frame that only contains that variable once.

# 3.

?one_of

# One of allows you to select variables if you have the variables stored as strings in a character vector.
# Select takes the variable names as unquoted, so if you have them quoted, then you can use this to circumvent
# the restriction.

# 4.

select(flights, contains('TIME'))

# The result does surpise me. I would have thought that contains would have been case sensitive. But the above
# line of code returns all columns in flights that contain the string "time". The helpers must be ignoring
# case by default. We can toggle that off by passing the argument ignore.case = FALSE to the helper function call:

select(flights, contains('TIME', ignore.case = FALSE))