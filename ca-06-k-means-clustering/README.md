# CA-6 Assignment — K-means Clustering

Try all six problems before looking at the solutions. One honest attempt beats a copied answer. You will need R (4.0 or newer) for the R problems; the `factoextra` package is only needed if you want the plots.

---

## Problem 1 — A different start, by hand

The lesson's hand-run used x = 1, 2, 5, 6 (call them A, B, C, D), k = 2, starting centroids B(2) and C(5).

(a) Run MacQueen's k-means **by hand** with a different start: pick A(1) and D(6) as the initial centroids. Assign every point, recompute the centroids, reassign — what clusters and means do you get?
(b) In one or two sentences: your answer matches the lesson's (AB), (CD) with means 1.5 / 5.5. Does that mean random starts never matter? Explain.

## Problem 2 — WSS by hand, new data

Four new points on a line: 3, 4, 9, 10 (call them E, F, G, H). Use k = 2 with starting centroids F(4) and G(9).

(a) Run the hand-run: assign, recompute, reassign. Give the final clusters and their means.
(b) Compute the total within-cluster sum of squares (WSS) by hand, one cluster at a time.
(c) The grand mean of 3, 4, 9, 10 is 6.5. Compute total_SS (every point vs the grand mean), then between_SS = total_SS − total WSS, then between_SS / total_SS as a percentage. Is the separation better or worse than the lesson's 94.1%?

## Problem 3 — The notes' R check

Run the typed notes' R check yourself:

```r
data1 <- c(1, 2, 5, 6)
names(data1) <- c("A", "B", "C", "D")
kmeans(data1, 2, nstart = 25)
```

(a) Confirm the output: means 1.5 / 5.5, clustering vector 1 1 2 2, WSS 0.5 / 0.5, and between_SS / total_SS = 94.1%.
(b) Now run `set.seed(42); kmeans(data1, 2, nstart = 1)`. What do you get? In one sentence, explain why the notes still insist on nstart = 25 even though this toy example works with nstart = 1.

## Problem 4 — MacQueen's in 2-D (worksheet style)

Four points with two variables (X1, X2): A(5,3), B(−1,1), C(1,−2), D(−3,−2). Use MacQueen's k-means with k = 2, starting with **A and C** as the initial centres (so everyone gets the same answer).

(a) By hand, one point at a time: assign each point to its closest centre (compare squared Euclidean distances), and **update the centroid the moment a point moves** (MacQueen's rule). Then do a full reassign pass. Give the final clusters and centroids.
(b) Compute the total within-cluster sum of squares for your answer.
(c) Check yourself in R:

```r
A <- c(5,3); B <- c(-1,1); C <- c(1,-2); D <- c(-3,-2)
m <- rbind(A, B, C, D)
km <- kmeans(m, rbind(A, C), algorithm = "MacQueen")
km$cluster; km$centers; km$tot.withinss
```

Do the clusters, centroids, and total WSS match your hand work?

## Problem 5 — USArrests, the walkthrough's core

```r
data("USArrests")
df <- scale(USArrests)
set.seed(123)
km.res <- kmeans(df, 4, nstart = 25)
```

(a) From `print(km.res)`: what are the four cluster sizes, and what is between_SS / total_SS?
(b) Which cluster is Alabama in? Which is Alaska in? (Hint: `head(km.res$cluster, 4)`.)
(c) Run `aggregate(USArrests, by = list(cluster = km.res$cluster), mean)`. Which cluster has the highest mean Murder rate on the original scale, and what is that mean?

## Problem 6 — The three rules

(a) A friend has only a precomputed distance matrix between customers and wants to run `kmeans()` on it. What do you tell them, and why? Which episode-10 algorithm should they use instead?
(b) Their customer table has a "colour" column (red / blue / green). Can k-means use that column directly? Why not?
(c) In one sentence each: what do `nstart = 25` and `set.seed(123)` do for a `kmeans()` call?
