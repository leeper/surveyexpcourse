# http://www.tessexperiments.org/data/schuldt301.html

library("stats")
if (!require("ghit")) {
    # installing github packages
    install.packages("ghit")
    library("ghit")
}
if (!require("rio")) {
    # data loading
    install.packages("rio")
    library("rio")
}
if (!require("ggplot2")) {
    # visualization
    install.packages("ggplot2")
    library("ggplot2")
}
if (!require("mcode")) {
    # convenience functions for working with data recoding
    ghit::install_github("leeper/mcode")
    library("mcode")
}
if (!require("margins")) {
    # marginal effects
    ghit::install_github(c("leeper/prediction", "leeper/margins"), build_vignettes = FALSE)
    library("margins")
}

# load data
if ("data.dta" %in% dir()) {
    schuldt <- rio::import("data.dta")
} else {
    utils::download.file("http://www.tessexperiments.org/data/zip/Schuldt301.zip", "Schuldt301.zip", mode = "wb")
    schuldt <- rio::import("Schuldt301.zip", which = "TESS2_117_Schuldt_Client.sav")
}
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
