library(zoo)
library(tseries)
library(timeSeries)
library(quantmod)
library(fPortfolio)
library(knitr)
library(kableExtra)
# Activo 1
VOO<-get.hist.quote('VOO', quote = 'AdjClose', start = "2019-01-01", end = "2022-03-25",compression = "w")
plot(VOO, col ="red", main = "VOO") # Grafico

# Activo 2
QQQ<-get.hist.quote("QQQ", quote = "AdjClose", start = "2019-01-01", end = "2022-03-25",compression = "w")
plot(QQQ, col ="red", main = "QQQ") # Grafica

# Activo 3
FB<-get.hist.quote("FB", quote = "AdjClose", start = "2019-01-01", end = "2022-03-25",compression = "w")
plot(FB, col ="red", main = "FB") # Grafica


# Retornos ACTIVO 1
rACT1<-diff(log(VOO))
plot(rACT1,col ="red", main = "VOO")

# Retornos ACTIVO 2
rACT2<-diff(log(QQQ))
plot(rACT1,col ="red", main = "QQQ")

# Retornos ACTIVO 3
rACT3<-diff(log(FB))
plot(rACT1,col ="red", main = "FB")

# Cartera
CarteraInv <- merge(VOO,QQQ,FB, all = FALSE) 
names(CarteraInv)
# Historico de cartera
names(CarteraInv)<-c("VOO","QQQ","FB")
plot(CarteraInv, main=" ", col="deepskyblue", xlab="Fecha")
title(main="Histórico de Cartera")
# Rendimientos 
Rendimientos<-diff(log(CarteraInv))
head(Rendimientos,10)
plot(Rendimientos, main=" ", col="deepskyblue", xlab="Fecha")
title(main="Rendimientos de la Cartera")

# Rendimiento Promedio
RendimientoPromedio = c(mean(Rendimientos$VOO),mean(Rendimientos$QQQ),mean(Rendimientos$FB))
RendimientoPromedio 

# Volatilidad
Volatilidad = c(sd(Rendimientos$VOO),sd(Rendimientos$QQQ),sd(Rendimientos$FB))
Volatilidad
# Resumen 
Cuadro = data.frame (rbind(RendimientoPromedio,Volatilidad))
colnames(Cuadro)<- c("VOO","QQQ", "FB")
Cuadro*100  

# Covarianza 
Cov <- cov(Rendimientos)*100
Cov
# Correlaciones 
corr <- cor(Rendimientos) * 100
corr







