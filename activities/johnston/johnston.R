# http://www.tessexperiments.org/data/newman508.html

library("stats")
if (!requireNamespace("remotes")) {
    # installing github packages
    install.packages("remotes")
    requireNamespace("remotes")
}
if (!requireNamespace("rio")) {
    # data loading
    install.packages("rio")
    requireNamespace("rio")
}
if (!requireNamespace("dplyr")) {
    # convenience functions for working with data recoding
    install.packages("dplyr")
    requireNamespace("dplyr")
}
if (!requireNamespace("margins")) {
    # marginal effects
    install.packages("margins")
    requireNamespace("margins")
}

# load data
if ("data.dta" %in% dir()) {
    johnston <- rio::import("data.dta")
} else {
    utils::download.file("http://www.tessexperiments.org/data/zip/NewmanJohnston508.zip", "NewmanJohnston508.zip", mode = "wb")
    johnston <- rio::import("NewmanJohnston508.zip", which = "TESS3_171_Johnston_Client.sav")
}
names(johnston)
dim(johnston)

# complex factorial design
# Factor 1: depletion versus not
# Factor 2: cues versus no cues
# Factor 3: no argues, pro args, con args
# (note: conditions 1 and 8 are basically dropped; they are placebo conditions)

# Factor 1: depletion versus not
# two conditions in first factor: 1-7 control; 8-14 depletion treatment
johnston[["tr"]] <- as.factor(ifelse(johnston[["XTESS171"]] %in% 1:7, 0, ifelse(johnston[["XTESS171"]] %in% 8:14, 1, NA_real_)))
# Factor 2: cues versus no cues
johnston[["cues"]] <- as.factor(ifelse(johnston[["XTESS171"]] %in% c(5:7, 12:14), 1, ifelse(johnston[["XTESS171"]] %in% c(2:4, 9:11), 0, NA_real_)))
# Factor 3: no argues, pro args, con args
johnston[["args"]] <- factor(ifelse(johnston[["XTESS171"]] %in% c(2,5,9,12), 0, 
                                  ifelse(johnston[["XTESS171"]] %in% c(3,6,10,13), 1, 
                                         ifelse(johnston[["XTESS171"]] %in% c(4,7,11,14), -1, NA_real_))), levels = c(0, -1, 1))

# outcome (Q6A-Q6F; measured on 1-5 scale)
outcome <- johnston[, paste0("Q6", LETTERS[1:6])]
outcome[] <- lapply(outcome, function(x) ifelse(is.nan(x), NA_real_, x))
johnston[["outcome"]] <- dplyr::coalesce(outcome[[1]], outcome[[2]], outcome[[3]], outcome[[4]], outcome[[5]], outcome[[6]])
johnston[["outcome"]] <- ifelse(johnston[["outcome"]] == -1, NA_real_, johnston[["outcome"]])
rm(outcome)

# manipulation check for small subset of respondents
table(johnston[["DOV_MANCHECK"]])
johnston[["check"]] <- ((johnston[["Q3"]]-1)/10) + ((johnston[["Q4"]]-1)/10)

# depletion manipulation
t.test(outcome ~ tr, data = johnston)
summary(lm(outcome ~ tr, data = johnston))
## manipulation check
t.test(check ~ tr, data = johnston)
summary(lm(check ~ tr, data = johnston))


# full design
summary(m_factorial <- lm(outcome ~ tr * cues * args, data = johnston))
summary(margins::margins(m_factorial))
## alternative parameterization
johnston[["tr_all"]] <- interaction(johnston[["tr"]], johnston[["cues"]], johnston[["args"]])
summary(lm(outcome ~ tr_all, data = johnston))

margins::cplot(m_factorial, x = "args", dx = "tr", data = johnston[!is.na(johnston$args), ], what = "effect")

