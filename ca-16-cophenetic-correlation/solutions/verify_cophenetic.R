# CA-16 verify_cophenetic.R — runs every R computation in the solutions.
# R 4.3.3. Problems 4-5 need the dendextend package.
# Run: Rscript verify_cophenetic.R

## Problem 2 — WS11 example
data <- c(7, 10, 22, 24)
d <- dist(data)
cat("--- dist(data) ---\n"); print(d)
hc <- hclust(d, method = "ward.D")
cat("--- hc$merge ---\n"); print(hc$merge)
cat("--- hc$height ---\n"); print(round(hc$height, 4))
coph <- cophenetic(hc)
cat("--- cophenetic(hc) ---\n"); print(round(coph, 1))
cat("--- cor(d, coph) ---\n"); print(round(cor(d, coph), 4))

## Problem 4 — linkage shootout
s_single   <- cor(d, cophenetic(hclust(d, method = "single")))
s_average  <- cor(d, cophenetic(hclust(d, method = "average")))
s_complete <- cor(d, cophenetic(hclust(d, method = "complete")))
s_ward     <- cor(d, cophenetic(hclust(d, method = "ward.D")))
cat("--- linkage shootout (ward.D, single, average, complete) ---\n")
print(round(c(s_ward, s_single, s_average, s_complete), 4))

## Problem 5 — two trees (needs dendextend)
library(dendextend)
df <- scale(USArrests)
set.seed(123)
df <- df[sample(1:50, 10), ]
hc1 <- hclust(dist(df), method = "average")
hc2 <- hclust(dist(df), method = "ward.D2")
dend1 <- as.dendrogram(hc1)
dend2 <- as.dendrogram(hc2)
cat("--- tree 1 (average) vs data ---\n")
print(round(cor(dist(df), cophenetic(hc1)), 4))
cat("--- tree 2 (ward.D2) vs data ---\n")
print(round(cor(dist(df), cophenetic(hc2)), 4))
cat("--- tree vs tree: cor_cophenetic ---\n")
print(round(cor_cophenetic(dend1, dend2), 4))
dend_list <- untangle(dendlist(dend1, dend2), method = "step1side")
cat("--- entanglement (after untangle) ---\n")
print(entanglement(dend_list))
