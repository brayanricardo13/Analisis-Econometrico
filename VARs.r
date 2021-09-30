library(urca)
install.packages("vars")
library(vars)
install.packages("mFilter")
library(mFilter)
install.packages("tseries")
library(tseries)
library(forecast)
install.packages("tidyverse")
library(tidyverse)
okun <- read.csv(file.choose())
View(okun)
library(ggplot2)

library(readxl)
Noruega <- read_excel("~/GitHub/Analisis-Econometrico/Bases de datos/Base de datos VaR.xlsx", 
                      col_types = c("numeric", "numeric", "numeric"))
View(Noruega)



#Graficamos la correlación entre los datos mediante un diagrama de dispersión

ggplot(data = Noruega) + geom_point(mapping = aes(x= Noruega$`Gasto % PIB`, y= Noruega$PIB_REAL_Noruega ))

##Declaramos las variables como series de tiempo

Gasto <- ts(Noruega$`Gasto % PIB`, start = c(1971,1), frequency= 1)
PIB <- ts(Noruega$PIB_REAL_Noruega, start = c(1971,1), frequency = 1)

#Graficar las series de tiempo
autoplot(cbind(Gasto,PIB))
autoplot(cbind(PIB))
autoplot(cbind(Gasto))

#Observemos la correlación entre las variables usando una regresión

regresionlineal1 <- lm(Gasto ~ PIB )
summary(regresionlineal1) #Resultado de la regresión

regresion2 <- lm(PIB ~ Gasto)
summary(regresion2)

#Calculando los correlogramas

#Primero vamos a calcular los correlogramas para la serie PIB

acf(PIB , main ="ACF crecimiento del PIB Real" )  #AUTOCORRELOGRAMA=acf
pacf(PIB , main ="PACF crecimiento del PIB Real" ) #AUTOCORRELOGRAMA PARCIAL=pacf

acf(Gasto, main ="ACF Gasto publico" )
pacf(Gasto, main =" PACF Gasto publico" )

D_Gasto = diff(Gasto)
D_PIB = diff(PIB)


#Estacionar las series 
#Grafico 
ts.plot(diff(Noruega$`Gasto % PIB`),col="blue")

adf.test(diff(Noruega$), alternative="stationary", k=0)

ts.plot(diff(Noruega$PIB_REAL_Noruega),col="blue")

#Encontrando la cantidad de rezagos óptimas

okun.bv <- cbind(D_Gasto ,D_PIB )
colnames(okun.bv) <- cbind("D_PIB", "D_Gasto")
lagselect <- VARselect(okun.bv, lag.max = 10, type = "const")
lagselect$selection

#Construir el modelo

ModelOkun1 <- VAR(okun.bv, p = 10, type = "const", season = NULL, exog= NULL)
summary(ModelOkun1)

#Diagnóstico del VAR  

Serial1 <- serial.test(ModelOkun1, lags.pt = 12, type= "PT.asymptotic")
Serial1


##Si el P-valor obtenido en el test realizado es mayor a 0.05
#Encontramos que el modelo no tiene correlación serial
#Si por el contrario fuera menor a 0.05, si tendría problemas
#De correlación serial.

#Test de heterocedasticidad "Efecto ARCH"
Arch1 <- arch.test(ModelOkun1, lags.multi = 12, multivariate.only = TRUE)
Arch1
#Este test ARCH es como un test de Jarque Bera.
#Si el p-valor es mayor a 0.05, no rechazo la hipótesis nula
#Por lo tanto este modelo no tiene efecto ARCH por lo que no es Heterocedástico


#Distribución normal de los errores

Normal1 <- normality.test(ModelOkun1, multivariate.only = TRUE)
Normal1

#Si el test de JB PARA NORMALIDAD me muestra que el p-valor es menor a 0.05
#Encontramos que el modelo no sigue una distribución ruido blanco
#Pero ASUMIMOS que la distribución de los errores es normal (Por ahora)
#para continuar con el análisis


#Test para fallas estructurales

Stability <- stability(ModelOkun1, type = "OLS-CUSUM")
plot(Stability)

#Siempre y cuando la linea negra, que representa el proceso generador de datos
#esté por dentro de los intervalos de confianza, el modelo no tendrá 
#errores estructurales


#Causalidad de Granger

GrangerGDP <- causality(ModelOkun1, cause = "GDP")
GrangerGDP

#No hay causalidad en el sentido de Granger del GDP al desempleo

GrangerUNM <- causality(ModelOkun1, cause = "Unemployment")
GrangerUNM

#No hay causalidad en el sentido de Granger del desempleo al GDP

#Funciones impulso-respuesta

GDPirf <- irf(ModelOkun1, impulse = "Unemployment", response = "GDP", n.ahead = 20, boot = TRUE)
plot(GDPirf, ylabel = "GDP", main = "Choque del desempleo")


UNEMirf <- irf(ModelOkun1, impulse = "GDP", response = "Unemployment", n.ahead = 20, boot = TRUE)
plot(UNEMirf, ylabel = "Unemployment", main = "Choque del GDP")

#Descomposición de la varianza

FEVD1 <- fevd(ModelOkun1, n.ahead = 10)
plot(FEVD1)

#Pronóstico del VAR

forecast1 <- predict(ModelOkun1, n.ahead = 4, ci = 0.95)
fanchart(forecast1, names = "GDP")
fanchart(forecast1, names = "Unemployment")



