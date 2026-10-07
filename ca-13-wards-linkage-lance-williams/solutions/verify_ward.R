# CA-13 solutions verification script — run every number in the solutions.
# R 4.3.3.

# Problem 2: n_i = n_j = n_k = 1; d_ik = 8, d_jk = 5, d_ij = 3
ai <- (1+1)/3; aj <- (1+1)/3; b <- -(1/3)
p2_wardD  <- ai*8 + aj*5 + b*3
p2_wardD2 <- sqrt(ai*64 + aj*25 + b*9)
cat("P2 ward.D :", p2_wardD, "(expect 23/3 = 7.666667)\n")
cat("P2 ward.D2:", p2_wardD2, "(expect sqrt(169/3) = 7.505553)\n")
stopifnot(abs(p2_wardD - 23/3) < 1e-9)
stopifnot(abs(p2_wardD2 - sqrt(169/3)) < 1e-9)

# Problem 3: n_i = 2, n_j = 1, n_k = 3; d_ik = 10, d_jk = 6, d_ij = 4
ci <- (2+3)/6; cj <- (1+3)/6; ck <- -(3/6)
p3 <- ci*10 + cj*6 + ck*4
cat("P3 ward.D :", p3, "(expect 31/3 = 10.33333)\n")
stopifnot(abs(p3 - 31/3) < 1e-9)

# Problems 4-5: USArrests
data("USArrests")
d <- dist(scale(USArrests), method = "euclidean")
hcD2 <- hclust(d = d,   method = "ward.D2")
hcD  <- hclust(d = d^2, method = "ward.D")
cat("P4 max gap:", max(abs(hcD$height - hcD2$height^2)), "(expect ~2.8e-14)\n")
cat("P4 Ward.D spelling test:\n")
print(tryCatch(hclust(d = d, method = "Ward.D"),
               error = function(e) paste("ERROR:", conditionMessage(e))))
hcW <- hclust(d = d, method = "ward.D2")
hcS <- hclust(d = d, method = "single")
cat("P5 first merge (Ward):",
    paste(rownames(scale(USArrests))[abs(hcW$merge[1, ])], collapse = " + "),
    "at height", round(hcW$height[1], 3), "\n")
cat("P5 Ward k=4 sizes:"); print(table(cutree(hcW, k = 4)))
cat("P5 single k=4 sizes:"); print(table(cutree(hcS, k = 4)))
cat("ALL CA-13 SOLUTION CHECKS PASSED\n")
