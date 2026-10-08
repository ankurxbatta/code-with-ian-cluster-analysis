## CA-19 solutions verification - run this yourself, every number below is real R output
library(EMCluster)

cat("=== Problem 2: 4-object hand example ===\n")
method_t <- c(1, 1, 2, 2)
method_y <- c(1, 1, 1, 2)
print(RRand(method_t, method_y))          # expect Rand = 0.5
print(RRand(method_t, c(2, 2, 1, 1)))     # labels swapped -> still 1

cat("\n=== Problem 3a-b: six-object example ===\n")
method1 <- c(1, 1, 2, 2, 3, 3)
method2 <- c(1, 1, 1, 2, 2, 2)
print(RRand(method1, method2))            # expect 0.6667 / 0.2424

cat("\n=== Problem 3c-d: iris kmeans vs species ===\n")
set.seed(42)
km <- kmeans(iris[, 1:4], centers = 3, nstart = 25)
print(table(km$cluster, iris$Species))    # cluster 1: all 50 setosa
print(RRand(km$cluster, as.integer(iris$Species)))  # expect 0.8797 / 0.7302
cat("setosa a-votes from cluster 1:", choose(50, 2), "\n")

cat("\n=== Problem 4a: random labels on iris ===\n")
set.seed(7)
rand_iris <- sample(1:3, 150, replace = TRUE)
print(RRand(as.integer(iris$Species), rand_iris))    # expect 0.5580 / 0.0017

cat("\n=== Problem 4b: random labels, six-object ===\n")
set.seed(123)
rand6 <- sample(c(1, 2, 3), 6, replace = TRUE)
print(RRand(method1, rand6))             # expect 0.4667 / -0.1111
