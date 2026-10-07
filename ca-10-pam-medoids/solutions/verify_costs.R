# CA-10 solutions: verify the hand-worked PAM example in real R.
# Run: Rscript verify_costs.R
library(cluster)

A <- c(5, 3); B <- c(-1, 1); C <- c(-4, 4); D <- c(-3, -2)
mymat <- rbind(A, B, C, D)
mydist <- dist(mymat, method = "manhattan")
cat("Manhattan distance matrix:\n"); print(mydist)

# PAM on raw data with Manhattan metric
pam4 <- pam(mymat, 2, diss = FALSE, metric = "manhattan")
cat("\nmedoids (expect A and B):\n"); print(pam4$medoids)
cat("\nclustering (expect 1 2 2 2):\n"); print(pam4$clustering)

# PAM from the precomputed matrix alone (the diss = TRUE trick)
pam4d <- pam(as.matrix(mydist), 2, diss = TRUE)
cat("\ndiss=TRUE medoids (expect A and B):\n"); print(pam4d$medoids)

# Hand-check the swap costs from Problems 3-4
cost <- function(meds) {
  others <- setdiff(c("A", "B", "C", "D"), meds)
  m <- as.matrix(mydist)
  sum(sapply(others, function(p) min(m[p, meds])))
}
cat("\nHand-check costs:\n")
cat("Cost{A,B} (expect 11):", cost(c("A", "B")), "\n")
cat("Cost{A,C} (expect 13):", cost(c("A", "C")), "\n")
cat("Cost{A,D} (expect 12):", cost(c("A", "D")), "\n")
cat("Cost{B,C} (expect 13):", cost(c("B", "C")), "\n")
cat("Cost{B,D} (expect 14):", cost(c("B", "D")), "\n")
