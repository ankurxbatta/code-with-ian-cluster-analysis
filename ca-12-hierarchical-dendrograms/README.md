# CA-12 Assignment — Hierarchical Clustering & Dendrograms

Try all six problems before looking at the solutions. One honest attempt beats a copied answer. You will need R (4.0 or newer). Remember the big ideas: agglomerative clustering merges the most similar pair first and keeps merging until one cluster holds everything; the dendrogram draws every merge with heights on the y-axis; a linkage is the rule for the distance between two clusters.

---

## Problem 1 — Reading a dendrogram with a ruler

A single-linkage run on five objects produced these merges: (3,5) at height 2, then 1 joins (3,5) at height 3, then (2,4) merge at height 5, then everything joins at height 6.

(a) Draw the dendrogram (neatly, heights to scale, y-axis labeled "Distance"). What is the leaf order along the bottom?
(b) Lay a ruler horizontally at height 4. Which objects are already joined into one cluster below the ruler, and which are still separate?
(c) You want exactly 2 clusters. Between which two heights should you cut? List the members of each cluster.
(d) You want exactly 3 clusters. Where do you cut, and who is in each cluster?

## Problem 2 — Single linkage by hand

Four objects A, B, C, D have this distance matrix:

|     | A | B | C | D |
|-----|---|---|---|---|
| A   | 0 | 1 | 5 | 6 |
| B   | 1 | 0 | 4 | 7 |
| C   | 5 | 4 | 0 | 2 |
| D   | 6 | 7 | 2 | 0 |

Perform single-linkage agglomerative clustering by hand.

(a) Which pair merges first, and at what height? (Answer check: height 1.)
(b) After the first merge, update the matrix with MIN. Show each min() calculation explicitly.
(c) Give every merge with its height, in order. (Answer check: the heights are 1, 2, 4.)
(d) What is the leaf order of your dendrogram?

## Problem 3 — Same matrix, complete linkage

Use the same A–B–C–D matrix from Problem 2, but now with complete linkage (MAX updates).

(a) Which pair merges first, and at what height? Why is it the same as in Problem 2?
(b) After the first merge, update the matrix with MAX. Show each max() calculation explicitly.
(c) Give every merge with its height, in order. (Answer check: the heights are 1, 2, 7.)
(d) In one or two sentences: compare the two trees. Which linkage merged everything at a taller height, and what does that tell you about the "personality" of complete linkage?

## Problem 4 — The tie rule

Three objects P, Q, R have distances: d(P,Q) = 3, d(P,R) = 3, d(Q,R) = 5. Run single linkage by hand.

(a) You will find a tie at the very first step. Which two merges tie?
(b) Pick one of them (say which!) and finish the clustering. Give every merge with its height.
(c) Now suppose you had picked the other tied merge instead. Would the final merge height change? Would the tree look different? (One or two sentences.)

## Problem 5 — Real R: dist → hclust → plot

Run this for real (the episode's exact workflow on the lecture dataset):

```r
data("USArrests")
df <- scale(USArrests)
res.dist <- dist(df, method = "euclidean")
res.hc <- hclust(d = res.dist, method = "complete")
plot(res.hc)
res.hc$height
```

(a) What are the first three merge heights? What is the final (largest) merge height?
(b) Run the same hclust call with method = "single" and method = "average". Do the first three heights match the complete-linkage ones? Why?
(c) Which two states merge first? (Hint: `rownames(df)[abs(res.hc$merge[1, ])]`.) What is their merge height?
(d) In one sentence: why does `hclust` want a *distance matrix* as its `d` argument, not the raw data?

## Problem 6 — Cutting the tree

Continuing with your `res.hc` (complete linkage) from Problem 5:

```r
grp <- cutree(res.hc, k = 4)
table(grp)
rownames(df)[grp == 1]
```

(a) Report the four group sizes. Do they add up to 50?
(b) List the members of cluster 1. (Answer check: 8 states.)
(c) In one or two sentences: what does it mean to "choose k after the fact," and why can hierarchical clustering do this while k-means cannot?
