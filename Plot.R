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

