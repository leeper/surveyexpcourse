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
