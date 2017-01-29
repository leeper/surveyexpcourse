# http://www.tessexperiments.org/data/holbrook120.html

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
if (!require("list")) {
    # alternative list experiment estimators
    install.packages("list")
    library("list")
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
    holbrook <- rio::import("data.dta")
} else {
    utils::download.file("http://www.tessexperiments.org/data/zip/holbrook120.zip", "holbrook120.zip", mode = "wb")
    holbrook <- rio::import("Holbrook120.zip", which = "TESS1_Client.sav")
}
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

