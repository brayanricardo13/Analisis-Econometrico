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
install.packages("seasonal")
library(seasonal)

library(readxl)
Inflacion <- read_excel("GitHub/Analisis-Econometrico/Bases de datos/Base de datos clase 05.10.2021.xlsx", 
                        col_types = c("date", "numeric", "text", 
                                      "numeric", "numeric", "numeric", 
                                      "numeric"))
View(Inflacion)


plot(Inflacion$EFECTIVO)



serie.ajuste <- seas(Inflacion$EFECTIVO, x11 = "")











