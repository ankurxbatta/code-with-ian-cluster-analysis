# Verify the CA-18 episode numbers in R (needs the pvclust package).
# Reproduces: dim(lung) = 916 x 73, 30 sampled columns, nboot = 100,
# the edges table, and the three AU >= 95% rectangles (edges 7, 23, 25).
library(pvclust)

data("lung")
stopifnot(identical(dim(lung), c(916L, 73L)))
cat("dim(lung):", dim(lung), "\n")

set.seed(123)
ss <- sample(1:73, 30)
df <- lung[, ss]
stopifnot(identical(dim(df), c(916L, 30L)))
cat("dim(df):", dim(df), "\n")

res.pv <- pvclust(df, method.dist = "cor", method.hclust = "average",
                  nboot = 100)

e <- res.pv$edges
show <- function(edge) {
  cat(sprintf("edge %d: AU = %.1f%%, BP = %.1f%%\n",
              edge, 100 * e$au[edge], 100 * e$bp[edge]))
}
for (edge in c(7, 15, 23, 25, 28)) show(edge)

picked <- pvpick(res.pv, alpha = 0.95)$edges
cat("pvpick edges (AU >= 95%):", picked, "\n")
stopifnot(setequal(picked, c(7, 23, 25)))

png("verify_pvclust_tree.png", width = 1200, height = 800, res = 120)
plot(res.pv, hang = -1, cex = 0.7)
pvrect(res.pv, alpha = 0.95)
dev.off()
cat("plot saved to verify_pvclust_tree.png\n")
cat("ALL CHECKS PASSED\n")
