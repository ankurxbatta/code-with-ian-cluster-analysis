# CA-14 verification script: hierarchical k-means demo (real executed R)
# Produces every number used in the CA-14 assignment and its solutions.
suppressPackageStartupMessages(library(factoextra))

df <- scale(USArrests)
res.hk <- hkmeans(df, 4)

cat("== names(res.hk) ==\n"); print(names(res.hk))
cat("== final sizes ==\n"); print(res.hk$size)
cat("== iter / tot.withinss / betweenss ==\n")
cat("iter:", res.hk$iter, "\n")
cat("tot.withinss:", res.hk$tot.withinss, "\n")
cat("betweenss:", res.hk$betweenss, "\n")

init.clust <- cutree(res.hk$hclust, k = 4)
cat("== initial cut ==\n"); print(table(init.clust))
cat("== final ==\n"); print(table(res.hk$cluster))

# align initial labels to final labels by majority vote, list movers
al <- sapply(1:4, function(g) {
  tab <- table(res.hk$cluster[init.clust == g])
  as.integer(names(tab)[which.max(tab)])
})
remap <- setNames(al, 1:4)
init.aligned <- as.integer(remap[as.character(init.clust)])
moved <- rownames(df)[init.aligned != res.hk$cluster]
cat("== movers (", length(moved), ") ==\n", paste(moved, collapse = ", "), "\n", sep = "")

# reproducibility demo
set.seed(1); km1 <- kmeans(df, 4, nstart = 1)
set.seed(2); km2 <- kmeans(df, 4, nstart = 1)
cat("== kmeans try 1 tot.withinss:", km1$tot.withinss, "==\n")
cat("== kmeans try 2 tot.withinss:", km2$tot.withinss, "==\n")
res.hk2 <- hkmeans(df, 4)
cat("== hkmeans identical across runs:", identical(res.hk$cluster, res.hk2$cluster), "==\n")
cat("== hkmeans defaults ==\n"); print(args(hkmeans))
