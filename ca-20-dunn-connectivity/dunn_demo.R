# CA-20: Dunn index demo (worksheet example, real executed R)
library(fpc)
SepalLength <- c(5.1, 4.9, 7.0, 5.0, 5.1, 6.3, 6.5, 6.9)
PetalLength <- c(1.4, 1.5, 4.7, 3.5, 3.3, 6.0, 5.1, 5.7)
df <- data.frame(SepalLength, PetalLength)
set.seed(42)
km.res <- kmeans(df, 3, nstart = 25)
km.res$cluster   # 1 1 3 2 2 3 3 3
km.res$size      # 2 2 4
km_stats <- cluster.stats(dist(df), km.res$cluster)
km_stats$dunn    # 1.226616
# hand-example check: points 1,2,5,6 with clusters {1,2},{5,6}
cluster.stats(dist(data.frame(x = c(1, 2, 5, 6))), c(1, 1, 2, 2))$dunn  # 3
