# Using treatment as an instrument for mediator or manipulation check

library("AER")
source("johnston/johnston.R")

# manipulation check
table(johnston[["check"]])

# experimental equation
summary(lm(outcome ~ tr, data = johnston))


# "first-stage" equation
summary(lm(check ~ tr, data = johnston))

# "second-stage" equation
summary(lm(outcome ~ check, data = johnston))
reg outcome check

# 2SLS estimation
summary(ivreg(outcome ~ check, ~ tr, data = johnston))

