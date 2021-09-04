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

Taller<- read_excel("GitHub/Analisis-Econometrico/Bases de datos/Taller Primer corte.xlsx", 
                                  sheet = "Taller")

Fecha<- ts(Taller$Fecha, start = c(1971,01), frequency = 12)
Noruega<- ts(Taller$Noruega, start = c(1971,01), frequency = 12)

# Grafico de datos en niveles
ts.plot(Taller$Noruega)

plot(decompose(Noruega))

# Prueba de estacionariedad
ur.kpss(Taller$Noruega) %>% summary() #los datos en niveles no son estacionarios
ur.kpss(diff(Taller$Noruega)) %>% summary() # los datos diferenciados si son estacionarios

# grafica de los datos diferenciados
ts.plot(diff(Taller$Noruega))


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
modelo <- auto.arima(Taller$Noruega, seasonal=T, stepwise=T, approximation=T)
summary(modelo)
checkresiduals(modelo) # Los residuales no estan correlacionados


# Pronóstico
autoplot(forecast(modelo, h=5))