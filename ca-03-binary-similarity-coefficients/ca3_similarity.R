# CA-3 — Binary similarity coefficients in R
# Pairs with the CA-3 lesson (Binary Similarity Coefficients | Code With Ian).
# Every number here also appears on screen in the episode, computed the same way.

library(proxy)

# Problem 1: two shoppers, five yes/no products
M <- rbind(C = c(1, 1, 0, 1, 0),
           D = c(0, 1, 1, 1, 0))

cat("=== Three coefficients (proxy::simil) ===\n")
cat("Dice:            ", simil(M, method = "Dice"), "\n")
cat("Jaccard:         ", simil(M, method = "Jaccard"), "\n")
cat("Simple matching: ", simil(M, method = "simple matching"), "\n")

cat("\n=== Jaccard dissimilarity shortcut ===\n")
cat("dist(method=binary):", dist(M, method = "binary"), "\n")
cat("(= 1 - Jaccard similarity =", 1 - as.numeric(simil(M, method = "Jaccard")), ")\n")

cat("\n=== Hand counts: a=2, b=1, c=1, d=1 ===\n")
cat("Dice by hand:   2*2/(2*2+1+1) =", 2 * 2 / (2 * 2 + 1 + 1), "\n")
cat("Jaccard by hand: 2/(2+1+1)    =", 2 / (2 + 1 + 1), "\n")
cat("SM by hand:     (2+1)/5       =", (2 + 1) / 5, "\n")
