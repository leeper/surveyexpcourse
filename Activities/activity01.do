// Analysis of Experiment Activity from Day 1

// import data
import delimited activity01.tsv

// anayze experiment
// t-test
ttest guess, by(group)


// OLS regression

encode group, gen(treatment)
reg guess i.treatment 

reg guess i.treatment 
