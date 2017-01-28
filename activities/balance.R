# Balance testing

source("schuldt/schuldt.R")

# Mean comparisons and significance tests
## age
aggregate(PPAGE ~ gw, data = schuldt, FUN = mean, na.rm = TRUE)
t.test(PPAGE ~ gw, data = schuldt)

## party identification
aggregate(PARTY7 ~ gw, data = schuldt, FUN = mean, na.rm = TRUE)
t.test(PARTY7 ~ gw, data = schuldt)

## gender
aggregate(PPGENDER ~ gw, data = schuldt, FUN = mean, na.rm = TRUE)
t.test(PPGENDER ~ gw, data = schuldt)

## education (years)
aggregate(PPEDUC ~ gw, data = schuldt, FUN = mean, na.rm = TRUE)
t.test(PPEDUC ~ gw, data = schuldt)

## race/ethnicity
prop.table(with(schuldt, table(PPETHM, gw)), 2)


# regress treatment condition on covariates
summary(lm(gw ~ PPAGE + PARTY7 + PPGENDER + PPEDUC + PPETHM, data = schuldt))

