* Balance testing

cd schuldt
quietly include "schuldt.do"
cd ../

* Mean comparisons and significance tests
** age
tabstat PPAGE, by(gw)
ttest PPAGE, by(gw)

** party identification
tabstat PARTY7, by(gw)
ttest PARTY7, by(gw)

** gender
gen tmpgender = PPGENDER - 1
tabstat tmpgender, by(gw)
prtest tmpgender, by(gw)

** education (years)
tabstat PPEDUC, by(gw)
ttest PPEDUC, by(gw)

** race/ethnicity
tab PPETHM gw, col

* graphical comparisons
** ssc install ciplot
ciplot PPAGE, by(gw)
ciplot PARTY7, by(gw)
ciplot tmpgender, by(gw) binom
ciplot PPEDUC, by(gw)

* regress treatment condition on covariates
reg gw c.PPAGE c.PARTY7 i.PPGENDER c.PPEDUC i.PPETHM
