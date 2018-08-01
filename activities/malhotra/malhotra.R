# http://tessexperiments.org/data/malhotra634.html

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

# load data
if ("data.dta" %in% dir()) {
    malhotra <- rio::import("data.dta")
} else {
    utils::download.file("http://tessexperiments.org/data/zip/Malhotra634.zip", "Malhotra634.zip", mode = "wb")
    malhotra <- rio::import("Malhotra634.zip", which = "TESS_182_Malhotra_Client.sav")
    # malhotra[] <- lapply(malhotra, function(x) { if (is.numeric(x)) { x2 <- as.integer(x) } else { return(x) }; attributes(x2) <- attributes(x); return(x2) })
}
names(malhotra)
dim(malhotra)

## experiment
### treatment condition
malhotra[["tr"]] <- factor(malhotra[["XTESS182"]], levels = 1:4, labels = c("Baseline", "Higher Payment", "Religion", "Geography"))
## outcome: whether respondent accepts nonpartisan offer
malhotra[["option_a"]] <- dplyr::coalesce(malhotra[["Q8A"]], malhotra[["Q8B"]], malhotra[["Q8C"]], malhotra[["Q8D"]])
malhotra[["option_a"]][malhotra[["option_a"]] == -1] <- NA_integer_
malhotra[["option_a"]][malhotra[["option_a"]] == 2] <- 0L

## party identification variable
malhotra[["pid3"]] <-NA_integer_
malhotra[["pid3"]][malhotra[["Q1"]] == 1 | malhotra[["Q1C"]] == 1] <- 1L # Democrats
malhotra[["pid3"]][malhotra[["Q1"]] == 3 & malhotra[["Q1C"]] == -1] <- 2L # Independents
malhotra[["pid3"]][malhotra[["Q1"]] == 2 | malhotra[["Q1C"]] == 2] <- 3L # Republicans
malhotra[["pid3"]] <- factor(malhotra[["pid3"]], 1:3, c("Democrats", "Independents", "Republicans"))


## Main Analysis (excluding independents)
t.test(option_a ~ tr, data = subset(malhotra, tr %in% c("Baseline", "Higher Payment") & pid3 != 2 & Q2 != -1), var.equal = FALSE)
t.test(option_a ~ tr, data = subset(malhotra, tr %in% c("Baseline", "Higher Payment") & pid3 != 2 & Q2 != -1), var.equal = TRUE)

summary(lm(option_a ~ tr, data = subset(malhotra, pid3 != 2 & Q2 != -1)))

