# Analysis of Experiment from Opening Activity 1

# import data
dat <- rio::import("https://docs.google.com/spreadsheets/d/1SKWljS1EeNkAV5V0NZUwrKOu3LQFILVMB37xfTxyrPM/edit#gid=778386445")
#dat <- read.delim("activity01.tsv")

# cleanup data slightly
dat[["Guess"]] <- as.numeric(gsub("[[:punct:]]", "", dat[["Guess"]]))

# anayze experiment #

## t-test
t.test(Guess ~ Group, data = dat) # unequal variances assumed
t.test(Guess ~ Group, data = dat, var.equal = TRUE)

## OLS regression
s <- summary(m <- lm(Guess ~ Group, data = dat))

### OLS /w heteroskedasticity consistent standard errors
#install.packages("sandwich")
sandwich::vcovHC(m)
s$coefficients[,2] <- sqrt(diag(vcovHC(m)))
s$coefficients[,3] <- s$coefficients[,1]/s$coefficients[,2]
s$coefficients[,4] <- 2*(1-pt(s$coef[,3], df = nrow(dat)-2L))
s

## ANOVA
summary(aov(Guess ~ Group, data = dat))

### F-test equivalent to t-test when only two conditions
### F = t^2
