# Verify CA-17's numbers in real R (solutions for Problems 2-5).
# Run: Rscript verify_bakers.R   (needs the dendextend package)
library(dendextend)

# Worksheet 12 data: 5 objects
item1 <- c(0,9,3,6,11)
item2 <- c(9,0,7,5,10)
item3 <- c(3,7,0,9,2)
item4 <- c(6,5,9,0,8)
item5 <- c(11,10,2,8,0)
mydist <- as.dist(rbind(item1, item2, item3, item4, item5))

hc1 <- hclust(mydist, method = "average")
hc2 <- hclust(mydist, method = "ward.D2")
dend1 <- as.dendrogram(hc1)
dend2 <- as.dendrogram(hc2)

cat("Problem 3: cor_cophenetic =", cor_cophenetic(dend1, dend2), "\n")
cat("Problem 3: cor_bakers_gamma =", cor_bakers_gamma(dend1, dend2), "\n")

# Merge-rank helper: pairs merging at step s earn rank n - s.
# (First merge earns the highest rank; matches the worksheet convention.)
merge_ranks <- function(hc) {
  n <- nrow(hc$merge) + 1
  nm <- n - 1
  pairs <- combn(n, 2)
  r <- rep(NA, ncol(pairs))
  members <- vector("list", n + nm)
  for (i in 1:n) members[[i]] <- i
  for (s in 1:nm) {
    ab <- hc$merge[s, ]
    ma <- if (ab[1] < 0) members[[-ab[1]]] else members[[n + ab[1]]]
    mb <- if (ab[2] < 0) members[[-ab[2]]] else members[[n + ab[2]]]
    for (xx in ma) for (yy in mb) {
      lo <- min(xx, yy); hi <- max(xx, yy)
      r[which(pairs[1, ] == lo & pairs[2, ] == hi)] <- n - s
    }
    members[[n + s]] <- c(ma, mb)
  }
  r
}

cat("Problem 2: average merge ranks =", paste(merge_ranks(hc1), collapse = ","), "\n")
cat("Problem 2: ward.D2 merge ranks  =", paste(merge_ranks(hc2), collapse = ","), "\n")

# Problem 4: the Pearson-on-ranks trap
x <- c(1,2,1,2,1,3,1,1,4,1)
y <- c(2,1,2,1,1,3,1,1,4,1)
cat("Problem 4: cor(x,y) pearson =", cor(x, y), "\n")
cat("Problem 4: cor(x,y) spearman =", cor(x, y, method = "spearman"), "\n")

# Problem 5: outlier demo — object 6 at distance 100 from everything
m6 <- rbind(cbind(rbind(item1, item2, item3, item4, item5), c(100,100,100,100,100)),
            c(100,100,100,100,100,0))
d6 <- as.dist(m6)
g1 <- hclust(d6, method = "average")
g2 <- hclust(d6, method = "ward.D2")
cat("Problem 5: average heights =", paste(round(g1$height, 4), collapse = ", "), "\n")
cat("Problem 5: ward.D2 heights  =", paste(round(g2$height, 4), collapse = ", "), "\n")
cat("Problem 5: cophenetic with outlier =", cor(cophenetic(g1), cophenetic(g2)), "\n")
r1 <- merge_ranks(g1); r2 <- merge_ranks(g2)
cat("Problem 5: manual gamma with outlier =", cor(r1, r2, method = "spearman"), "\n")
