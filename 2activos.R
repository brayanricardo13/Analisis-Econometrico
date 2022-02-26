library(tseries)
library(timeSeries)
library(zoo)

### funci?n de riesgo y rentabilidad para portafolio de dos activos riesgosos

ACT1<-get.hist.quote('FB', quote = 'AdjClose', start = "2017-01-01", end = "2021-07-31",
               compression = "w")
ACT1<-as.timeSeries(ACT1)  
ACT2<-get.hist.quote("NFLX", quote = "AdjClose", start = "2017-01-01", end = "2021-07-31",
                     compression = "w")
ACT2<-as.timeSeries(ACT2)


risk <- function(act1, act2, w){
  ra1<-returns0(act1)*100
  ra2<-returns0(act2)*100
  mu1<-mean(ra1)
  mu2<-mean(ra2)
  mup<-w*mu1+(1-w)*mu2
  s1<-sd(ra1)
  s2<-sd(ra2)
  rho <-cor(ra1,ra2)
  sp <-sqrt(w^2*s1^2+(1-w)^2*s2^2+2*w*(1-w)*s1*s2*rho)
  return(c(mup,sp))
}

risk(act1= ACT1, act2 = ACT2, w = 0.5) #50% INVERTIDO EN EL PRIMER ACTIVO
risk(act1= ACT1, act2 = ACT2, w = 0.9)

p<-seq(0,1,by=0.1)

r<-risk(act1=ACT1, act2 = ACT2, w = p)
n<-length(r)
mup<-r[1:(n/2)]
mup
sp<-r[((n/2)+1):n]
sp
plot(sp,mup, col = "navy", main = "Grafico Riesgo-Retorno", xlab = "Riesgo", ylab = "Retorno")
lines(sp,mup, col = "blue")

### PORTAFOLIO DE MINIMA VARIANZA
wmin<-function(act1,act2){
  ra1<-returns0(act1)
  ra2<-returns0(act2)
  mu1<-mean(ra1)
  mu2<-mean(ra2)
  #mup<-w*mu1+(1-w)*mu2
  s1<-sd(ra1)
  s2<-sd(ra2)
  min<-(s2^2-cov(ra1,ra2))/(s1^2+s2^2-2*cov(ra1,ra2))
  return(c(min,1-min))
}
wmin<-wmin(ACT1,ACT2) 
wmin #estos son los pesos del portafolio de m?nima varianza
optimo<-risk(ACT1, ACT2, wmin[1]) 
optimo #esta es la rentabilidad y el riesgo de dicho portafolio
plot(sp,mup, col = "navy", main = "Grafico Riesgo-Retorno", xlab = "Riesgo", ylab = "Retorno")
lines(sp,mup, col = "blue")
points(optimo[2],optimo[1], type = "p", pch = 19, col ="red")


