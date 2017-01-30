// Analysis of Experiment Activity from Day 1

// import data
import delimited activity01.tsv, varnames(1)

// anayze experiment
// t-test
ttest guess, by(group)
ttest guess, by(group) unequal

// OLS regression
encode group, gen(treatment)
reg guess i.treatment 

// OLS regression with robust standard errors
reg guess i.treatment, r

// ANOVA
oneway guess group

// F-test equivalent to t-test when only two conditions
// F = t^2


// standardized effect size measure
esize twosample guess, by(treatment)
