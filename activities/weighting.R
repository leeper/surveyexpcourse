# Weighted and unweighted analyses

if (!require("survey")) {
    install.packages("survey")
    library("survey")
}

## Schuldt example
source("schuldt/schuldt.R")

# examine the poststratification weights
## note: TESS datasets will only have post-stratification weights (no design weights) except in rare circumstances
summary(schuldt[["weight"]])
hist(schuldt[["weight"]])

# look at unweighted analysis
summary(lm(outcome ~ gw, data = schuldt))

# use svydesign() to specify a weighted design
design1 <- svydesign(id = ~CaseID, data = schuldt, weights = ~weight)
# use svyglm() to estimate the weighted regression
summary(svyglm(outcome ~ gw, design = design1))

# the SATE estimate is equivalent to a weighted mean:
schuldt[["wtoutcome"]] <- with(schuldt, outcome * weight)
summary(lm(wtoutcome ~ gw, data = schuldt))
## but variance estimates are incorrect!


## Johnston (factorial) example
source("johnston/johnston.R")
hist(johnston[["weight"]])

# look at unweighted analysis
summary(m <- lm(outcome ~ tr*cues*args, data = johnston))
margins(m)

# use svydesign() to specify a weighted design
design2 <- svydesign(id = ~CaseID, data = johnston, weights = ~weight)
# use svyglm() to estimate the weighted regression
summary(svyglm(outcome ~ tr*cues*args, design = design2))
