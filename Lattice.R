# lattice

library(lattice)
library(datasets)

## simple scatter plot
xyplot(Ozone ~ Wind, data = airquality)

airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5,1))

## lattice Panel Functions

set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)
f < factor(f, labels = c("Group1", "Group2"))
xyplot(y ~ x | f, layout = c(2,1))

#custome panel function
xyplot(y ~ x | f, panel = function(x,y,...) {
    panel.xyplot(x,y,...) ## first call the default panel function for 'xyplot
    panel.abline(h=median(y), lty =2) ## add horizontal line at the median
})

#custome panel function
xyplot(y ~ x | f, panel = function(x,y,...) {
    panel.xyplot(x,y,...) ## first call the default panel function for 'xyplot
    panel.lmline(x , y, col = 2) ## overlay simple regression line
})