*Taller Analisis Econometrico 
*2 de septiembre del 2021 
import excel "C:\Users\Familia Fonseca\Documents\GitHub\Analisis-Econometrico\Bases de datos\Taller Primer corte.xlsx", sheet("Taller") firstrow
*Declarar la variable como serie de tiempo 
tsset Fecha
*Grafica 
tsline Noruega
*resumen de los datos 
summarize Noruega
tab Noruega
sum Noruega , d 
*grafica 
histogram Noruega, normal 

*Analisis de Estacionalidad 
*Analisis graficio 
ac Noruega
pac Noruega
*Analisis formal 
dfuller Noruega
*trasformar la serie 
gen Noruega1 = Noruega-l1.Noruega
tsline Noruega1
ac Noruega1
dfuller Noruega1

histogram Noruega1, normal

*identificar el modelo 
ac Noruega1 ,name (gac)
pac  Noruega1 ,name (pgac)
graph combine gac pgac




*AC -> Orden de los MA(3)
*PAC -> Orden de los AR(1)

arima Noruega1, arima(1,0,1)
estat ic 
arima Noruega1, arima(1,1,1) 
estat ic 

*validar modelo 
quietly arima Noruega1, arima(1,0,1)
predict residll,resid
wntestq residll
wntestb residll


quietly arima Noruega1, arima(1,1,1)
predict residll,resid
wntestq residll
wntestb residll

*predicion 
tsappend,add(3)
arima Noruega,arima(1,0,1)  
predict Noruega12
tsline Noruega Noruega12












