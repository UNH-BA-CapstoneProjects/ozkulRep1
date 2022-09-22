
# Data Handling, filtering, subsetting, ordering, and other data operations
# In standard these procedure can be done, however, there is a package
# specialized in data handling, that is called 'dplyr'

d = read.csv("datasets/survey.csv")
View(d)

# Show height and weight of the males

d[ d$gender == "m"   , c("height","weight")]

# Show all information on customers who feel excellent, 
# age less than 30, and have a health plan

d[d$genhlth == "excellent" & d$age < 30 & d$hlthplan == 1  ,  ]


# To use a package, two things are needed;
# 1) Install the package using install.packages("packagename") function
# 2) When you are ready to use it, use library(packagename)

# install.packages("dplyr")

library(dplyr)

# dplyr is a package for data manipulation, written and 
# maintained by Hadley Wickham. It is part of a larger package
# called "tidyverse". It provides some great,
# easy-to-use functions that are very handy when performing
# data handling and exploratory data analysis.

# ------- Piping operator: %>%  

# The main idea in dplyr approach is you process the data
# in seperate steps which follow each other in a workflow.

# SELECT(): To select the columns to show
# Show me the customer's height, weight and age columns

d %>%
  select(height, weight, age)


# Show me the data in genhlth, smoke100, gender

d %>%
  select(genhlth, smoke100, gender)


# FILTER(): To filter the rows based on some criteria

# Show height and weight of the males using dplyr

# base R

d[ d$gender == "m"   , c("height","weight")]

# dplyr

d %>%
    filter(gender == "m") %>%
    select(height, weight)

# Put the results of the previous question in a variable

maleHW <- d %>%
            filter(gender == "m") %>%
            select(height, weight)

View(maleHW)

# Show weight, age, smoke100 for customers who feel excellent, 
# age less than 30, and have a health plan


# Option-1: Standard Base R

d[d$genhlth == "excellent" & d$age < 30 & d$hlthplan == 1  ,  c("weight", "age", "smoke100")]


# Option-2: dplyr package

d %>%
  filter(genhlth == "excellent") %>%
  filter(age < 30) %>%
  filter(hlthplan == 1) %>%
  select(weight, age, smoke100) 


# Calculate the mean weight for customers who feel excellent, 
# age less than 30, and have a health plan

selectedData <-  d %>%
                    filter(genhlth == "excellent") %>%
                    filter(age < 30) %>%
                    filter(hlthplan == 1) %>%
                    select(weight) 

mean(selectedData$weight)

# ------- MUTATE(): To insert a new column into the dataframe

# Calculate a new column showing difference between current weight and desired weight
# The name of the new column would be "wdiff"
# Keep the resulting new dataframe in a new variable called "newd"

# base R

d$wdiff = d$wtdesire - d$weight

# delete the wdiff now using NULL

d$wdiff <- NULL

# dplyr

newd  <- d %>% 
            mutate( wdiff = wtdesire - weight)


View(newd)   # the new dataset with the new column
View(d)      # original data which stayed unchanged


# Calculate the following formula for customers who feel poor or fair
# wratio = (weight - wtdesire)/weight

b <- d %>%
        filter(genhlth == "poor" | genhlth == "fair") %>%
        mutate(wratio = (weight - wtdesire)/weight)

View(b)

# another scenario:

b <- d %>%
  mutate(wratio = (weight - wtdesire)/weight) %>%
  filter(genhlth == "poor" | genhlth == "fair") 

View(b)


#------- ARRANGE(): To sort the dataset

# Sort the d dataframe by genhlth.

b <- d %>%
        arrange(genhlth)

View(b)

# Sort the d dataframe by genhlth and then age.

b <- d %>%
  arrange(genhlth, age)

View(b)


# Calculate the following formula for customers who feel poor or fair
# wratio = (weight - wtdesire)/weight

# and then sort the resulting dataset by wratio
# Put the result in a variable called sortedD



#------ SUMMARIZE(): To calculate summary statistics on the columns

# Calculate mean of height and weight, sum of total number of smokers, and
# count of the entire dataset (Hint: use n() for count )



# Calculate mean of height and weight, and sum of total number of smokers 
# for males who are older than 30





#------ GROUP_BY(): To create groups in the dataset based one or more variables.
# It usually goes with summarize().
# Create groups based genhlth variable and calculate count of each group,
# mean of height and weight in each group, and sum of total number of smokers in each group.

# Calculate mean of height and weight, sum of total number of smokers, and
# the count for each genhlth category 






# Create groups based gender and smoke100 variables and calculate count of each group,
# mean of height and weight in each group, and sum of total number of smokers in each group.


