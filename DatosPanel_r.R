

install.packages("car")
install.packages("apsrtable")
install.packages("foreign")
library(foreign)

# Tomado de la UNIVERSIDAD DE PRINCETON:
Panel <- read.dta("http://dss.princeton.edu/training/Panel101.dta")
View(Panel)

coplot(y ~ year|country, type="l", data=Panel) 

library(car)
scatterplot(y~year|country, boxplots=FALSE, smooth=TRUE, reg.line=FALSE, data=Panel)
coplot(y ~ year|country, type="b", data=Panel) 

library(gplots)
plotmeans(y ~ country, main="Heterogeineity across countries", data=Panel)
plotmeans(y ~ year, main="Heterogeineity across years", data=Panel)


ols <-lm(y ~ x1, data=Panel)
summary(ols)

yhat <- ols$fitted
plot(Panel$x1, Panel$y, pch=19, xlab="x1", ylab="y")
abline(lm(Panel$y~Panel$x1),lwd=3, col="red")

fixed.dum <-lm(y ~ x1 + factor(country) - 1, data=Panel)
summary(fixed.dum)


yhat <- fixed.dum$fitted
library(car)
scatterplot(yhat~Panel$x1|Panel$country, boxplots=FALSE, xlab="x1", ylab="yhat",smooth=FALSE)
abline(lm(Panel$y~Panel$x1),lwd=3, col="red")


library(apsrtable)
apsrtable(ols,fixed.dum, model.names = c("OLS", "OLS_DUM"))

library(plm)
fixed <- plm(y ~ x1, data=Panel, index=c("country", "year"), model="within")
summary(fixed)

fixef(fixed) 
pFtest(fixed, ols)

random <- plm(y ~ x1, data=Panel, index=c("country", "year"), model="random")
summary(random)

phtest(fixed, random)

pool <- plm(y ~ x1, data=Panel, index=c("country", "year"), model="pooling")
summary(pool)

plmtest(pool, type=c("bp"))


