## CA-6: K-means Clustering - assignment R script
## Run the checks from Problems 3, 4, and 5.

## --- Problem 3: the notes' R check on the 1-D hand-run ---
data1 <- c(1, 2, 5, 6)
names(data1) <- c("A", "B", "C", "D")
kmeans(data1, 2, nstart = 25)   # expect: means 1.5/5.5, 1 1 2 2, WSS 0.5/0.5, 94.1%

set.seed(42)
kmeans(data1, 2, nstart = 1)    # toy data: still lands at 1.5/5.5

## --- Problem 4: MacQueen's on the 2-D worksheet points ---
A <- c(5, 3); B <- c(-1, 1); C <- c(1, -2); D <- c(-3, -2)
m <- rbind(A, B, C, D)
km <- kmeans(m, rbind(A, C), algorithm = "MacQueen")
km$cluster      # expect: A=1, B=2, C=2, D=2
km$centers      # expect: (5,3) and (-1,-1)
km$tot.withinss # expect: 14

## --- Problem 5: USArrests walkthrough core ---
data("USArrests")
df <- scale(USArrests)
set.seed(123)
km.res <- kmeans(df, 4, nstart = 25)
print(km.res)   # expect: sizes 8/13/16/13, between_SS/total_SS = 71.2%
head(km.res$cluster, 4)
aggregate(USArrests, by = list(cluster = km.res$cluster), mean)
