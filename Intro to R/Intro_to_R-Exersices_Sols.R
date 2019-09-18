# Michael Ramsey
# Date Created: 10/9/2018
# Last Edited: 10/9/2018

# This is an r-script to provide solutions to the exercises that are presented in
# intro_to_R.html.

# Load Necessary Libraries
library(tidyverse)
library(fivethirtyeight)

# Load the data
data <- US_births_1994_2003

############
# Exercise 1

# Problem: Install the fivethirtyeight package.

# Answer:
# install.packages("fivethirtyeight")

############
# Exercise 2

# Problem: Extract the day of the week column into a vector. Try to convert the 
# column into a numeric vector and see what happens.

# Answer:
weekday <- data$day_of_week
str(weekday)
weekday <- as.numeric(weekday)
# the entries in weekday now contain a number corresponding to the level of the factor

############
# Exercise 3

# Problem: Find the day where the least number of births occurred for our dataset and 
# also find the least number of births.

# Answer:
minindex <- which.min(births)
mindate <- data$date[minindex]
mindate
min(data$births)

############
# Exercise 4

# Problem: Filter out the data for the first half of the year (January through June).

# Answer:
half_data <- data %>%
  filter(month <= 6)

############
# Exercise 5

# Problem: Select the columns for year, day, and births out of jan_data and july_data. 
# Overwrite their entries.

#####################################################
data <- data %>%
  rename(day = date_of_month, weekday = day_of_week)
july_data <- data %>%
  filter(month== 7)
jan_data <- data %>%
  filter(month == 1)
#####################################################

# Answer:
july_data <- july_data %>%
  select(year,day,births)
jan_data <- jan_data %>%
  select(year,day,births)

############
# Exercise 6

# Problem: Create a column keeping track of the cumulative total of births. 
# Hint: use the summary function "cumsum(colname)".

# Answer:
data <- data %>%
  mutate(total = cumsum(births))

############
# Exercise 7

# Problem: Compute the average number of births by year, along with the 
# standard deviation.

# Answer:
yearly_mean <- data %>%
  group_by(year) %>%
  summarise(average = mean(births), sd = sd(births))

############
# Exercise 8

# Problem: Rename the new columns of joined_data.

################################################
# Join two data frames together
joined_data <- jan_data %>%
  left_join(july_data, by = c("year","day"))
################################################

# Answer:
joined_data <- joined_data %>%
  rename(January = births.x, July = births.y)

############
# Exercise 9

# Problem: Save one of your data frames in your environment to a csv.

# Answer:
#write.csv(joined_data,"Jan_Jul.csv")

############
# Exercise 10

# Problem: Create more plots to figure out what is accounting for our 
# birth differences in our scatter plot. 

# Answer:
# Try a boxplot by day of the week
# Boxplot of births by weekday
ggplot(data = data, aes(x=as.factor(weekday), y = births)) +
  geom_boxplot()

##################################################
# Test Your Skills
##################################################

############
# Problem 1:
# Find the month/year combo with the highest total number of births.

# Answer:
monthly_births <- data %>%
  group_by(year,month) %>%
  summarise(births = sum(births))
maxindex <- which.max(monthly_births$births)
maxyear <- monthly_births$year[maxindex]
maxmonth <- monthly_births$month[maxindex]

############
# Problem 2:
# Find the month/year combo with the least total number of births.

# Answer:
minindex <- which.min(monthly_births$births)
maxyear <- monthly_births$year[minindex]
minmonth <- monthly_births$month[minindex]

############
# Problem 3:
# Find the month/year combo with the least total number of births.

# Answer:
minindex <- which.min(monthly_births$births)
maxyear <- monthly_births$year[minindex]
minmonth <- monthly_births$month[minindex]

############
# Problem 4:
# Find the month/year combo with the least total number of births.

# Answer:
weekend_data <- data %>%
  filter(weekday == "Sun" | weekday == "Sat")
ggplot(data = weekend_data, aes(x=births, fill = as.factor(weekday))) +
  geom_histogram(bins = 30)
# More births on saturday

############
# Problem 5:
# Compute the average number of births by season.

# Answer:
winter_data <- data %>%
  filter(winter == T) %>%
  summarise(average = mean(births))
fall_data <- data %>%
  filter(fall == T) %>%
  summarise(average = mean(births))

############
# Problem 6:
# Extract the births for valentines day. Create a dot-plot of the values.

# Answer:
val_data <- data %>% 
  filter(month==2,day==14)
ggplot(val_data, aes(x = date, y=births)) + 
  geom_dotplot(binaxis='y', stackdir='center')
# I wonder if those two births occurred on weekends? 