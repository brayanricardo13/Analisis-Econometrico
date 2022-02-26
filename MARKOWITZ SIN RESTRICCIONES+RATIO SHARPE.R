### PORTAFOLIO GENERAL DE MARKOWITZ
# instalar paquetes
library(tseries)
library(timeSeries)

Port<-c('AAPL','IBM','PFE')

## Metodo (for)

M <- length(get.hist.quote('IBM', quote = 'AdjClose', start =as.Date('2010-01-01'), compression='w'))
N <- length(Port)

data1 <- matrix(rep(0,M*N),M,N)

for (i in 1:N){
  data1[,i]= c(get.hist.quote(Port[i], start=as.Date('2010-01-01'), quote ='AdjClose', compression='w'))
}

# Retornos
r.data1 <- returns0(data1)
r.data1 <- na.omit(r.data1[-1,])
## Portafolio de min varianza sin restricciones
uno <- matrix(rep(1,N),N,1) #generemos un vector de unos
mu <- apply(r.data1, 2 , mean) # calculamos el promedio de los retornos 
# mediante la funcion apply (promedio de cada activo)
mu<-as.matrix(mu)  # lo fijamos como una matriz
mu # vemos los retornos esperados (promedios) individuales
sigma <- var(r.data1) # matriz de covarianzas
sigma # se muestra la matriz de varianzas-covarianzas
A<-solve(sigma)%*%uno 
B<-as.numeric(t(uno)%*%solve(sigma)%*%uno)
min<-A/B
min
### Razon de Sharpe del portafolio
sp<-sqrt(as.numeric(t(min)%*%sigma%*%min)) ### volatilidad del portafolio
sp
rf<-0.04/52
mup <- t(min)%*%mu
mup ## rentabilidad media de este portafolio
### si la inversion es 10000000 USD
10000000*mup
SRP<-(t(min)%*%mu-rf)/sp
SRP

### Razón de sharpe del nuevo activo
dataNew<-get.hist.quote('NFLX', start=as.Date('2010-01-01'), quote ='AdjClose', compression='w')
r.dataNew<-returns0(dataNew)    # calculamos aqui los retornos del nuevo
r.dataNew<-na.omit(r.dataNew[-1,])
munew<-mean(r.dataNew) #calculamos la media de los retornos
snew<-sd(r.dataNew) # calculamos el riesgo de los retornos del nuevo
SRN<-(munew-rf)/snew # Sharpe Ratio del nuevo
### Ahora es necesario calcular corr del portafolio Y DEL ACTIVO NUEVO
r.port<-min[1]*r.data1[,1]+min[2]*r.data1[,2]+min[3]*r.data1[,3]
rhopnew<-cor(r.port,r.dataNew) # correlacion entre los retonos del port y el nuevo

SRN>rhopnew*SRP # criterio

Port2<-c('MMM','NKE','PG','NFLX')
