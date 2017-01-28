* Using treatment as an instrument for mediator or manipulation check

cd johnston
quietly include "johnston.do"
cd ../

* manipulation check
table check

* experimental equation
reg outcome tr


* "first-stage" equation
reg check tr

* "second-stage" equation
reg outcome check

* 2SLS estimation
ivregress 2sls outcome (check = tr)

