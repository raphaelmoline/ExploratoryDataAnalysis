setwd("/Users/manonbreuvart/Documents/R studio/ExploratoryDataAnalysis")

# coursera case study on Samsung data
# getting the data and massaging it http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

# accelerometre data
columnNames <- read.table("data/Samsung/features.txt")
data <- read.table("data/Samsung/train/X_train.txt")
names(data) <- columnNames[,2]

# activity
activityLabels <- read.table("data/Samsung/activity_labels.txt")
activityLabels$names <- c("walk", "walkdown", "walkup", "sitting", "standing", "laying")
activity_id <- read.table("data/Samsung/train/y_train.txt",colClasses = "factor")
levels(activity_id[,1]) <- activityLabels$names  # mor explicity lables
names(activity_id)[1] <- "activity"

# subject
subject_id <- read.table("data/Samsung/train/subject_train.txt", colClasses = "factor")
names(subject_id)[1] <- "subject"

# combine all the data
data <- cbind(data,activity_id,subject_id)

# case study
names(data)[1:12]
table(data$activity)

# subset on subject1
sub1 <- subset(data,subject == 1)

# first look at some data
sub1$Activity
summary(sub1$activity)
names(sub1[,1:3])
head(sub1[,1:3])

# plot activity for first 3 variables with different colors
par(mfrow = c(1, 3), mar = c(5, 4, 1, 1))
plot(sub1[, 1], col = sub1$activity, ylab = names(sub1)[1])
plot(sub1[, 2], col = sub1$activity, ylab = names(sub1)[2])
plot(sub1[, 3], col = sub1$activity, ylab = names(sub1)[3])
legend("bottomright", legend = unique(sub1$activity), col = unique(sub1$activity),pch=1)

# source function to have color clusers
source("myplclust.R")

# clustering based on average acceleration
# Calculate the distance between the average acceleration in the x, y, and z-coordinates and all of the different activities, and perform a hierarchical clustering

par(mfrow = c(1, 1))
distanceMatrix <- dist(sub1[, 1:3]) ## Calculate the distance matrix
hclustering <- hclust(distanceMatrix) ## Perform the hierarchical clustering
myplclust(hclustering, lab.col = unclass(sub1$activity)) ## Apply the myplclust() function

# RESULTS 1: The data are clustered by activity, but the plot actually doesn't cluster the activities very nicely
# RESULTS 2: Despite there being some differences, say, between standing and walking, many of the activities have sort of similar patterns of variation across this, their activities that they're performing
# SOLUTION: Trying to plot and cluster on other variables : maximum acceleration on the x-coordinate, the y-coordinate axis and the z-coordinate axis

# Plotting max acceleration for the first subject
names(sub1[,10:12])
head(sub1[,10:12])

rng = range(sub1[, 10], sub1[, 11], sub1[, 12], na.rm = T) ## Define a common range for y-axis values
par(mfrow = c(1, 3), mar = c(5, 4, 1, 1))
plot(sub1[, 10], pch = 19, col = sub1$activity, ylab = names(sub1)[10], ylim = rng)
plot(sub1[, 11], pch = 19, col = sub1$activity, ylab = names(sub1)[11], ylim = rng)
plot(sub1[, 12], pch = 19, col = sub1$activity, ylab = names(sub1)[12], ylim = rng)
legend("topright", legend = unique(sub1$activity), col = unique(sub1$activity),
       pch=1) ## Put a legend for activity by colors in top right corner of the 3rd plot

# CONLUSIONS:The maximum accezleration is a better variable to distinguish non-moving activities (green “standing”, red “sitting” and black “laying”) from moving activities (blue “walk”, lightblue “walkdown” and purple “walkup”)
# EXPECTATIONS: Clustering analysis on maximum acceleration should distinguish better the activities

# nb other variables can be tested eg 275-277 that gives a decent breakdown on non walking activities

par(mfrow = c(1, 1))
distanceMatrix <- dist(sub1[, 10:12]) ## Calculate the distance matrix
hclustering <- hclust(distanceMatrix) ## Perform the hierarchical clustering
myplclust(hclustering, lab.col = unclass(sub1$activity)) ## Apply the myplclust() function

#CONCLUSIONS: Clustering analysis don not well distinguish activities. For non-moving activities, only walkdown activities (in lightblue) have his own cluster
#SOLUTION: Use the singular value decomposition of the subject 1 subset of Samsung data set

# singular value decomposition
names(sub1[562:563]) # not used for SVD

# Take care of the non numeric variables
svd1 <- svd(scale(sub1[, -c(562, 563)]))
u1 <- svd1$u
v1 <- svd1$v
d1 <- svd1$d
diag1 <- diag(d1)

# IMPORTANT: left singular vector actually represents the average of potentially multiple patterns that are observed in the dataset.
# Plot the matrix U where the m columns are the left singular vectors of the subject 1 subset (u)

par(mfrow = c(1, 3))
# Define a common range for y-axis values
rng = range(svd1$u[, 1], svd1$u[, 2], na.rm = T)
# Plot the first left singular vector of matrix U 
plot(svd1$u[, 1], col = sub1$activity, ylab = "first left singular vector (subject 1)", pch = 19, ylim = rng)
legend("bottomleft", legend = unique(sub1$activity), col = unique(sub1$activity),pch=1, cex = 0.8)
# Plot the second left singular vectors of matrix U 
plot(svd1$u[, 2], col = sub1$activity, ylab = "second left singular vector (subject 1)", pch = 19, ylim = rng)
# Plot the third left singular vectors of matrix U 
plot(svd1$u[, 3], col = sub1$activity, ylab = "third left singular vector (subject 1)", pch = 19, ylim = rng)


# CONCLUSION 1: The first left singular vector distinguish the non-moving activities from the moving activities (no different patterns from the clustering analysis)
# CONCLUSION 2: The second and the third left singular vectors show different patterns in activities. The walkup and the walkdown moving activities are well separated.
# EXPECTATIONS: Let's look at the right singular vectors of the second and third left singular vectors to identify the variables which have induced these patterns
# WHICH VARIABLE IS THE MAX CONTRIBUTOR FOR SECOND & THIRD LEFT SINGULAR VECTOR: Plot the matrix V where the columns n correspond to the right singular vectors that correspond to the second and the third left singular vectors of the matrix u (v)

par(mfrow = c(1, 3))
# Plot the first right singular vector (not retained)
plot(svd1$v[, 1], col = sub1$activity, ylab = "first right singular vector (subject 1)", pch = 19)
# Plot the second right singular vector
plot(svd1$v[, 2], col = sub1$activity, ylab = "second right singular vector (subject 1)", pch = 19)
# Plot the third right singular vector
plot(svd1$v[, 3], col = sub1$activity, ylab = "third right singular vector (subject 1)", pch = 19)

# Plot the matrix D with the diagonal entries are the singular value (d)
par(mfrow = c(1, 2))
plot(svd1$d, col = sub1$activity, ylab = "determinant", pch = 19)
plot(diag(svd1$d),col = sub1$activity, ylab = "singular values", pch = 19)
legend("topright", legend = unique(sub1$activity), col = unique(sub1$activity),pch=1, cex = 0.8)

# New clustering with maximum contributer based on maximum acceleration
# Maximum contributor variable for the second left singular vector

par(mfrow = c(1, 1))
maxContrib2nd <- which.max(svd1$v[, 2])
distanceMatrix2nd <- dist(sub1[, c(10:12, maxContrib2nd)]) ## add one max contribut factor
hclustering2nd <- hclust(distanceMatrix2nd)
myplclust(hclustering2nd, lab.col = unclass(sub1$activity))


# CONCLUSION: the 3 moving activities are clearcly separated. The non-moving activities are mixed together.
# Maximum contributor variable for the third left singular vector

maxContrib3rd <- which.max(svd1$v[, 3])
distanceMatrix3rd <- dist(sub1[, c(10:12, maxContrib3rd)])
hclustering3rd <- hclust(distanceMatrix3rd)
myplclust(hclustering3rd, lab.col = unclass(sub1$activity))

# test using the biggest contributor variables for the 3rd left singular vectors -> not enough
contrib <- c(which.max(svd1$v[, 1]),which.max(svd1$v[, 2]),which.max(svd1$v[, 3]))
distanceMatrix4th <- dist(sub1[,contrib])
hclustering4th <- hclust(distanceMatrix4th)
myplclust(hclustering4th, lab.col = unclass(sub1$activity))

# K-means clustering (nstart=1, first try)
kClust <- kmeans(sub1[, -c(562, 563)], centers = 6)
table(kClust$cluster, sub1$activity)

# K-means clustering (nstart=1, second try)
kClust <- kmeans(sub1[, -c(562, 563)], centers = 6, nstart = 1)
table(kClust$cluster, sub1$activity)

# K-means clustering (nstart=100, first try)
kClust <- kmeans(sub1[, -c(562, 563)], centers = 6, nstart = 100)
table(kClust$cluster, sub1$activity)

# K-means clustering (nstart=100, second try)
kClust <- kmeans(sub1[, -c(562, 563)], centers = 6, nstart = 100)
table(kClust$cluster, sub1$activity)

# Cluster 1 Variable Centers (Laying)
plot(kClust$center[1, 1:10], pch = 19, ylab = "Cluster Center", xlab = "")

# Cluster 1 Variable Centers (Walking)
plot(kClust$center[4, 1:10], pch = 19, ylab = "Cluster Center", xlab = "")