install.packages("urca")
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
library(ggplot2)
library(readxl)

library(readxl)
Proyecciones <- read_excel("C:/Users/Familia Fonseca/Downloads/Proyecciones IE.xlsx", 
                              sheet = "Serie", col_types = c("date", 
                                                             "numeric", "numeric","numeric"))
View(Proyecciones)


Anual <- ts(Proyecciones$Anual, start = c(2015), frequency= 12)
IPC <- ts(Proyecciones$IPC, start = c(2015), frequency= 12)
Pronostico <- ts(Proyecciones$Pronostico, start = c(2015), frequency= 12)

Anual1 <- Proyecciones$Anual

Anual1 <- ts(Anual1, start = c(2015), frequency= 12)


autoplot (cbind (Anual))
autoplot (cbind (IPC))
autoplot (cbind (Pronostico))

autoplot (cbind (Anual,Pronostico))


desc = decompose(Anual)
plot(desc, xlab='Fecha')

taylor.bv <- cbind(Anual,Anual1)
colnames(taylor.bv) <- cbind("Anual", "Anual1")
view(taylor.bv)
lagselect <- VARselect(taylor.bv, lag.max = 10, type = "const")
lagselect$selection





#como un Modelo arima estacionario 
modelo1 <- auto.arima(diff(Anual), seasonal=T, stepwise=T, approximation=T)
summary(modelo)
checkresiduals(modelo) # Los residuales no estan correlacionados





#como un Modelo arima 
modelo <- auto.arima(Anual, seasonal=T, stepwise=T, approximation=T)
summary(modelo)
checkresiduals(modelo) # Los residuales no estan correlacionados


# Pronóstico
autoplot(forecast(modelo1, h=50), predict.colour = "green",
         predict.linetype = "dashed", conf.int = FALSE,title = "IPC_MENSUAL")



autoplot(forecast(modelo, h=50), predict.colour = "green",
         predict.linetype = "dashed", conf.int = FALSE, title = "IPC_MENSUAL")






