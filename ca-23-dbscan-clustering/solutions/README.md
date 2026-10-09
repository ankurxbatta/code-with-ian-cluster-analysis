# CA-23 Solutions — DBSCAN: Density-Based Clustering

## Problem 1 — Core, border, noise

- **Core point:** a busy spot — at least `minPts` points sit within its
  reach (eps), counting itself. Core points are the heart of a cluster;
  clusters grow by chaining core points together.
- **Border point:** a quiet spot next to a busy one — it has fewer than
  `minPts` neighbors of its own, but a core point is within its reach. It
  joins that core point's cluster.
- **Noise point:** neither — too few neighbors and no core point nearby. It
  gets label 0 and is not forced into any cluster.

## Problem 2 — Hand-label the 19-point grid

Reach = 1, so only horizontal/vertical neighbors count (diagonals are
√2 ≈ 1.41 > 1). Minimum count = 3 including the point itself.

- **Point 1 (1,6):** only itself in reach → 1 < 3 → **O (noise)**.
- **Points 2–8 (left crowd):** e.g. point 2 (2,5) reaches itself, (2,4),
  (3,5) = 3 → **C**; point 5 (3,4) reaches itself, (2,4), (3,5), (3,3),
  (4,4) = 5 → **C**. All seven are core → **cluster 1**.
- **Points 9 (5,2), 10 (6,1):** each reaches only itself (the other is
  √2 away) → **O (noise)** both.
- **Points 11–19 (right crowd):** every point reaches at least itself + 2
  grid neighbors = 3 → all core → **cluster 2**.

**Answer:** 2 clusters (7 points + 9 points), 3 noise points (1, 9, 10),
no border points. Verified by `fpc::dbscan(wdf, eps = 1, MinPts = 3)`:

```
dbscan Pts=19 MinPts=3 eps=1
       0 1 2
border 3 0 0
seed   0 7 9
total  3 7 9
```

## Problem 3 — The loneliest point

Point 10 at (6,1): nearest neighbor is point 9 (5,2) at √2 ≈ 1.4142;
second nearest is point 8 (4,3) at √(4+4) = √8 ≈ **2.8284**. That is the
largest second-nearest-neighbor distance of all 19 points. Verified:

```r
> max(dbscan::kNNdist(wdf, k = 2))
[1] 2.828427
> sqrt(8)
[1] 2.828427
```

## Problem 4 — Moons: k-means vs DBSCAN (R)

(a) `kmeans(newmoons, 2, nstart = 25)` → cluster sizes **25/25**. It cuts
**each** moon in half (left halves vs right halves), because k-means only
draws round balls around centers.

(b) `dbscan::dbscan(newmoons, eps = 0.25, minPts = 3)` → clusters **1, 2**
sizes **25/25** — two clean moons, not a single point forced. DBSCAN
followed the shape; k-means could not.

(c) `eps = 0.1, minPts = 5` → **all 50 points labeled noise, 0 clusters**.
The reach is too small: no point can see 5 neighbors within 0.1, so every
point fails the core test.

## Problem 5 — Choose eps with the k-distance plot (R)

(a) Each point on the curve is the distance from one data point to its
5th nearest neighbor, sorted smallest to largest. Points in crowds have
close 5th neighbors (curve stays low); noise points have far ones (curve
spikes). The elbow — where the curve starts climbing steeply — separates
crowd distances from noise distances, so it is the natural eps choice.

(b) `fpc::dbscan(df, eps = 0.15, MinPts = 5)`, seed 123:

```
dbscan Pts=1100 MinPts=5 eps=0.15
        0   1   2   3  4  5
border 31  24   1   5  7  1
seed    0 386 404  99 92 50
total  31 410 405 104 99 51
```

**31 noise points**, **5 clusters** (410, 405, 104, 99, 51 points; core
counts 386, 404, 99, 92, 50; border counts 24, 1, 5, 7, 1).

(c) `kmeans(df, 5, nstart = 25)` → sizes **60, 210, 261, 275, 294**. K-means
chops the crescents and draws balls through the circles: it assumes round
clusters around centers, but the shapes are moons, blobs, and rings.
DBSCAN chains core points wherever the crowd is thick, so it follows the
true shapes — and honestly labels the 31 stragglers as noise instead of
forcing them in.

## Problem 6 — The price of density

If eps is too small, even genuine clusters look sparse and dissolve into
noise (all 50 moons became noise at eps = 0.1). If eps is too large, dense
clusters merge into one. A dataset with regions of very different density
needs a small eps for the sparse parts and a large eps for the dense
parts — one eps value cannot fit both at once.

All numbers above were produced by the R scripts in this folder
(`solutions_dbscan.R`, run under R 4.3.3).
