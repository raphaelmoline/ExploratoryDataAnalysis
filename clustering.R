## hierarchical clustering

set.seed(1234)
par(mar = c(0,0,0,0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = .2)
y <- rnorm(12, mean = rep(c(1,2,1), each = 4), sd = .2)
plot(x,y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))


dataFrame <- data.frame(x = x, y = y)
distxy <- dist(dataFrame)
hClustering <- hclust(distxy)
plot(hClustering)


## K-means clustering
set.seed(1234)
x <- rnorm(12, mean = rep(1:3, each = 4), sd = .2)
y <- rnorm(12, mean = rep(c(1,2,1), each = 4), sd = .2)
plot(x,y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))

dataFrame <- data.frame(x,y)
kmeansObj <- kmeans(dataFrame, centers = 3)
names(kmeansObj)
kmeansObj$cluster

par(mar= rep(.2,4))
plot(x,y,col=kmeansObj$cluster, pch = 19, cex =2)
points(kmeansObj$centers, col = 1:3, pch =3, lwd = 3)

# principal component analysis
set.seed(12345)
par(mar = rep(0.2,4))
dataMatrix <- matrix(rnorm(400), nrow = 40)
image(1:10, 1:40, t(dataMatrix)[,nrow(dataMatrix):1])
heatmap(dataMatrix) ## no pattern

# with a pattern
set.seed(678910)
for (i in 1:40) {
    # flip a coin
    coinFlip <- rbinom(1, size = 1, prob = 0.5)
    # if coin is heads add a common pattern to that row
    if (coinFlip) {
        dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,3), each = 5)
    }
}
image(1:10, 1:40, t(dataMatrix)[,nrow(dataMatrix):1])
heatmap(dataMatrix)

dev.off()
hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order,]
par(mfrow = c(1,3))
image(1:10, 1:40, t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(rowMeans(dataMatrixOrdered), 40:1, xlab = "Row Mean", ylab = "Row", pch = 19)
plot(colMeans(dataMatrixOrdered), xlab = "Column", ylab = "Column Mean", pch = 19)

## singular value decomposition
svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(svd1$u[,1],40:1, , xlab = "Row", ylab = "First left singular vector", pch =19)
plot(svd1$v[,1], xlab = "Column", ylab = "First right singular vector", pch = 19)

# SVD - variance explaine
par(mfrow = c(1,2))
plot(svd1$d, xlab = "Column", ylab = "Singular value", pch = 19)
plot(svd1$d^2/sum(svd1$d^2), xlab = "Column", ylab = "Prop. of variance explained", pch = 19)


# relationship to pca
dev.off()
svd1 <- svd(scale(dataMatrixOrdered))
pca1 <- prcomp(dataMatrixOrdered, scale = TRUE)
plot(pca1$rotation[,1], svd1$v[,1], pch = 19, xlab = "Principal Component 1", ylab = "Right Singular Vector 1")
abline(c(0,1))

# variance explained
constantMatrix <- dataMatrixOrdered*0
for (i in 1:dim(dataMatrixOrdered)[1]) {constantMatrix[i,] <- rep(c(0,1), each =5)}
svd1 <- svd(constantMatrix)
par(mfrow=c(1,3))
image(t(constantMatrix)[,nrow(constantMatrix):1])
plot(svd1$d, xlab="Column", ylab="Singular value", pch=19)
plot(svd1$d^2/sum(svd1$d^2), xlab = "Column", ylab = "Prop. of variance explained", pch = 19)

# add a second pattern
set.seed(678910)
for (i in 1:40) {
    # flip a coin
    coinFlip1 <- rbinom(1, size = 1, prob = 0.5)
    coinFlip2 <- rbinom(1, size = 1, prob = 0.5)
    # if coin is heads add a common pattern to that row
    if (coinFlip1) {
        dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,5), each = 5)
    }
    if (coinFlip2) {
        dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,5),  5)
    }
}
hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order,]

svd2 <- svd(scale(dataMatrixOrdered))
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(rep(c(0,1), each = 5), pch = 19, xlab = "Column", ylab = "Pattern 1")
plot(rep(c(0,1), 5), pch =19, xlab = "Columm", ylab = "Pattern 2")

# v and patterns of variance in rows
svd2 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(svd2$v[,1] , xlab = "Column", ylab = "First right singular vector", pch =19)
plot(svd2$v[,2], xlab = "Column", ylab = "Second right singular vector", pch = 19)

# d and variance explained
svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1,2))
plot(svd1$d, xlab = "Column", ylab = "Singular value", pch = 19)
plot(svd1$d^2/sum(svd1$d^2), xlab = "Column", ylab = "Percent of variance explained", pch = 19)

# missing values
dataMatrix2 <- dataMatrixOrdered
## randomly insert some miossing data
dataMatrix2[sample(1:100, size =40, replace = FALSE)] <- NA
svd1 <- svd(scale(dataMatrix2)) ## does not work!

# impute library -> not available in current R version
