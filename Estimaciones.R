install.packages("urca")
library(urca)
install.packages("vars")
library(vars)
install.packages("mFilter")
library(mFilter)
install.packages("tseries")
library(tseries)
install.packages("forecast")
library(forecast)
install.packages("tidyverse")
library(tidyverse)
install.packages("scales")
library(scales)
install.packages("ggplot2")
library(ggplot2)
# Base de Datos 
library(readxl)
Indicadores_laborales <- read_excel("C:/Users/Familia Fonseca/Downloads/Indicadores laborales.xlsx", 
                                    col_types = c("date", "numeric"))
View(Indicadores_laborales)

plot(Indicadores_laborales$Desempleo,type = "l", col = "black", xlim = c(215,250))

autoplot(Indicadores_laborales)











