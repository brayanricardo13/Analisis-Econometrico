* Analisis Econometrico 
*Modelos ARCH - GARCH bancolombia 
*Importar la base de datos 
import excel "C:\Users\Familia Fonseca\Documents\GitHub\Analisis-Econometrico\Bases de datos\Grupo AVAL Abella.xlsx", sheet("Datos históricos GAA_p") firstrow
*Declar la base de datos como serie de tiempo 
tsset Fecha
gen Aval = Último
tsline Aval
*resumen de los datos 
summarize Aval
tab Aval
sum Aval, d 
histogram Aval, normal
* prueba de raiz unitaria 
dfuller Aval
*series diferenciados 
tsline var
histogram var, normal
sum  var, d 
dfuller var
ac var

ac var,name (gac)
pac  var,name (pgac)
graph combine gac pgac

*test LM*
reg var
predict u_hat, res 
gen u2= (u_hat)^2 
gen u2_1 = u2[_n-1]


scalar NR2 =e(N)*e(r2)
scalar pvalor = chi2tail(1,NR2)
scalar critico = invchi2tail(1,.05) 
scalar list NR2 pvalor critico

 *Lm
reg var
estat archlm, lags(1)
 
arch Variacion, ach(1) 

*Estimacion

arch var,arch(1)
estimates store ARCH1
 
 
arch var, arch(1/2)
estimates store ARCH2
 
 
arch var,arch(1/3)
estimates store ARCH3


arch var,arch(1/4)
estimates store ARCH4

arch var,arch(1/5)
estimates store ARCH5


estimate stats ARCH1 ARCH2 ARCH3 ARCH4 ARCH5


*garch
arch var,arch(1) garch (1)
estimates store garch1


arch var,arch(1) garch (2)
estimates store garch2

arch var,arch(2) garch (1)
estimates store garch3


arch var,arch(2) garch (2)
estimates store garch4


estimate stats garch1 garch2 garch3 garch4


estimate stats ARCH1 ARCH2 ARCH3 ARCH4 ARCH5 garch1 garch2 garch3 garch4









