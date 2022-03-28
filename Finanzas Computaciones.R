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

AAPL<- get.hist.quote(instrument = "AAPL", 
                      start=as.Date("2020-03-23"), 
                      end=as.Date("2022-02-25"), quote = "AdjClose")
JPM<- get.hist.quote(instrument = "JPM", 
                     start=as.Date("2020-03-23"), 
                     end=as.Date("2022-02-25"), quote = "AdjClose")
plot(JPM)
plot(AAPL)

# Portafolio
CarteraInv <- merge(AAPL,JPM, all = FALSE) 
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


markov<-portfolioSpec()

setRiskFreeRate(markov)<- -0.001 #Tasa libre de riesgo
setNFrontierPoints(markov) <- 20 #Cantidad de carteras en frontera

constraints="LongOnly"

Frontera <- portfolioFrontier(as.timeSeries(Rendimientos),spec=markov,constraints )
Frontera


frontierPlot(Frontera)
grid()
tangencyPoints(Frontera, pch = 19, col = "red", cex=2)
tangencyLines(Frontera, col="grey", pch=19, cex=2)
minvariancePoints(Frontera, col="blue", pch=19, cex=2)
monteCarloPoints(Frontera, mCsteps=2000, col="#0098D5", cex=0.001)


col <- qualiPalette(ncol(Rendimientos), "Pastel1")
weightsPlot(Frontera, col=col)



efPortfolio <- efficientPortfolio(as.timeSeries(Rendimientos),markov,constraints)
efPortfolio


weightsPie(efPortfolio, col=col )
mtext(text = "Portafolio eficiente", side = 3, line = 1.5,
      font = 2, cex = 0.7, adj = 0)

















