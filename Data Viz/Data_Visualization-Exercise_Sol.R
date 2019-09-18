# Michael Ramsey
# Date Created: 10/16/2018
# Last Edited: 10/16/2018

# This is an r-script to provide solutions to the exercises that are presented in
# Data_Visualization.html.

# Load Necessary Libraries
library(tidyverse)
library(fivethirtyeight)
library(gridExtra)

# Load the data
bech_data <- bechdel

# Rescale Columns
bech_data$budget = bech_data$budget/1000000
bech_data$domgross = bech_data$domgross/1000000
bech_data$intgross = bech_data$intgross/1000000

##################################################
# Exercise Solutions
##################################################

############
# Exercise 1

# Problem: If you do not have the packages already, install the tidyverse, 
# fivethirtyeight, and gridExtra.

# Answer:
# install.packages(c("fivethirtyeight","gridExtra"))

############
# Exercise 2

# Problem: Make a quick plot of movie budget vs. domestic gross revenue using 
# a "point" geometry.

# Answer:
qplot(data = bech_data, x = budget, y = domgross, geom = "point")

############
# Exercise 3

# Problem: Make a histogram of the movie budgets. Interpret the y-axis as a 
# probability and make sure that there is  an apporpriate title and axis labels.

# Answer:
ggplot(data = bech_data, aes(x = budget, y = ..density..)) +
  geom_histogram() + 
  ggtitle("Distribution of movie budgets in bechdel dataset") +
  xlab("Budget")

############
# Exercise 4

# Problem: Edit your histogram in Exercise 3. Choose an appropriate number of 
# bins and colors.

# Answer:
ggplot(data = bech_data, aes(x = budget, y = ..density..)) +
  geom_histogram(fill = 'red', color = 'black', bins = 60) + 
  ggtitle("Distribution of movie budgets in bechdel dataset") +
  xlab("Budget")

############
# Exercise 5

# Problem: Continue editing the histogram from Exercise 4. Now group the data 
# by the outcome of the bechdel test and add density plots.

# Note: Try switching out color for fill

# Answer:
ggplot(data = bech_data, aes(x = budget, y = ..density.., color = binary)) +
  geom_histogram(position = "identity", bins = 60, alpha = .5) + 
  geom_density(alpha = .5) +
  ggtitle("Distribution of movie budgets in bechdel dataset") +
  xlab("Budget")

############
# Exercise 6

# Problem: Continue editing the histogram from Exercise 5. Re-title the legend and 
# save your plot.

# Answer:
ggplot(data = bech_data, aes(x = budget, y = ..density.., fill = binary)) +
  geom_histogram(position = "identity", bins = 60, alpha = .5) + 
  geom_density(alpha = .5) +
  ggtitle("Distribution of movie budgets in bechdel dataset") +
  xlab("Budget") + 
  scale_fill_discrete(name = "Test Outcome") +
  ggsave("My_Histogram.png", width = 5, height = 5)

############
# Exercise 7

# Problem: Add a title,change the axis labels, and change the legend 
# title to the last plot that we made.

# Answer:
ggplot(data = bech_data, aes(x = as.factor(desc(period_code)+5), y= domgross, color = as.factor(desc(period_code)+5))) + 
  geom_boxplot(notch = T) + 
  stat_summary(fun.y=mean, geom="point", color = 'red') + 
  ggtitle("Distibution of revenue by period") +
  xlab("Period") +
  ylab("Domestic Gross Revenue") +
  scale_color_discrete(name = "Test Outcome")

############
# Exercise 8

# Problem: Instead of outlining the last boxplot in color, fill the 
# boxplot in color. Make sure that the legend title is still changed! 
# Use the layer "scale_fill_discrete" when "fill" is used in the aes. 
# Use the layer "scale_color_discrete" when "color" is used in the aes.

# Answer:
ggplot(data = bech_data, aes(x = as.factor(desc(period_code)+5), y= domgross, fill = binary)) + 
  geom_boxplot(notch = T) +   ggtitle("Distibution of revenue by period") +
  xlab("Period") +
  ylab("Domestic Gross Revenue") +
  scale_fill_discrete(name = "Test Outcome")

############
# Exercise 9

# Problem: Change the color to red and linetype to dashed in the last figure.

# Answer:
ggplot(data = bech_data, aes(x = domgross, y = intgross)) + 
  geom_point() +
  geom_smooth(method = 'lm', se=T, color = 'red', linetype = 'dashed')

############
# Exercise 10

# Problem: Make regression lines for one of the last two scatter plots.

# Answer:
ggplot(data = bech_data, aes(x = domgross, y = intgross, color = binary)) + 
  geom_point() + 
  geom_smooth(method = 'lm')

##################################################
# Test Your Skills
##################################################

############
# Problem 1:
# Construct a jitter plot with period_code and whether or not the movie pased 
# the bechdel test.

# Answer:
ggplot(data = bech_data, aes(x = as.factor(desc(period_code)+5), y = binary)) +
  geom_jitter() +
  ggtitle("Outcome of bechdel test by period") +
  xlab("Period") +
  ylab("Test Outcome")

############
# Problem 2:
# Edit the bar plot in the "Extra Plots" section to have nice colors and labels.

# Answer:
ggplot(data = bech_data, aes(x = clean_test, fill = clean_test)) + 
  geom_bar() +
  ggtitle("Bar plot of reasons to fail/pass bechdel test") +
  xlab("Reason for failure/pass") +
  scale_fill_discrete(name = 'Failure Reason')

############
# Problem 3:
# Create a histogram of international gross revenue. 
# Add a density plot and make it fancy.

# Answer:
ggplot(data = bech_data, aes(x = intgross, y = ..density..)) +
  geom_histogram(bins = 60, color = 'black', fill = 'blue') +
  geom_density() + 
  ggtitle("Histogram of International Gross Revenue") +
  xlab("International Gross Revenue")

############
# Problem 4:
# Create a violin plot of international gross renevue, grouped by the 
# column clean_test.

# Answer:
ggplot(data = bech_data, aes(x = clean_test, y = intgross, fill = clean_test)) +
  geom_violin() + 
  ggtitle("International Revenue by failure/pass reason") + 
  xlab("Pass/Failure Reason") +
  ylab("Gross International Revenue") +
  scale_fill_discrete(guide = F)

############
# Problem 5:
# Create whatever scatter plot you want.

# Answer:
# See "Data_Visualization.html"