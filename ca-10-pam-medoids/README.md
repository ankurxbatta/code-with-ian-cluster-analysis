# CA-10 Assignment — PAM: Clustering Around Medoids

Try all five problems before looking at the solutions. One honest attempt beats a copied answer. You will need R (4.0 or newer) with the `cluster` package (`install.packages("cluster")`). Remember the big idea: PAM centers are REAL data points (medoids), which is why outliers cannot drag them around.

---

## Problem 1 — The Manhattan dissimilarity matrix

Four points measured on two columns:

| Point | x1 | x2 |
|-------|----|----|
| A | 5 | 3 |
| B | −1 | 1 |
| C | −4 | 4 |
| D | −3 | −2 |

(a) Compute the Manhattan distance between A and B, showing the two absolute-value steps. (Answer check: 8.)
(b) Compute the remaining five pairs (AC, AD, BC, BD, CD), showing each step.
(c) In one sentence: why does the worksheet use Manhattan distance here instead of Euclidean?

## Problem 2 — BUILD: initial medoids {A, B}

Take k = 2 with starting medoids A and B.

(a) Assign C to its closer medoid (compare the two distances). Do the same for D.
(b) PAM's cost is the sum of each point's distance to its own medoid. Compute the cost of {A, B}. (Answer check: 11.)
(c) In one sentence: why does a medoid pay zero?

## Problem 3 — SWAP: try B ↔ C

Trade medoid B for outsider C, so the trial medoids are {A, C}.

(a) Reassign B and D to their closer medoid (B is no longer a medoid, so it must pick).
(b) Recompute the cost for {A, C}. (Answer check: 13.)
(c) Keep or undo? State the rule PAM uses to decide.

## Problem 4 — SWAP: try B ↔ D

Trade medoid B for outsider D, so the trial medoids are {A, D}.

(a) Reassign B and C, then recompute the cost. (Answer check: 12.)
(b) Keep or undo?
(c) The worksheet says one round of swapping needs k × (n − k) cost calculations. With n = 4 and k = 2, how many is that, and which four swaps are they?

## Problem 5 — Robustness and the matrix trick

(a) In your own words: why is a medoid more robust to an outlier than a mean? (Hint: think about what an average does when one point moves far away, versus what the most-central real point does.)
(b) PAM accepts a precomputed dissimilarity matrix (`diss = TRUE`); k-means cannot. In one or two sentences, explain WHY the difference exists — what does k-means need that PAM does not?
(c) In R, run the 4-point example for real and confirm your hand answers:

```r
library(cluster)
A <- c(5, 3); B <- c(-1, 1); C <- c(-4, 4); D <- c(-3, -2)
mymat <- rbind(A, B, C, D)
pam4 <- pam(mymat, 2, metric = "manhattan")
pam4$medoids      # which points did R pick?
pam4$clustering   # which cluster does each point land in?
mydist <- dist(mymat, method = "manhattan")
pam(as.matrix(mydist), 2, diss = TRUE)$medoids  # same answer from the matrix alone?
```

Report the medoids and the clustering vector. Do they match your hand calculations?
