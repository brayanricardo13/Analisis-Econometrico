*Analisis Econometrico 
* 10/08/2021 
use "C:\Users\Familia Fonseca\Documents\GitHub\Analisis-Econometrico\Bases de datos\states.dta"
* base de datos 
sysuse states
summarize
describe  csat expense percent income high college
sum
reg csat expense
reg csat expense percent income high college
xi: regress csat expense percent income high college i.region
ssc install estout
regress csat expense
eststo model1
regress csat expense percent income high college
eststo model2
xi: regress csat expense percent income high college i.region
eststo model3
esttab, r2 ar2 se scalar(rmse)
pwcorr csat expense percent income high college, star(0.05) sig

graph matrix csat expense percent income high college, half maxis(ylabel(none) xlabel(none))


scatter csat percent
scatter csat high
generate percent2 = percent^2
regress csat percent high
acprplot percent, lowess
acprplot high, lowess
xi: regress csat expense percent percent2 income high college i.region
eststo model4
esttab, r2 ar2 se scalar(rmse)
xi: regress csat expense percent percent2 income high college i.region
predict csat_predict
label variable csat_predict "csat predicted"
scatter csat csat_predict
rvfplot, yline(0)
estat hettest
xi: regress csat expense percent percent2 income high college i.region
ovtest
xi: regress csat expense percent percent2 income high college i.region
linktest
vif
avplot percent
avplot expense
avplots
predict e, resid
kdensity e, normal
histogram e, kdensity normal
pnorm e
qnorm e
swilk e
sfrancia e
sktest e
xi: quietly regress csat expense percent percent2 income high college i.region
test high college