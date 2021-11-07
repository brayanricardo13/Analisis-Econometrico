*TALLER ANALISIS ECONOMETRICO 
import excel "C:\Users\Familia Fonseca\Documents\GitHub\Analisis-Econometrico\Bases de datos\Base de datos AL PANEL.xlsx", sheet("Taller ") firstrow
summ
*declarar la base como datos panel 
xtset N_Pais Fecha
*Podemos ver las tendencias de las series por separado
xtline Consumo
bysort N_Pais: egen ymean=mean(Pib)
*heterogenidad
twoway scatter Pib N_Pais, msymbol(circle_hollow) || connected ymean N_Pais,  || , xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5")
* Evolucion año por año 
bysort Fecha: egen ymean1=mean(Pib)
twoway scatter Pib Fecha, msymbol(circle_hollow) || connected ymean1 Fecha, msymbol(diamond) || , xlabel(2015(1)2019)
*regresion  
reg Pib Consumo
twoway scatter Pib Consumo, mlabel(N_Pais) || lfit Pib Consumo,clstyle(p2) 
*comparacion 
xi: reg Pib Consumo i.N_Pais
predict yhat
*regresion ajustada 
separate Pib1, by(N_Pais)
separate yhat1, by(N_Pais)
twoway connected yhat1-yhat5 Consumo, msymbol(none diamond_hollow triangle_hollow square_hollow + circle_hollow x) msize(medium) mcolor(black black black black black black ) || lfit Pib Consumo, clwidth(thick) clcolor(black)
* guardar la regresion 
reg Pib Consumo
estimates store ols
*regresion cmpleja 
xi: reg Pib Consumo i.N_Pais
estimates store ols_dum
estimates table ols ols_dum, star stats (N)


*estimacion Efectos fijos 
xtreg Pib Consumo , fe 
*Corrigiendo hetedogenidad 
xtreg Pib Consumo  , fe  robust
xtreg Pib Consumo Inversion Gasto, fe  robust


*comparando tres modelos efectos fijos 
xtreg  Pib Consumo,fe
estimates store ols_11
xtreg Pib Consumo Inversion,fe
estimates store ols_12
xtreg  Pib Consumo Inversion Gasto ,fe 
estimates store ols_13
estimates table ols_11 ols_12 ols_13 , star stats (N r2 r2_a)

*estimacion Efecto aleatorios 

xtreg  Pib Consumo,re
estimates store ols_21
xtreg Pib Consumo Inversion,re
estimates store ols_22
xtreg  Pib Consumo Inversion Gasto ,re 
estimates store ols_23
estimates table ols_21 ols_22 ols_23 , star stats (N r2 r2_a)

*test de hauman 
hausman  ols_23 ols_13 
*instalar 
ssc install xttest2
xttest2

ssc install xttest3
xttest3














