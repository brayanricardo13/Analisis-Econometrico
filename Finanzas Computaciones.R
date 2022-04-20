install.packages("tseries")
library(tseries)
install.packages("fPortfolio")
library(fPortfolio)
install.packages("knitr")
library(knitr)
install.packages("kableExtra")
library(kableExtra)
install.packages("gplots")
library(gplots)

# Parcial Finanzas computacionales 
APL<- get.hist.quote(instrument = "AAPL", 
                     start=as.Date("2020-03-23"), 
                     end=as.Date("2022-02-25"), quote = "AdjClose")
JPM<- get.hist.quote(instrument = "JPM", 
                     start=as.Date("2020-03-23"), 
                     end=as.Date("2022-02-25"), quote = "AdjClose")
FB<- get.hist.quote(instrument = "FB", 
                     start=as.Date("2020-03-23"), 
                     end=as.Date("2022-02-25"), quote = "AdjClose")



plot(JPM,col="red", main ="JP MORGAN")
plot(AAPL,main ="APPLE")

# Portafolio
CarteraInv <- merge(AAPL,JPM,FB, all = FALSE) 
names(CarteraInv)


plot(CarteraInv, main=" ", col="deepskyblue", xlab="Fecha")
title(main="Histórico de Cartera")

Rendimientos<-diff(log(CarteraInv))
head(Rendimientos,10)


plot(Rendimientos, main=" ", col="red", xlab="Fecha")
title(main="Rendimientos de la Cartera")

Cov <- cov(Rendimientos)*100
Cov

corr <- cor(Rendimientos) * 100
corr

# correlaciones 
generate_heat_map <- function(correlationMatrix, title)
{
   heatmap.2(x = correlationMatrix,    
            cellnote = correlationMatrix,   
            main = title,           
            symm = TRUE,            
            dendrogram="none",      
            Rowv = FALSE,           
            trace="none",           
            density.info="none",        
            notecol="black")          
}
corr1 <- round(cor(Rendimientos) * 100, 2)
generate_heat_map(corr1,"Mapa de calor: Correlaciones")


markov<-portfolioSpec()

setRiskFreeRate(markov)<- -0.001 #Tasa libre de riesgo
setNFrontierPoints(markov) <- 20 #Cantidad de carteras en frontera
constraints="LongOnly"


Frontera <- portfolioFrontier(as.timeSeries(Rendimientos),spec=markov,constraints )
Frontera












