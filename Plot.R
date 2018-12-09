#commit in new rep - test

csvUrl <- "https://raw.githubusercontent.com/jtleek/modules/master/04_ExploratoryAnalysis/exploratoryGraphs/data/avgpm25.csv"
download.file(csvUrl , destfile = "pollution.csv", method="curl")

pollution <- read.csv("pollution.csv", colClasses = c("numeric", "character", "factor", "numeric", "numeric"))

summary(pollution$pm25)

#boxplot and histograms
boxplot(pollution$pm25, col = "blue")

hist(pollution$pm25, col = "green")
rug(pollution$pm25)

hist(pollution$pm25, col = "green", breaks = 100)
rug(pollution$pm25)

#overlaying features
boxplot(pollution$pm25, col = "blue")
abline(h=12)

hist(pollution$pm25, col = "green")
abline(v = 12, lwd = 2)
abline(v = median(pollution$pm25), col = "magenta", lwd = 4)

#barplot
barplot(table(pollution$region), col = "wheat", main = "Number of Counties in Each Region")

#2 dimensional
boxplot(pm25 ~ region, data = pollution, col = "red")
par(mfrow = c(2,1), mar = c(4,4,2,1))
hist(subset(pollution, region == "east")$pm25, col = "green")
hist(subset(pollution, region == "west")$pm25, col = "green")

#scatterplot
with(pollution, plot(latitude, pm25))
abline(h = 12, lwd = 2, lty = 2)

with(pollution, plot(latitude, pm25, col = region))
abline(h = 12, lwd = 2, lty = 2)

par(mfrow = c(1,2), mar = c(5,4,2,1))
with(subset(pollution, region == "west"), plot(latitude, pm25, main = "West"))
with(subset(pollution, region == "east"), plot(latitude, pm25, main = "East"))

# base plot
library(datasets)
data(cars)
with(cars, plot(speed, dist))

# lattice system
library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4,1))

# ggplot2 system
library(ggplot2)
data(mpg)
qplot(displ, hwy, data = mpg)

#base plotting system, create graphic on screen
hist(airquality$Ozone)
with(airquality, plot(Wind, Ozone))
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone ppb")

#base graphics parameters
par("lty")
par("col")
par("pch")
par("bg")
par("mar")
par("mfrow")

#annotations
par(mfrow = c(1,1))
with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind in New York City") 

with(airquality, plot(Wind, Ozone,main = "Ozone and Wind in New York City"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))

with(airquality, plot(Wind, Ozone,main = "Ozone and Wind in New York City", type = "n"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May","Other Months"))

#adding regression line

with(airquality, plot(Wind, Ozone,main = "Ozone and Wind in New York City", pch = 20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2)
#multiple plots
par(mfrow = c(2,1))
with(airquality, {
    plot(Wind, Ozone, main = "Ozone and Wind")
    plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
})

#demo
par(mfrow = c(1,1))
x <- rnorm(100)
hist(x)
y <- rnorm(100)
plot(x,y)
z <- rnorm(100)
plot(x,z)
par(mar = c(2,2,2,2))
plot(x,z)
par(mar = c(4,4,2,2))
plot(x,z)
plot(x,z,pch = 20)
title('Scatterplot')
text(-1, -1, "test")
legend("topleft", legend = "data", pch = 20)
fit <- lm(y ~ x)
abline(fit)
