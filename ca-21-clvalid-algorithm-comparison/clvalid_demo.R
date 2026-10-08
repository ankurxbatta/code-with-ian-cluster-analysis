## CA-21 demo: clValid internal-validation tournament on iris.
## Episode demo (also the basis for the assignment problems).
library(clValid)

df <- scale(iris[, -5])

clmethods <- c("hierarchical", "kmeans", "pam")
intern <- clValid(df, nClust = 2:6,
                  clMethods = clmethods, validation = "internal")
summary(intern)
optimalScores(intern)

## The tie is real: identical 50-vs-100 split from all three methods
hc2 <- cutree(hclust(dist(df), method = "average"), 2)
km2 <- kmeans(df, 2, nstart = 25)$cluster
pm2 <- cluster::pam(df, 2)$clustering
table(hc2, km2)
table(hc2, pm2)
table(hc2, iris$Species)

## The crown moves with the list order (tie-break rule)
intern2 <- clValid(df, nClust = 2:6,
                   clMethods = c("pam", "kmeans", "hierarchical"),
                   validation = "internal")
optimalScores(intern2)

## The plots: built-in silhouette curves + hand-built Dunn plot
plot(intern, legend = FALSE)
m <- measures(intern); ks <- nClusters(intern); dmat <- m["Dunn", , ]
plot(ks, dmat[, "hierarchical"], type = "b", pch = 1, lty = 1, col = 1,
     ylim = range(dmat), xlab = "k (clusters)", ylab = "Dunn index",
     main = "Dunn index vs k - three algorithms")
lines(ks, dmat[, "kmeans"], type = "b", pch = 2, lty = 2, col = 2)
lines(ks, dmat[, "pam"], type = "b", pch = 3, lty = 3, col = 4)
legend("topright", clusterMethods(intern), col = c(1, 2, 4),
       lty = 1:3, pch = 1:3)
