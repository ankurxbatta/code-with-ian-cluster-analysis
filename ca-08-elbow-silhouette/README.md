# CA-8 Assignment — Choosing k: Elbow Method & Silhouette Width

Try all five problems before looking at the solutions. One honest attempt beats a copied answer. You will need R (4.0 or newer) with `factoextra` and `cluster` (`install.packages(c("factoextra", "cluster"))`). Remember the pairings: elbow with k-means, silhouette with PAM.

---

## Problem 1 — Read the elbow

A classmate runs k-means (25 starts) on scaled data for k = 1 to 6 and reports total WSS:

| k | 1 | 2 | 3 | 4 | 5 | 6 |
|---|---|---|---|---|---|---|
| total WSS | 210.5 | 118.2 | 84.6 | 61.3 | 55.8 | 51.2 |

(a) Compute the five drops (k = 1→2, 2→3, …, 5→6). Where do the drops collapse? What k does the elbow suggest?
(b) A friend says "just pick k = 6, it has the smallest WSS." In two or three sentences, explain why that reasoning fails — what happens to WSS as k keeps growing, and what k would "win" if smallest-WSS were the rule?

## Problem 2 — Silhouette by hand (Q7 style)

Four points on a number line: P = 2, Q = 4, R = 9, S = 11. Cluster 1 = {P, Q}, Cluster 2 = {R, S}.

(a) Compute s(Q) step by step: find a (average distance from Q to its own cluster), find b (average distance from Q to the rival cluster), then s(Q) = (b−a)/max(a,b).
(b) Compute s(P), s(R), and s(S) the same way.
(c) Average all four widths (one per point, then average — the starred rule). Interpret the average: is this dataset well clustered?

## Problem 3 — b is a MINIMUM

Point X sits in cluster {X, Y} with XY = 1, so a = 1. There are two rival clusters: {M} with XM = 3, and {N, O} with XN = 8 and XO = 10.

(a) Compute b1 (X's average distance to rival cluster 1) and b2 (X's average distance to rival cluster 2). What is b?
(b) Compute s(X).
(c) A classmate averages ALL rivals together: (3 + 8 + 10)/3 = 7, and gets a different silhouette. In one or two sentences, explain why that number is wrong and what the notes insist b must be.

## Problem 4 — Elbow + silhouette in R (iris)

Run the episode's full pattern on the iris measurements (columns 1–4), scaled:

```r
library(factoextra)
library(cluster)
df <- scale(iris[, 1:4])
set.seed(123)
# elbow
fviz_nbclust(df, kmeans, method = "wss", nstart = 25) +
  geom_vline(xintercept = 3, linetype = 2)
# silhouette
fviz_nbclust(df, pam, method = "silhouette")
```

(a) From the elbow plot (and the WSS values behind it): where do YOU see the bend? Write down the k you pick and one sentence of justification.
(b) A classmate looks at the same plot and picks a different k. Who is right? Connect your answer to the warning in the typed notes about the iris curve.
(c) From the silhouette plot: which k has the highest average silhouette width? What k does the starred rule pick?
(d) The two methods disagree (as in the episode). In two or three sentences, explain why that can happen — what does each method reward?

## Problem 5 — Read three scores

Three observations come back with silhouette widths: s = 0.85, s = −0.15, s = 0.02.

(a) Interpret each one in plain English: well placed, likely misclassified, or on the border?
(b) For the −0.15 point: what does the negative sign tell you about its a and b (which is bigger)? What would you check next?
(c) If a whole dataset averaged s = 0.05, would you trust the clustering? One or two sentences.
