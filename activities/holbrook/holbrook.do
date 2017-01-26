use data.dta

* main experiment (not list experiment)
** treatment indicator
gen tr = .
replace tr = 1 if TESSQ1 != .
replace tr = 0 if TESSQ2 != .
table tr
** outcome
gen voted = .
replace voted = TESSQ1 if TESSQ1 != .
replace voted = TESSQ2 if TESSQ2 != .
recode voted (1 = 1) (2 = 0)
table voted

tabstat voted, by(tr)
ttest voted, by(tr)
prtest voted, by(tr)
reg voted i.tr


* list experiment
** treatment indicator
gen trlist = .
replace trlist = 1 if TESSQ4 != .
replace trlist = 0 if TESSQ3 != .
table trlist

** outcome
gen listcount = TESSQ3
replace listcount = TESSQ4 if TESSQ4 != .
table listcount

tabstat listcount, by(trlist)
ttest listcount, by(trlist)
reg listcount i.trlist

