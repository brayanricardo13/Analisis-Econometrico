#librerías
library(tidyverse)
install.packages(tidyverse)
library(tseries)
install.packages(tseries)
library(urca)
install.packages(urca)
library(forecast)
install.packages(forecast)
library(readxl)
install.packages("timsac")
library("timsac")
library(nortest)

Taller<- read_excel("GitHub/Analisis-Econometrico/Bases de datos/Taller Primer corte.xlsx", 
                                  sheet = "Taller1")

Fecha<- ts(Taller$Fecha, start = c(1971), frequency = 1)
España<- ts(Taller$España, start = c(1971), frequency = 1)
summary()
attach(Taller)

jb.norm.test(Taller$España, nrepl=2000)




# Grafico de datos en niveles
ts.plot(Taller$España,col="red")

plot(decompose(España),col="red")
decomp(España, trade=TRUE,plot=TRUE,)

ggAcf(España)
checkresiduals(diff(España))


# Prueba de estacionariedad


adf.test(España, alternative="stationary", k=0)


ur.kpss(Taller$Noruega) %>% summary() #los datos en niveles no son estacionarios
ur.kpss(diff(Taller$Noruega)) %>% summary() # los datos diferenciados si son estacionarios

# grafica de los datos diferenciados
ts.plot(diff(Taller$España),col="blue")

adf.test(diff(Taller$España), alternative="stationary", k=0)



##
# Modelo ARIMA
##

# AR representa una regresion de la variable cotra valores pasados de ella misma
# MA representa la media movil ponderada de los errores pasados del pronóstico.

# Combinando los dos modelos
# p = parte autorregresiva
# d = grado de difenrenciacion
# q = parte media movil

# Selección automatica del modelo ARIMA
modelo <- auto.arima(diff(Taller$España), seasonal=T, stepwise=T, approximation=T)
summary(modelo)
checkresiduals(modelo) # Los residuales no estan correlacionados
autoplot(modelo)


arima1<- Arima(Taller$España, order=c(0,1,2), seasonal=list(order=c(0,1,1),period=12))
arima2<- Arima(Taller$España, order=c(1,1,0), seasonal=list(order=c(2,1,0),period=12))
arima3<- Arima(Taller$España, order=c(1,1,2), seasonal=list(order=c(2,1,1),period=12))
arima4<- Arima(Taller$España, order=c(1,1,1), seasonal=list(order=c(2,1,1),period=12))
arima5<- Arima(Taller$España, order=c(1,1,2), seasonal=list(order=c(1,1,1),period=12))
arima6<- Arima(Taller$España, order=c(0,1,1), seasonal=list(order=c(0,1,1),period=12))
arima7<- Arima(Taller$España, order=c(1,1,0), seasonal=list(order=c(1,1,0),period=12))


IC(arima1,arima2,arima3,arima4,arima5,arima6,arima7)
BIC(arima1,arima2,arima3,arima4,arima5,arima6,arima7)










# Pronóstico
autoplot(forecast(modelo, h=3))