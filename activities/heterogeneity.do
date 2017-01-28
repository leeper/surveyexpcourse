* Post-hoc examination of effect heterogeneity

cd johnston
quietly include "johnston.do"
cd ../

gen outcome1 = outcome if tr == 1
gen outcome0 = outcome if tr == 0

* Quantile-Quantile plot
qqplot outcome1 outcome0


* "fully saturated" regression w/ treatment interacted with:
** party identification
** interest in politics
** gender
** education (years)
** race/ethnicity
quietly reg outcome i.tr##c.XPARTY7 i.tr##c.XPP10035 i.tr##i.PPGENDER i.tr##c.PPEDUC i.tr##i.PPETHM

* Plots of CATEs
margins, dydx(tr) at(XPARTY7 = (1(1)7))
marginsplot
margins, dydx(tr) at(XPP10035 = (1(1)5))
marginsplot
margins, dydx(tr) at(PPGENDER = (1 2))
marginsplot
margins, dydx(tr) at(PPEDUC = (1(1)14))
marginsplot
margins, dydx(tr) at(PPETHM = (1(1)4))
marginsplot
