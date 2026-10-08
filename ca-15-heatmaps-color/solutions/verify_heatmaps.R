# verify_heatmaps.R - CA-15 assignment answer checks (real executed R).
# Run: Rscript verify_heatmaps.R
suppressPackageStartupMessages(library(RColorBrewer))
suppressPackageStartupMessages(library(gplots))
suppressPackageStartupMessages(library(dendextend))

df <- scale(mtcars)

cat("P2a dim(df):", dim(df), "(expect 32 11)\n")
cat("P2b range disp:", range(mtcars$disp), "\n")
cat("P2b range wt:", range(mtcars$wt), "\n")
cat("P3b colMeans (expect all 0):", unique(round(colMeans(df), 6)), "\n")
cat("P3b col sds (expect all 1):", unique(round(apply(df, 2, sd), 6)), "\n")
cat("P3c scaled disp range:", round(range(df[, "disp"]), 2), "\n")
cat("P3c scaled wt range:", round(range(df[, "wt"]), 2), "\n")

col <- colorRampPalette(brewer.pal(10, "RdYlBu"))(256)
cat("P4a length(col) (expect 256):", length(col), "\n")
cat("P4d rowside labels (expect 32):",
    length(rep(c("blue", "pink"), each = 16)), "\n")
cat("P4d colside labels (expect 11):",
    length(c(rep("purple", 5), rep("orange", 6))), "\n")
cat("bluered(100) length (expect 100):", length(bluered(100)), "\n")

rt <- table(cutree(hclust(dist(df)), k = 3))
cat("P5a row groups (expect 5 15 12):", rt, "\n")
ct <- table(cutree(hclust(dist(t(df))), k = 2))
cat("P5a column groups (expect 6 5):", ct, "\n")
cat("P5b row group 1 cars:\n")
print(rownames(mtcars)[cutree(hclust(dist(df)), k = 3) == 1])
cc <- cutree(hclust(dist(t(df))), k = 2)
cat("P5c column group 1:", paste(colnames(df)[cc == 1], collapse = ", "), "\n")
cat("P5c column group 2:", paste(colnames(df)[cc == 2], collapse = ", "), "\n")
cat("ALL CHECKS DONE\n")
