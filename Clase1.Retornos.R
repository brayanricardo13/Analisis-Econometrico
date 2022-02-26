## Retornos financieros 
## Hay dos tipos de retornos discretos y continuos
# Tomemos como ejemplo:
act1<-c(120,134,139,124,130,112,128,138,132,148) # en USD
act2<-c(2340,2450,2400,2310,2390,2390,2480,2560,2500,2460) # en JPY
# supongamos que no pagan dividendos:
r1<-diff(act1)/act1 #aqui calculamos los retornos discretos de manera manual
r1=r1[1:9] 
r2<-diff(act2)/act2
r2=r2[1:9]
# Ahora los logaritmicos (continuos)
rc1<-rep(0,9)
for (i in 1:9) {
  rc1[i]=log(act1[i+1]/act1[i])
}
rc2<-rep(0,9)
for (i in 1:9) {
  rc2[i]=log(act2[i+1]/act2[i])
}
## Medidas de rentabilidad y riesgo
m1=mean(r1) # con mean sacamos promedio
m2=mean(r2)
v1=sd(r1) # con sd sacamos desviacion estandar
v2=sd(r2)
rho<-cor(r1,r2)
## Comparacion de retornos (discretos y continuos)
plot(r1, type = "l", col = "blue", main = "comparacion de retornos")
lines(rc1, type = "l", col = "red")
## Comparacion de retornos (entre activos)
plot(r1, type = "l", col = "blue", main = "comparacion de retornos")
lines(r2, type = "l", col = "red")

library(tseries)
library(timeSeries)
rr1<-returns0(act1)
rr1<-rr1[2:10]
rr1<-as.timeSeries(rr1)
plot(rr1, col = "navy")

ACT1<-get.hist.quote('^GSPC', quote = 'AdjClose', start = "2017-01-01", end = "2021-08-04",
                     compression = "w")
ACT1<-as.timeSeries(ACT1)  
ACT2<-get.hist.quote("^GDAXI", quote = "AdjClose", start = "2017-01-01", end = "2021-08-04",
                     compression = "w")
ACT2<-as.timeSeries(ACT2)

plot(ACT1, col = "blue")
plot(ACT2, col = "navy")

rACT1<-returns0(ACT1)
rACT2<-returns0(ACT2)
plot(rACT1, col = "green")
plot(rACT2, col = "orange")

mu1<-mean(rACT1) 
mu1 #rendimiento promedio syp 500
mu2<-mean(rACT2)
mu2 #rendimiento promedio DAXI

s1<-sd(rACT1)
s1 # volatilidad semanal syp500
s2<-sd(rACT2)
s2
ACT3<-get.hist.quote("FB", quote = "AdjClose", start = "2020-02-01", end = "2021-02-03",
                     compression = "d")
ACT3<-as.timeSeries(ACT3)
plot(ACT3, col = "purple")

a <- c(100, 110, 121, 96.80, 77.44, 116.16, 105.60)
ra <- returns0(a)
ra <- ra[-1]
mean(ra)
sd(ra)*sqrt(12)
