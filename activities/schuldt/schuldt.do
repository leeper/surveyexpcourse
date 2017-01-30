use data.dta

table XTESS117
* 1,3,5,7 = "Global Warming"
* 2,4,6,8 = "Climate Change"
recode XTESS117 (1 3 5 7 = 1) (else = 0), gen(gw)

* outcome measure (1-7; higher values = gw happening)
table Q3A
table Q3B
//table Q3A Q3B

gen outcome = Q3A
replace outcome = Q3B if outcome == .

* tidy these
table outcome
table Q3A outcome
table Q3B outcome

drop if outcome == -1

tabstat outcome, by(gw)
ttest outcome, by(gw)
reg outcome gw
ttest outcome, by(gw) unequal
reg outcome gw, r

* standardized effect size and post-hoc power
esize twosample outcome, by(gw)
power twomeans 0, diff(.158)


** moderation by party
* 1:3 = Republican
* 5:7 = Democrat
table PARTY7
recode PARTY7 (1/3 = 1) (5/7 = 2), gen(republican)
table PARTY7 republican

tabstat outcome if republican == 1, by(gw)
tabstat outcome if republican == 2, by(gw)

ttest outcome if republican == 1, by(gw)
ttest outcome if republican == 2, by(gw)

reg outcome i.republican##i.gw
margins, dydx(*)
marginsplot


** effect heterogeneity?

reg outcome i.gw##i.republican i.gw##c.IDEO i.gw##i.PPGENDER i.gw##c.PPAGE i.gw##c.PPEDUC
margins, dydx(gw)

margins republican, dydx(gw)
margins PPGENDER, dydx(gw)


