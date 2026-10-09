# CA-23 Assignment — DBSCAN: Density-Based Clustering

Solve these **before** peeking at `solutions/`. All problems come from the
episode's hand-worked exercise and R demos. You need R with the `dbscan`,
`fpc`, and `factoextra` packages.

## Problem 1 — Core, border, noise in your own words

In plain English (no jargon), explain the difference between a **core
point**, a **border point**, and a **noise point**. Your explanation must
mention the reach (eps) and the minimum count (minPts), and must say what
happens to each kind of point at the end (which cluster does it join, if
any?).

## Problem 2 — Hand-label the 19-point grid

The points below sit on a grid. Run DBSCAN **by hand** with reach
`eps = 1` and minimum count `MinPts = 3` (the count **includes** the point
itself). Label every point **C** (core), **B** (border), or **O** (noise).

```
x: 1 2 2 3 3 3 4 4 5 6 7 7 7 8 8 8 9 9 9
y: 6 5 4 5 4 3 4 3 2 1 6 5 4 6 5 4 6 5 4
```

Points 1..19 in order: (1,6), (2,5), (2,4), (3,5), (3,4), (3,3), (4,4),
(4,3), (5,2), (6,1), (7,6), (7,5), (7,4), (8,6), (8,5), (8,4), (9,6), (9,5),
(9,4).

Hints: use straight-line (Euclidean) distance. A diagonal neighbor is
√2 ≈ 1.41 away — farther than the reach of 1. How many clusters will
DBSCAN find? Which points end up as noise?

## Problem 3 — The loneliest point

For the same 19 points, compute each point's distance to its **second
nearest neighbor**, and find the largest of those 19 distances. Give the
answer to 4 decimal places. Which point is the loneliest, and why does its
second-nearest distance equal √8?

## Problem 4 — Moons: k-means vs DBSCAN (R)

```r
library(dbscan)
data("moons")
xy <- as.data.frame(moons)[, 1:2]
newmoons <- xy[xy$Y < 1.5, ]
```

(a) Run `kmeans(newmoons, 2, nstart = 25)` with `set.seed(123)`. Report the
cluster sizes. Plot the result with `factoextra::fviz_cluster()`. Describe
in words what went wrong.

(b) Run `dbscan::dbscan(newmoons, eps = 0.25, minPts = 3)`. Report the
cluster sizes. Plot the result. Describe what DBSCAN found that k-means
missed.

(c) Now run `dbscan::dbscan(newmoons, eps = 0.1, minPts = 5)`. How many
points are labeled noise? Explain in one sentence why shrinking the reach
did this.

## Problem 5 — Choose eps with the k-distance plot (R)

```r
library(factoextra)
data("multishapes")
df <- multishapes[, 1:2]
```

(a) Draw `dbscan::kNNdistplot(df, k = 5)` and add `abline(h = 0.15, lty = 2)`.
In plain English, explain what each point on the curve represents and why
the "elbow" of the curve is a good eps choice.

(b) Run `fpc::dbscan(df, eps = 0.15, MinPts = 5)` with `set.seed(123)` and
`print()` the result. Fill in: how many noise points? How many clusters?
How many points in each cluster? How many of those are core (seed) vs
border?

(c) Compare with `kmeans(df, 5, nstart = 25)` (seed 123): report the five
cluster sizes, and explain in two sentences why k-means fails on this data
while DBSCAN succeeds.

## Problem 6 — The price of density

In two or three sentences, explain DBSCAN's main weakness: what happens
when the reach is too small, what happens when it is too large, and why a
dataset with regions of very different density is hard for a single eps
value.
