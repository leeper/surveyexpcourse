# R code for EUI Workshop on Survey Experiments

#------------------------------#
## Setup                      ##
#------------------------------#


# Example datasets from TESS
# http://www.tessexperiments.org/data/holbrook120.html
utils::download.file("http://www.tessexperiments.org/data/zip/holbrook120.zip", "holbrook120.zip", mode = "wb")
# http://www.tessexperiments.org/data/schuldt301.html
utils::download.file("http://www.tessexperiments.org/data/zip/Schuldt301.zip", "Schuldt301.zip", mode = "wb")
# http://www.tessexperiments.org/data/newman508.html
utils::download.file("http://www.tessexperiments.org/data/zip/NewmanJohnston508.zip", "NewmanJohnston508.zip", mode = "wb")


install.packages(c("ghit", "rio", "ggplot2", "list"))

library("stats")
library("ghit")    # installing github packages
library("rio")     # data loading
library("ggplot2") # plotting
library("list")    # alternative list experiment estimators
ghit::install_github("leeper/mcode")
library("mcode")   # convenience functions for working with data recoding
ghit::install_github("leeper/prediction", build_vignettes = FALSE)
ghit::install_github("leeper/margins", build_vignettes = FALSE)
library("margins") # marginal effects


#------------------------------#
## Opening Activity           ##
#------------------------------#

dat <- rio::import("https://docs.google.com/spreadsheets/d/1SKWljS1EeNkAV5V0NZUwrKOu3LQFILVMB37xfTxyrPM/edit#gid=778386445")
dat[["Guess"]] <- as.numeric(gsub("[[:punct:]]", "", dat[["Guess"]]))
t.test(Guess ~ Group, data = dat)
summary(lm(Guess ~ Group, data = dat))


#------------------------------#
## Variance and Power         ##
#------------------------------#

# variance estimation
se_mean <- function(x, sd = 3) {
    # assumes SRS, infinite sample
    sqrt((sd^2)/x)
}

se_mean_diff <- function(x, sd = 3) {
    # assumes SRS, infinite sample, equal sized groups
    s1 <- (sd^2)/floor(x/2)
    s2 <- (sd^2)/ceiling(x/2)
    sqrt(s1 + s2)
}

curve(se_mean, from = 20, to = 2000, col = "red", lwd = 2, las = 1)
curve(se_mean_diff, from = 20, to = 2000, add = TRUE, col = "blue", lwd = 2)

library("ggplot2")
ggplot(, aes(x = se_mean(2:5000), y = se_mean_diff(2:5000))) + 
    geom_line(col = "red") + 
    stat_function(fun = I) +
    xlim(0, 1) + ylim(0, 1)


var(replicate(5000, mean(rnorm(500)) - mean(rnorm(500)) ))
var(replicate(5000, mean(rnorm(1000)) ))

sd(replicate(5000, mean(rnorm(500)) - mean(rnorm(500)) ))
sd(replicate(5000, mean(rnorm(1000)) ))


# power
## large effect
power.t.test(, delta = 1, sd = 1, sig.level = 0.05, power = 0.8, type = "two.sample", alternative = "two.sided")

## varying effect sizes
lapply(seq(0.1, 1, by = 0.1), function(eff) {
    power.t.test(, delta = eff, sd = 1, sig.level = 0.05, power = 0.8, type = "two.sample", alternative = "two.sided")
})

## subgroup effect sizes -> need to estimate size of subgroup or use unequal selection probabilities

# Calculation of Cohen's d standardized mean-difference
cohensd <- function(x, y) {
    # x treatment group indicator vector
    # y outcome vector
    if (nlevels(factor(x)) != 2) {
        stop("Number of group levels not equal to 2.")
    }
    # calculate mean-difference
    dif <- diff(tapply(y, x, mean, na.rm = TRUE))
    # calculate sigma
    ngroups <- tapply(y, x, length)
    v <- tapply(y, x, var, na.rm = TRUE)
    sigma <- sqrt(sum((ngroups - 1L) * v, na.rm = TRUE)/(sum(ngroups, na.rm = TRUE) - 2L))
    # return
    return(unname(dif/sigma))
}



#------------------------------#
## Randomization Distribution ##
#------------------------------#

# theoretical randomizations
onedraw <- function() {
  r <- replicate(nrow(dat), sample(1:2,1))
  dat[cbind(1:nrow(dat),r)] <- NA
  return(mean(dat[dat[["Group"]] == "Group 2","Guess"], na.rm=TRUE) -
         mean(dat[dat[["Group"]] == "Group 1","Guess"], na.rm=TRUE) )
}

# simulate 2000 experiments from these data
x1 <- replicate(5000, onedraw())
hist(x1, col=rgb(1,0,0,.5), border = "white", main = "Randomization Distribution", xlab = "Possible Treatment Effect")
abline(v = 0, lwd = 1, lty = 2, col = "black")
abline(v = unname(diff(tapply(dat[["Guess"]], dat[["Group"]], mean, na.rm = TRUE))), lwd=3, col='red') # true effect



#------------------------------#
## Example 1: Schuldt         ##
## (Question wording)         ##
#------------------------------#


schuldt <- rio::import("Schuldt301.zip", which = "TESS2_117_Schuldt_Client.sav")
names(schuldt)
dim(schuldt)

# experimental conditions
table(schuldt[["XTESS117"]])
# 1,3,5,7 = "Global Warming"
# 2,4,6,8 = "Climate Change"
schuldt[["gw"]] <- ifelse(schuldt[["XTESS117"]] %in% c(1,3,5,7), 1L, 0L)

# outcome measure (1-7; higher values = gw happening)
table(schuldt[["Q3A"]], useNA = "always")
table(schuldt[["Q3B"]], useNA = "always")

# cleanup weirdness
schuldt[["Q3A"]] <- ifelse(is.nan(schuldt[["Q3A"]]), NA_real_, schuldt[["Q3A"]])
schuldt[["Q3B"]] <- ifelse(is.nan(schuldt[["Q3B"]]), NA_real_, schuldt[["Q3B"]])

# tidy these using mcode:
schuldt[["outcome"]] <- mergeNA(schuldt[["Q3A"]], schuldt[["Q3B"]])
schuldt[["outcome"]] <- ifelse(schuldt[["outcome"]] == -1, NA_real_, schuldt[["outcome"]])
table(schuldt[["outcome"]])
mean(schuldt[["outcome"]], na.rm = TRUE)
var(schuldt[["outcome"]], na.rm = TRUE)
sd(schuldt[["outcome"]], na.rm = TRUE)


aggregate(outcome ~ gw, data = schuldt, mean, na.rm = TRUE)
t.test(outcome ~ gw, data = schuldt)
summary(lm(outcome ~ gw, data = schuldt))
t.test(outcome ~ gw, data = schuldt, var.equal = TRUE)

# standardized effect size measure
cohensd(x = schuldt[["gw"]], y = schuldt[["outcome"]])

power.t.test(, delta = .17, sd = 1, sig.level = 0.05, power = 0.8, type = "two.sample", alternative = "two.sided")

# moderation by party
# 1:3 = Republican
# 5:7 = Democrat
table(schuldt[["PARTY7"]], useNA = "always")
schuldt[["republican"]] <- ifelse(schuldt[["PARTY7"]] %in% 1:3, 1L, 
                                  ifelse(schuldt[["PARTY7"]] %in% 5:7, 0L, NA_real_))
table(schuldt[["PARTY7"]], schuldt[["republican"]], useNA = "always")

aggregate(outcome ~ gw + republican, data = schuldt, mean, na.rm = TRUE)
t.test(outcome ~ gw, data = schuldt[schuldt[["republican"]] == 1L,])
t.test(outcome ~ gw, data = schuldt[schuldt[["republican"]] == 0L,])

# standardized effect size measure
with(schuldt[schuldt[["republican"]] == 1L,], cohensd(x = gw, y = outcome))
with(schuldt[schuldt[["republican"]] == 0L,], cohensd(x = gw, y = outcome))


summary(m_by_party <- lm(outcome ~ gw * republican, data = schuldt))
summary(margins(m_by_party))
cplot(m_by_party, x = "republican", dx = "gw", what = "effect")

summary(m_by_party2 <- lm(outcome ~ gw * PARTY7, data = schuldt))
cplot(m_by_party2, x = "PARTY7", dx = "gw")
cplot(m_by_party2, x = "PARTY7", dx = "gw", what = "effect")

schuldt[["pfactor"]] <- as.factor(schuldt[["PARTY7"]])
cplot(lm(outcome ~ gw * pfactor, data = schuldt), x = "pfactor", dx = "gw")
cplot(lm(outcome ~ gw * pfactor, data = schuldt), x = "pfactor", dx = "gw", what = "effect")



# search for effect heterogeneity
covariates <- c("gw", "republican", "PPGENDER", "PPAGE", "IDEO", "PPEDUC")
mhetero <- lm(outcome ~ gw * (. + I(IDEO^2)), data = schuldt[, c(covariates, "outcome"), drop = FALSE])
summary(mhetero)
summary(margins(mhetero))
cplot(mhetero, x = "republican", dx = "gw", what = "effect")
cplot(mhetero, x = "PPGENDER", dx = "gw", what = "effect")
cplot(mhetero, x = "PPAGE", dx = "gw", what = "effect")
cplot(mhetero, x = "IDEO", dx = "gw", what = "effect")
cplot(mhetero, x = "PPEDUC", dx = "gw", what = "effect")


# also possible using "bartMachine", but super clunky at the moment




#------------------------------#
## Example 2: Newman          ##
## (Activity)                 ##
#------------------------------#


newman <- rio::import("NewmanJohnston508.zip", which = "TESS3_171_Johnston_Client.sav")
names(newman)
dim(newman)

# complex factorial design
# Factor 1: depletion versus not
# Factor 2: cues versus no cues
# Factor 3: no argues, pro args, con args
# (note: conditions 1 and 8 are basically dropped; they are placebo conditions)

# Factor 1: depletion versus not
# two conditions in first factor: 1-7 control; 8-14 depletion treatment
newman[["tr"]] <- as.factor(ifelse(newman[["XTESS171"]] %in% 1:7, 0, ifelse(newman[["XTESS171"]] %in% 8:14, 1, NA_real_)))
# Factor 2: cues versus no cues
newman[["cues"]] <- as.factor(ifelse(newman[["XTESS171"]] %in% c(5:7, 12:14), 1, ifelse(newman[["XTESS171"]] %in% c(2:4, 9:11), 0, NA_real_)))
# Factor 3: no argues, pro args, con args
newman[["args"]] <- factor(ifelse(newman[["XTESS171"]] %in% c(2,5,9,12), 0, 
                                  ifelse(newman[["XTESS171"]] %in% c(3,6,10,13), 1, 
                                         ifelse(newman[["XTESS171"]] %in% c(4,7,11,14), -1, NA_real_))), levels = c(0, -1, 1))

# outcome (Q6A-Q6F; measured on 1-5 scale)
outcome <- newman[, paste0("Q6", LETTERS[1:6])]
outcome[] <- lapply(outcome, function(x) ifelse(is.nan(x), NA_real_, x))
newman[["outcome"]] <- mergeNA(outcome[, 1:6])
newman[["outcome"]] <- ifelse(newman[["outcome"]] == -1, NA_real_, newman[["outcome"]])
rm(outcome)

# manipulation check for small subset of respondents
table(newman[["DOV_MANCHECK"]])
newman[["check"]] <- ((newman[["Q3"]]-1)/10) + ((newman[["Q4"]]-1)/10)

# depletion manipulation
t.test(outcome ~ tr, data = newman)
summary(lm(outcome ~ tr, data = newman))
## manipulation check
t.test(check ~ tr, data = newman)
summary(lm(check ~ tr, data = newman))


# full design
summary(m_factorial <- lm(outcome ~ tr * cues * args, data = newman))
summary(margins(m_factorial))
## alternative parameterization
newman[["tr_all"]] <- interaction(newman[["tr"]], newman[["cues"]], newman[["args"]])
summary(lm(outcome ~ tr_all, data = newman))

cplot(m_factorial, x = "args", dx = "tr", data = newman[!is.na(newman$args), ], what = "effect")


#------------------------------#
## Example 3: Holbrook        ##
## (Question wording; List)   ##
#------------------------------#


# list experiment
holbrook <- rio::import("Holbrook120.zip", which = "TESS1_Client.sav")
names(holbrook)
dim(holbrook)

## main experiment (not list experiment)
holbrook[["tr"]] <- ifelse(!is.na(holbrook[["TESSQ1"]]), 1, ifelse(!is.na(holbrook[["TESSQ2"]]), 0, NA_real_))
holbrook[["voted"]] <- mergeNA(holbrook[["TESSQ1"]], holbrook[["TESSQ2"]])
holbrook[["voted"]] <- ifelse(holbrook[["voted"]] == 1, 1, ifelse(holbrook[["voted"]] == 2, 0, NA_real_))

t.test(voted ~ tr, data = holbrook)
t.test(voted ~ tr, data = holbrook, var.equal = TRUE)
summary(lm(voted ~ tr, data = holbrook))

## list experiment (treatment effect is estimate of behaviour)
holbrook[["trlist"]] <- ifelse(!is.na(holbrook[["TESSQ3"]]), 0, ifelse(!is.na(holbrook[["TESSQ4"]]), 1, NA_real_))
holbrook[["listcount"]] <- mergeNA(holbrook[["TESSQ3"]], holbrook[["TESSQ4"]])

aggregate(listcount ~ trlist, data = holbrook, FUN = mean, na.rm = TRUE)


t.test(listcount ~ trlist, data = holbrook)
t.test(listcount ~ trlist, data = holbrook, var.equal = TRUE)
summary(lm(listcount ~ trlist, data = holbrook))
aggregate(voted ~ tr, data = holbrook, FUN = mean, na.rm = TRUE)


summary(ictreg(listcount ~ trlist, data = holbrook, treat = "trlist", method = "lm"))



