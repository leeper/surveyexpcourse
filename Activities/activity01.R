# Analysis of Experiment Activity from Day 1

## import data
dat <- read.delim("activity01.tsv")

## anayze experiment
### t-test
t.test(Guess ~ Group, data = dat)

##         Welch Two Sample t-test
## 
## data:  Guess by Group
## t = -2.0206, df = 12.261, p-value = 0.06572
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -18499497.6    675246.6
## sample estimates:
## mean in group Group 1 mean in group Group 2 
##               1441721              10353846

### OLS regression
summary(lm(Guess ~ Group, data = dat))

## Call:
## lm(formula = Guess ~ Group, data = dat)
## 
## Residuals:
##       Min        1Q    Median        3Q       Max 
## -10353844  -5353846   -841721   -241721  49646154 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)  
## (Intercept)   1441721    3313236   0.435   0.6675  
## GroupGroup 2  8912126    4594632   1.940   0.0648 .
## ---
## Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
## 
## Residual standard error: 11480000 on 23 degrees of freedom
## Multiple R-squared:  0.1406,    Adjusted R-squared:  0.1032 
## F-statistic: 3.762 on 1 and 23 DF,  p-value: 0.06478
