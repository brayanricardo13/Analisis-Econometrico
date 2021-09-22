* Analisis Econometrico 
*Modelos ARCH - GARCH bancolombia 
*Importar la base de datos 
import excel "C:\Users\Familia Fonseca\Documents\GitHub\Analisis-Econometrico\Bases de datos\Bancolombia.xlsx", sheet("Bancolombia") firstrow
*Declar la base de datos como serie de tiempo 
tsset Fecha
gen Bancolombia = Último
tsline Bancolombia
*resumen de los datos 
summarize Bancolombia
tab Bancolombia
sum Bancolombia , d 
* prueba de raiz unitaria 
dfuller Bancolombia
*series diferenciados 
tsline Variacion
histogram Variacion, normal
sum  Variacion, d 
dfuller Variacion
ac Variacion

ac Variacion ,name (gac)
pac  Variacion ,name (pgac)
graph combine gac pgac

*test LM*
reg Variacion
predict u_hat, res 
gen u2= (u_hat)^2 
gen u2_1 = u2[_n-1]


scalar NR2 =e(N)*e(r2)
scalar pvalor = chi2tail(1,NR2)
scalar critico = invchi2tail(1,.05) 
scalar list NR2 pvalor critico

 *Lm
reg Variacion
estat archlm, lags(1)
 
arch Variacion, ach(1) 

*Estimacion

arch Variacion,arch(1)
estimates store ARCH1
 
 
arch Variacion,arch(1/2)
estimates store ARCH2
 
 
arch Variacion,arch(1/3)
estimates store ARCH3


arch Variacion,arch(1/4)
estimates store ARCH4

arch Variacion,arch(1/5)
estimates store ARCH5

estimate stats ARCH1 ARCH2 ARCH3 ARCH4 ARCH5


*estimacion 

arch Variacion,arch(1) garch (1)
estimates store garch1


arch Variacion,arch(1) garch (2)
estimates store garch2

arch Variacion,arch(2) garch (1)
estimates store garch3


arch Variacion,arch(2) garch (2)
estimates store garch4


estimate stats garch1 garch2 garch3 garch4


estimate stats ARCH1 ARCH2 ARCH3 ARCH4 ARCH5 garch1 garch2 garch3 garch4






















 




