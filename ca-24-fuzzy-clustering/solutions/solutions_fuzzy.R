# CA-24 worked solutions - reproduces every number in solutions/README.md
# R 4.3.3, packages: cluster, factoextra. Run: Rscript solutions_fuzzy.R
library(cluster)
library(factoextra)

set.seed(123)
df <- scale(USArrests)            # standardize
res.fanny <- fanny(df, 2)        # fuzzy clustering, k = 2

cat("--- P2: membership head ---\n")
print(head(res.fanny$membership, 3))

cat("--- P3: row sums audit ---\n")
rs <- rowSums(res.fanny$membership)
cat("min:", min(rs), " max:", max(rs), "\n")

cat("--- P4: most torn states ---\n")
topm <- apply(res.fanny$membership, 1, max)
print(sort(topm)[1:3])
cat("Delaware row:", res.fanny$membership["Delaware", ], "\n")
cat("states with top share < 0.75:", sum(topm < 0.75), "\n")
cat("most confident:", names(which.max(topm)), max(topm), "\n")

cat("--- hard labels vs k-means ---\n")
print(table(res.fanny$clustering))
km <- kmeans(df, 2, nstart = 25)
print(table(km$cluster))

cat("--- P5: Dunn's partition coefficient ---\n")
print(res.fanny$coeff)
cat("mush floor 1/k =", 1/2, "\n")

cat("--- P6: plots ---\n")
png("plot_fuzzy_cluster.png", width = 900, height = 600)
print(fviz_cluster(res.fanny, ellipse.type = "norm", repel = TRUE,
                   palette = "jco", ggtheme = theme_minimal(),
                   legend = "right"))
dev.off()
png("plot_fuzzy_silhouette.png", width = 900, height = 600)
print(fviz_silhouette(res.fanny, palette = "jco",
                      ggtheme = theme_minimal()))
dev.off()
cat("plots written\n")
