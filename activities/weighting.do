* Weighted and unweighted analyses

** Schuldt example
cd schuldt
quietly include "schuldt.do"
cd ../

* examine the poststratification weights
** note: TESS datasets will only have post-stratification weights (no design weights) except in rare circumstances
summarize weight
hist weight

* look at unweighted analysis
reg outcome gw

* use _svyset_ to define the survey design
svyset [pw = weight]
svy: reg outcome gw

* the SATE estimate is equivalent to a weighted mean:
gen wtoutcome = outcome * weight
reg outcome gw
** but variance estimates are incorrect!

clear


** Johnston (factorial) example
cd johnston
quietly include "johnston.do"
cd ../

hist weight

* look at unweighted analysis
reg outcome i.tr##i.cues##i.args
margins, dydx(*)

* use _svyset_ to define the survey design
svyset [pw = weight]
svy: reg outcome i.tr##i.cues##i.args
margins, dydx(*)
