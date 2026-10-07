# CA-8 R script — elbow + silhouette (supports Problems 1 and 4)
# Run each block and compare with your hand calculations.

suppressMessages(library(factoextra))
suppressMessages(library(cluster))

## ---------- Problem 1: elbow drops from a WSS table ----------
wss <- c(210.5, 118.2, 84.6, 61.3, 55.8, 51.2)
drops <- -diff(wss)
print(round(drops, 1))   # expect: 92.3 33.6 23.3 5.5 4.6 -> elbow at k = 4

## ---------- Problem 2: Q7-style hand check ----------
# Cluster 1 = {P=2, Q=4}, Cluster 2 = {R=9, S=11}
sil_1d <- function(x, own, others) {
  a <- mean(abs(x - setdiff(own, x)))
  b <- min(sapply(others, function(cl) mean(abs(x - cl))))
  (b - a) / max(a, b)
}
pts <- c(P = 2, Q = 4, R = 9, S = 11)
c1 <- c(2, 4); c2 <- c(9, 11)
for (nm in names(pts)) {
  own <- if (pts[[nm]] %in% c1) c1 else c2
  oth <- if (pts[[nm]] %in% c1) list(c2) else list(c1)
  cat(nm, round(sil_1d(pts[[nm]], own, oth), 3), "\n")
}
# expect: P 0.75, Q 0.667, R 0.667, S 0.75 ; average 0.709

## ---------- Problem 4: elbow + silhouette on scaled iris ----------
df <- scale(iris[, 1:4])
set.seed(123)

# elbow: total WSS vs k
fviz_nbclust(df, kmeans, method = "wss", nstart = 25) +
  geom_vline(xintercept = 3, linetype = 2) +
  labs(subtitle = "Elbow method (scaled iris)")

# silhouette: average silhouette width vs k (PAM)
fviz_nbclust(df, pam, method = "silhouette") +
  labs(subtitle = "Average silhouette width (scaled iris)")

# the numbers behind the plots
wss_iris <- sapply(1:10, function(k) kmeans(df, k, nstart = 25)$tot.withinss)
cat("drops:", paste(round(-diff(wss_iris), 1), collapse = ", "), "\n")
avg_sil <- sapply(2:10, function(k) pam(df, k)$silinfo$avg.width)
print(round(avg_sil, 4))          # highest at k = 2
cat("rule picks k =", which.max(avg_sil) + 1, "\n")
