# Post-hoc examination of effect heterogeneity

source("johnston/johnston.R")

# Quantile-Quantile plot
qqplot(johnston[["outcome"]][johnston[["tr"]] == 0],
       johnston[["outcome"]][johnston[["tr"]] == 1])
curve((x), from = 0, to = max(johnston[["outcome"]], na.rm = TRUE), add = TRUE)

# "fully saturated" regression w/ treatment interacted with:
## party identification
## interest in politics
## gender
## education (years)
## race/ethnicity
m <- lm(outcome ~ tr*(XPARTY7 + XPP10035 + factor(PPGENDER) + factor(PPEDUC) + factor(PPETHM)), data = johnston)
summary(m)

# Plots of CATEs
cplot(m, x = "XPARTY7", dx = "tr", what = "effect")
cplot(m, x = "XPP10035", dx = "tr", what = "effect")
cplot(m, x = "PPGENDER", dx = "tr", what = "effect")
cplot(m, x = "PPEDUC", dx = "tr", what = "effect")
cplot(m, x = "PPETHM", dx = "tr", what = "effect")
