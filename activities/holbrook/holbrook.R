# http://www.tessexperiments.org/data/holbrook120.html
utils::download.file("http://www.tessexperiments.org/data/zip/holbrook120.zip", "holbrook120.zip", mode = "wb")

install.packages(c("ghit", "rio", "ggplot2", "list"))

library("stats")
library("ghit")    # installing github packages
library("rio")     # data loading
library("list")    # alternative list experiment estimators
ghit::install_github("leeper/mcode")
library("mcode")   # convenience functions for working with data recoding
ghit::install_github(c("leeper/prediction", "leeper/margins"), build_vignettes = FALSE)
library("margins") # marginal effects


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

