# CA-12 solution verification: confirms the assignment's hand-worked answers.
# Run: Rscript verify_hierarchical.R

# Problems 2-3: A,B,C,D matrix
m <- matrix(c(0,1,5,6,
              1,0,4,7,
              5,4,0,2,
              6,7,2,0), nrow = 4, byrow = TRUE,
            dimnames = list(c("A","B","C","D"), c("A","B","C","D")))
d <- as.dist(m)
hs <- hclust(d, method = "single")$height
hc <- hclust(d, method = "complete")$height
stopifnot(isTRUE(all.equal(hs, c(1, 2, 4))))
stopifnot(isTRUE(all.equal(hc, c(1, 2, 7))))
cat("Problems 2-3 OK: single heights 1,2,4; complete heights 1,2,7\n")

# Problem 4: tie matrix P,Q,R
m2 <- matrix(c(0,3,3,
               3,0,5,
               3,5,0), nrow = 3, byrow = TRUE,
             dimnames = list(c("P","Q","R"), c("P","Q","R")))
ht <- hclust(as.dist(m2), method = "single")$height
stopifnot(isTRUE(all.equal(ht, c(3, 3))))
cat("Problem 4 OK: tie heights 3,3\n")

# Problems 5-6: USArrests complete linkage
data("USArrests")
df <- scale(USArrests)
res.dist <- dist(df, method = "euclidean")
res.hc <- hclust(d = res.dist, method = "complete")
stopifnot(isTRUE(all.equal(round(res.hc$height[1:3], 3), c(0.206, 0.350, 0.429))))
stopifnot(isTRUE(all.equal(round(tail(res.hc$height, 1), 3), 6.077)))
first2 <- rownames(df)[abs(res.hc$merge[1, ])]
stopifnot(setequal(first2, c("Iowa", "New Hampshire")))
grp <- cutree(res.hc, k = 4)
stopifnot(isTRUE(all.equal(as.integer(table(grp)), c(8L, 11L, 21L, 10L))))
stopifnot(sum(table(grp)) == 50)
cl1 <- rownames(df)[grp == 1]
stopifnot(length(cl1) == 8)
cat("Problems 5-6 OK: heights 0.206,0.350,0.429 / 6.077; Iowa+New Hampshire first;\n")
cat("  cutree k=4 sizes 8,11,21,10; cluster 1 has 8 states\n")
cat("ALL CHECKS PASSED\n")
