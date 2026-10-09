## CA-23 solutions: every number in solutions/README.md comes from this script.
## Run with: /usr/bin/Rscript solutions_dbscan.R
suppressPackageStartupMessages({
  library(dbscan); library(fpc); library(factoextra)
})

cat("=== Problems 2-3: 19-point hand exercise ===\n")
x <- c(1,2,2,3,3,3,4,4,5,6,7,7,7,8,8,8,9,9,9)
y <- c(6,5,4,5,4,3,4,3,2,1,6,5,4,6,5,4,6,5,4)
wdf <- data.frame(x, y)
dbw <- fpc::dbscan(wdf, eps = 1, MinPts = 3)
print(dbw)
cat("labels:", paste(dbw$cluster, collapse = " "), "\n")
cat("largest 2-NN dist:", max(dbscan::kNNdist(wdf, k = 2)), "\n")
cat("sqrt(8):", sqrt(8), "\n")

cat("\n=== Problem 4: moons ===\n")
data("moons")
xy <- as.data.frame(moons)[, 1:2]
newmoons <- xy[xy$Y < 1.5, ]
cat("newmoons n:", nrow(newmoons), "\n")
set.seed(123)
kmm <- kmeans(newmoons, 2, nstart = 25)
cat("kmeans sizes:", paste(table(kmm$cluster), collapse = "/"), "\n")
dbm <- dbscan::dbscan(newmoons, eps = 0.25, minPts = 3)
cat("dbscan eps=0.25 minPts=3:", paste(names(table(dbm$cluster)), collapse = ","),
    "sizes:", paste(table(dbm$cluster), collapse = "/"), "\n")
dbm_lo <- dbscan::dbscan(newmoons, eps = 0.1, minPts = 5)
cat("dbscan eps=0.1 minPts=5: noise =", sum(dbm_lo$cluster == 0),
    "of", nrow(newmoons), "\n")

cat("\n=== Problem 5: multishapes ===\n")
data("multishapes")
df <- multishapes[, 1:2]
cat("n:", nrow(df), "\n")
set.seed(123)
km <- kmeans(df, 5, nstart = 25)
cat("kmeans sizes:", paste(sort(table(km$cluster)), collapse = "/"), "\n")
set.seed(123)
db <- fpc::dbscan(df, eps = 0.15, MinPts = 5)
print(db)
cat("DONE\n")
