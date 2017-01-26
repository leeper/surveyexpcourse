use data.dta

* complex factorial design
** Factor 1: depletion versus not
** Factor 2: cues versus no cues
** Factor 3: no argues, pro args, con args
** (note: conditions 1 and 8 are basically dropped; they are placebo conditions)

* Factor 1: depletion versus not
** two conditions in first factor: 1-7 control; 8-14 depletion treatment
recode XTESS171 (1/7 = 0) (8/14 = 1), gen(tr)
table XTESS171 tr

* Factor 2: cues versus no cues
recode XTESS171 (5/7 = 1) (12/14 = 1) (2/4 = 0) (9/11 = 0) (else = .), gen(cues)
table XTESS171 cues

* Factor 3: no argues, pro args, con args
recode XTESS171 (1 = .) (2 = 0) (3 = 1) (4 = 2) (5 = 0) (6 = 1) (7 = 2) (8 = .) ///
                (9 = 0) (10 = 1) (11 = 2) (12 = 0) (13 = 1) (14 = 2), gen(args)
table XTESS171 args

table tr cues
table tr args

* outcome (Q6A-Q6F; measured on 1-5 scale)
gen outcome = .
replace outcome = Q6A if Q6A != .
replace outcome = Q6B if Q6B != .
replace outcome = Q6C if Q6C != .
replace outcome = Q6D if Q6D != .
replace outcome = Q6E if Q6E != .
replace outcome = Q6F if Q6F != .
replace outcome = . if outcome == -1
table outcome

* manipulation check for small subset of respondents
table DOV_MANCHECK
gen check = ((Q3-1)/10) + ((Q4-1)/10)
table check
* test of manipulation check
ttest check, by(tr)
reg check i.tr



* pairwise parameterization
gen tr_all = XTESS171
replace tr_all = . if XTESS171 == 1 | XTESS171 == 8
table tr_all
reg outcome i.tr_all

* one factor at a time
ttest outcome, by(tr)
reg outcome i.tr

ttest outcome, by(cues)
reg outcome i.cues

oneway outcome args
reg outcome i.args

* full design using factorial parameterization
reg outcome i.tr##i.cues##i.args
margins, dydx(*)
marginsplot

