# CA-14 Solutions — Hierarchical K-means: The Best of Both

Worked solutions for the CA-14 assignment. The R below is real executed R (R 4.3.3, factoextra); every number printed here came from an actual session. Compare with your own run — your numbers should match exactly, because `hkmeans` is deterministic.

---

## Problem 1 — The hybrid in plain English

(a) Stage 1: grow the hierarchical tree. Stage 2: cut the tree at k for an initial partition. Stage 3: hand that partition to k-means, which refines it.
(b) A local minimum is a pretty good answer that blocks the best one: the k-means loop settles somewhere decent and stops improving because every small move looks worse. It is k-means' famous weakness because the loop starts from random centers — a bad random start lands the loop in a bad valley, and it never climbs out.
(c) Deterministic means same data, same tree, every time — no dice involved. The cut is a better start than random centers because the tree already studied the data's structure (which points are close, which merges are natural), while random centers know nothing.
(d) K-means moves points between groups and updates centroids until nothing improves. A few points that the tree grouped together may fit a neighboring group better once centroids are recomputed — so the final partition shifts slightly away from the initial cut.

## Problem 2 — Real R: the hkmeans call

```r
library(factoextra)
df <- scale(USArrests)
res.hk <- hkmeans(df, 4)
names(res.hk)
#  [1] "cluster"      "centers"      "totss"        "withinss"
#  [5] "tot.withinss" "betweenss"    "size"         "iter"
#  [9] "ifault"       "data"         "hclust"
res.hk$size
# [1]  8 13 16 13
res.hk$iter
# [1] 2
res.hk$tot.withinss
# [1] 56.40317
```

(a) 11 pieces. Any five, e.g. `cluster`, `centers`, `size`, `iter`, `tot.withinss`.
(b) 8, 13, 16, 13. `size` counts the number of states in each final group (8 + 13 + 16 + 13 = 50).
(c) `iter` is 2. K-means ran 2 refinement rounds: starting from the tree's cut, it moved points and updated centroids twice before nothing changed.
(d) `tot.withinss` is 56.40317 (about 56.40). It measures the total within-cluster scatter — the tightness score. Lower means tighter clusters.

## Problem 3 — The cut proposes, k-means improves

```r
table(cutree(res.hk$hclust, k = 4))
#  1  2  3  4
#  7 12 19 12
table(res.hk$cluster)
#  1  2  3  4
#  8 13 16 13
```

(a) Yes — every group's headcount changed: 7→8, 12→13, 19→16, 12→13.
(b) 3 states switched groups.
(c) Arkansas, Kentucky, and Missouri. (Computed by aligning each initial group to the final group it overlaps most, then listing the states whose label changed — see `verify_hkmeans.R`.)
(d) It confirms the note. The initial cut and the final answer are close but not identical — k-means improved the cut by moving three states to tighter homes.

## Problem 4 — The reproducibility demo

```r
set.seed(1); km1 <- kmeans(df, 4, nstart = 1)
set.seed(2); km2 <- kmeans(df, 4, nstart = 1)
km1$tot.withinss  # 69.86858
km2$tot.withinss  # 56.40317
```

(a) Try 1: 69.86858 (about 69.87). Try 2: 56.40317 (about 56.40).
(b) Try 1 landed in the local minimum trap. You can tell because its tightness score (69.87) is clearly worse than try 2's (56.40) — same data, same k, but the worse random start settled for a worse answer.
(c) Yes. Both `hkmeans(df, 4)` runs give `tot.withinss` = 56.40317 and identical cluster assignments — fully deterministic, no dice.
(d) Hierarchical k-means beats plain k-means when you want the best answer without the lottery: one deterministic smart start from the tree replaces many random restarts, the result is reproducible across runs, and the refinement only needed 2 rounds here. Plain k-means with a single start can silently land in a local minimum (69.87 vs 56.40), and the standard fix costs 25 runs.

## Problem 5 — Think: limits and defaults

(a) No — growing the full tree on a million rows costs too much compute and the tree would be unreadable. Use CLARA (episode 11): PAM on samples, designed for large data.
(b) `args(hkmeans)` shows `hc.method = "ward.D2"` and `hc.metric = "euclidean"` — Ward's method with Euclidean distance, the industry pick from episode 13.
(c) Stage 2's visual is the dendrogram with the four cut rectangles (`fviz_dend`). Stage 3's visual is the four colored final groups on the first two principal components (`fviz_cluster`).
