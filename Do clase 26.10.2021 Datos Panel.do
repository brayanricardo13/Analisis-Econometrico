* 26/10/2021 Analisis de datos 

import excel "C:\Users\Familia Fonseca\Documents\GitHub\Analisis-Econometrico\Bases de datos\Base de datos AL PANEL.xlsx", sheet("Hoja1") firstrow
sum 
#Usamos el comando xtset para declarar la base de datos como datos panel
xtset country year
#Podemos ver las tendencias de las series por separado
xtline rgdpna
#y también en una sola gráfica
xtline rgdpna, overlay
bysort country: egen ymean=mean(rgdpna)
twoway scatter rgdpna country, msymbol(circle_hollow) || connected ymean country, msymbol(diamond) || , xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9")
bysort year: egen ymean1=mean(rgdpna)
twoway scatter rgdpna year, msymbol(circle_hollow) || connected ymean1 year, msymbol(diamond) || , xlabel(2004(1)2014)
reg rgdpna rconna
twoway scatter rgdpna rconna, mlabel(country) || lfit rgdpna rconna ,clstyle(p2) 
xi: reg rgdpna rconna i.country
predict yhat
separate rgdpna, by(country)
separate yhat, by(country)
twoway connected yhat1-yhat9 rconna, msymbol(none diamond_hollow triangle_hollow square_hollow + circle_hollow x) msize(medium) mcolor(black black black black black black black) || lfit rgdpna rconna, clwidth(thick) clcolor(black)
reg rgdpna rconna
estimates store ols
xi: reg rgdpna rconna i.country
estimates store ols_dum
estimates table ols ols_dum, star stats (N)
xtreg rgdpna rconna, fe 
xtreg rgdpna rconna, fe robust
xtreg rgdpna rconna, re
xtreg rgdpna rconna, fe 
estimates store fixed
xtreg rgdpna rconna, re
estimates store random
hausman random fixed
xtreg rgdpna rconna, re
xttest0
xtreg rgdpna rconna, fe
ssc install xttest2
xttest2
xtreg rgdpna rconna, fe
ssc install xtcsd, replace
xtcsd, pesaran abs
ssc install xttest3
xtreg rgdpna rconna, fe
xttest3
net from http://www.stata-journal.com/software/sj3-2/
xtserial rgdpna rconna
