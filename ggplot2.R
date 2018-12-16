## ggplot2

library(ggplot2)
str(mpg)
qplot(displ, hwy, data=mpg)

## modifying aesthetics
qplot(displ, hwy, data=mpg, col = drv)

## adding a geom
qplot(displ, hwy, data=mpg, geom=c("point", "smooth"))

## histograms
qplot(hwy, data = mpg, fill = drv)

#boxplot
qplot(drv, hwy, data = mpg, geom = "boxplot", color = manufacturer)

## facets
qplot(displ, hwy, data = mpg, facets =.~drv)
qplot(hwy, data = mpg, facets =drv~., binwidth = 2)

## ggplot
g <- ggplot(mpg, aes(displ, hwy))
g+geom_point()+geom_smooth(method = "lm")+facet_grid(.~drv)
g+geom_point()+geom_smooth(method = "lm")+facet_grid(.~drv)+ggtitle("Title")
g+geom_point(color = "pink", size = 4, alpha =1/2)
g+geom_point(size = 4, alpha =1/2, aes(color = drv))
g+geom_point(aes(color = drv)) + labs(title = "Swirl Rules!") + labs(x="Displacement", y="Hwy Mileage")
g+geom_point(size = 2, alpha =1/2, aes(color = drv)) + geom_smooth(size = 4, linetype = 3, method = "lm", se = FALSE)
g+geom_point(aes(color = drv)) + theme_bw(base_family = "Times")
g <- ggplot(mpg,aes(x = displ, y = hwy, color = factor(year)))
g + geom_point()
g + geom_point() + facet_grid(drv~cyl, margins = TRUE)
g + geom_point() + facet_grid(drv~cyl, margins = TRUE) + geom_smooth(method = "lm", se = FALSE, size = 2, color = "black")








