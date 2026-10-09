## Stability demo for CA-22 (real executed R, episode of record)

library(clValid)

# The arena: scaled iris data, Species column removed (internal validation
# means the data judges itself - no answer key)
df <- scale(iris[, -5])

# The tournament: 3 methods x 5 cluster counts, stability judges
clmethods <- c("hierarchical", "kmeans", "pam")
set.seed(42)
stab <- clValid(df, nClust = 2:6, clMethods = clmethods,
                validation = "stability")

# The winners table
optimalScores(stab)

# The full scoreboards, one per measure (rows = cluster counts, cols = methods)
for (meas in c("APN", "AD", "ADM", "FOM")) {
  cat("======== ", meas, " (lower is better) ========\n", sep = "")
  print(measures(stab)[meas, , ])
}

# The k=2 tie, verified: are the three 2-cluster solutions the same?
hc2 <- cutree(hclust(dist(df), method = "average"), 2)
km2 <- kmeans(df, 2, nstart = 25)$cluster
pm2 <- cluster::pam(df, 2)$clustering
cat("kmeans vs pam 2-cluster table:\n")
print(table(km2, pm2))
cat("all three give the 50-vs-100 split:",
    all(sort(table(hc2)) == c(50, 100)), "\n")

# The hand-worked APN term from the episode: flower 1, hierarchical, 2 clusters
# full-data cluster of flower 1: size 50; after removing Petal.Length, 49 stay
cat("flower-1 term after removing Petal.Length:", 1 - 49 / 50, "\n")

# The curves, like the course worksheet asks
png("stability_curves.png", width = 1500, height = 950, res = 120)
par(mfrow = c(2, 2), mar = c(4.2, 4.2, 3, 1.2))
m <- measures(stab); k <- 2:6
cols <- c(hierarchical = "blue", kmeans = "red", pam = "purple")
for (meas in c("APN", "AD", "ADM", "FOM")) {
  matplot(k, m[meas, , ], type = "b", pch = 19, col = cols[clmethods],
          lty = 1, lwd = 2, xlab = "clusters (k)", ylab = meas,
          main = paste(meas, "- lower is better"), xaxt = "n")
  axis(1, at = k)
  grid(col = "gray85", lty = 3)
  legend("topright", legend = clmethods, col = cols[clmethods],
         pch = 19, lty = 1, lwd = 2, bg = "white")
}
dev.off()
cat("curves saved to stability_curves.png\n")
