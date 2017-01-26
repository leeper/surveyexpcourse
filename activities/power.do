#------------------------------#
## Variance and Power         ##
#------------------------------#

power twomeans 0, diff(0.2)

// for multiple values of 
forvalues i = 0.1 (0.1) 1.0 {
    power twomeans 0, diff(`i')
}

// using raw effect sizes and standard deviations
power twomeans 0 0.5, sd1(.5) sd2(.7)

// adjusting alpha or power
power twomeans 0, diff(0.2) alpha(0.10) power(0.7)
