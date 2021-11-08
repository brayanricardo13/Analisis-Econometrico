*TALLER ANALISIS ECONOMETRICO 
import excel "C:\Users\Familia Fonseca\Documents\GitHub\Analisis-Econometrico\Bases de datos\Base de datos AL PANEL.xlsx", sheet("Taller ") firstrow
sum,d 
*declarar la base como datos panel 
xtset Descripcion Año
*Podemos ver las tendencias de las series por separado
xtline Consumo
bysort Descripcion : egen ymean=mean(PIB)
*heterogenidad
twoway scatter PIB Descripcion, msymbol(circle_hollow) || connected ymean Descripcion  || , xlabel(1 "1" 2 "2" 3 "3" 4 "4" 5 "5")
* Evolucion año por año 
bysort Año: egen ymean1=mean(PIB)
twoway scatter PIB Año, msymbol(circle_hollow) || connected ymean1 Año, msymbol(diamond) || , xlabel(2015(1)2019)
*regresion  
reg PIB Consumo
twoway scatter Pib Consumo, mlabel(N_Pais) || lfit Pib Consumo,clstyle(p2) 
*comparacion 
xi: reg PIB Consumo i.Descripcion
predict yhat
*regresion ajustada 
separate PIB, by(Descripcion)
separate yhat, by(Descripcion)
twoway connected yhat1-yhat5 Consumo, msymbol(none diamond_hollow triangle_hollow square_hollow + circle_hollow x) msize(medium) mcolor(black black black black black black ) || lfit PIB Consumo, clwidth(thick) clcolor(black)
* guardar la regresion 
reg PIB Consumo
estimates store ols
*regresion cmpleja 
xi: reg PIB Consumo i.Descripcion
estimates store ols_dum
estimates table ols ols_dum, star stats (N)


*estimacion Efectos fijos 
xtreg PIB Consumo , fe 
*Corrigiendo hetedogenidad 
xtreg PIB Consumo  , fe  robust
xtreg PIB Consumo Inversion Gasto, fe  robust


*PRIMERA ESTIMACION 
reg PIB Consumo
estimates store ols
reg PIB Consumo Stock_Inversion
estimates store ols_1
reg PIB Consumo Stock_Inversion Gasto
estimates store ols_2

estimates table ols ols_1 ols_2, star stats (N N r2 r2_a)



*comparando tres modelos efectos fijos 
xtreg  PIB Consumo,fe
estimates store ols_11
xtreg PIB Consumo Stock_Inversion,fe
estimates store ols_12
xtreg  PIB Consumo Stock_Inversion Gasto ,fe 
estimates store ols_13
estimates table ols_11 ols_12 ols_13 , star stats (N r2 r2_a)

*estimacion Efecto aleatorios 


xtreg  PIB Consumo,re
estimates store ols_21
xtreg PIB Consumo Stock_Inversion,re
estimates store ols_22
xtreg  PIB Consumo Stock_Inversion Gasto ,re 
estimates store ols_23
estimates table ols_21 ols_22 ols_23 , star stats (N r2 r2_a)

*test de hauman 
hausman  ols_23 ols_13 
*instalar 
ssc install xttest2
xttest2

ssc install xttest3
xttest3














