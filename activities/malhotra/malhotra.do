* http://tessexperiments.org/data/malhotra634.html
use data.dta, clear

* Created Treatment Variable (tr)
table XTESS182
gen tr = XTESS182
label define trlevels 1 "Baseline" 2 "Higher Payment" 3 "Religion" 4 "Geography"
label values tr trlevels

*Create binary variable for the outcome variable (taking the lower payment)
egen option_a = rowtotal (Q8A Q8B Q8C Q8D), missing
recode option_a (-1=.) (2=0)


*Code party identificaiton including refusers to initial branch as independents (drops two Republican respondents who refused to answer the strength question)
gen pid = .  
recode pid (.=1) if Q1A==1
recode pid (.=2) if Q1A==2
recode pid (.=3) if Q1C==1
recode pid (.=4) if Q1C==-1|Q1==-1
recode pid (.=5) if Q1C==2
recode pid (.=6) if Q1B==2
recode pid (.=7) if Q1B==1

gen pid3 = .
recode pid3 (.=1) if pid==1|pid==2|pid==3
recode pid3 (.=2) if pid==4
recode pid3 (.=3) if pid==5|pid==6|pid==7


* Main analysis (excluding independents, and those who refused to answer religion question)
ttest option_a if ((tr == 1 | tr == 2) & (pid3 != 2 & Q2 != -1)), by(tr)
ttest option_a if ((tr == 1 | tr == 2) & (pid3 != 2 & Q2 != -1)), by(tr) unequal

reg option_a i.tr if (pid3 != 2 & Q2 != -1)
reg option_a i.tr if (pid3 != 2 & Q2 != -1), robust
