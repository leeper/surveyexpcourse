# Analysis of Experiment Activity from Day 1

## import data
dat <- rio::import("https://docs.google.com/spreadsheets/d/1SKWljS1EeNkAV5V0NZUwrKOu3LQFILVMB37xfTxyrPM/edit#gid=778386445")
dat <- read.delim("activity01.tsv")

## anayze experiment
### t-test
t.test(Guess ~ Group, data = dat)

### OLS regression
summary(lm(Guess ~ Group, data = dat))
