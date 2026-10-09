# CA-25 worked solutions script - reproduces every number in solutions/README.md.
# R 4.3.3, mclust 6.1.3, MASS. Fixed seed 42 everywhere.
library(mclust)
data(diabetes, package = "mclust")
df <- scale(diabetes[, -1])
set.seed(42)
mc <- Mclust(df)

cat("== Problem 2: summary ==\n")
print(summary(mc))

cat("\n== Problem 3: BIC top 5 ==\n")
b <- mc$BIC
ord_all <- order(as.vector(b), decreasing = TRUE)
pos <- arrayInd(ord_all, dim(b))
for (i in 1:5) cat(sprintf("rank %d: BIC %.2f  G=%s model=%s\n", i,
    b[pos[i,1], pos[i,2]], rownames(b)[pos[i,1]], colnames(b)[pos[i,2]]))

cat("\n== Problem 4: head(mc$z) and the rows-sum-to-1 audit ==\n")
print(round(head(mc$z, 3), 4))
rs <- rowSums(mc$z)
cat("min(rs) =", min(rs), " max(rs) =", max(rs), "\n")

cat("\n== Problem 5: most uncertain rows ==\n")
ord <- order(mc$uncertainty, decreasing = TRUE)
cat("top 5 uncertainties:\n"); print(round(head(mc$uncertainty[ord], 5), 3))
cat("row 59 posterior probabilities:\n"); print(round(mc$z[ord[1], ], 3))
cat("mean(mc$uncertainty) =", round(mean(mc$uncertainty), 3), "\n")

cat("\n== Problem 6: confusion table vs truth ==\n")
cat("true class sizes:\n"); print(table(diabetes$class))
cat("confusion:\n"); print(table(mc$classification, diabetes$class))
