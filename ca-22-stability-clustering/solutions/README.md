# CA-22 Solutions — Stability of Clustering

Every answer below comes from running `stability_demo.R` in the folder above (R 4.3.3, `clValid`, `set.seed(42)`). If your numbers differ slightly, re-run the script — it is the source of truth.

---

## Problem 1 — Say it in plain English

(a) A clustering is **stable** when you can delete one column of the data and re-cluster, and almost every observation still ends up with the same cluster-mates. The test: drop column 1, re-cluster the rest, compare with the full-data clustering; restore it and repeat for columns 2, 3, 4. Four columns, four comparisons. If nobody moves, the clustering is stable; if observations scatter every time, it is fragile.

(b) **APN** (average proportion of non-overlap): the fraction of observations NOT placed in the same cluster under the full data vs. the column-removed data, averaged over all columns. Range 0 to 1. **Smaller (low) is better.**
**AD** (average distance): for the observations that DID stay in the same cluster under both clusterings, the average distance between them. Range 0 to infinity. **Smaller (low) is better.**
**ADM** (average distance between means): for the observations that stayed together, how far apart the two cluster centers (full-data center vs. removed-column center) sit. Range 0 to 1. **Smaller (low) is better.**
**FOM** (figure of merit): the within-cluster variance of the deleted column, averaged over all deleted columns — i.e. how well the clusters (built without that column) predict it. Range 0 to 1. **Smaller (low) is better.**

(c) APN = 0.003266667 means that, on average, only about 0.33% of cluster-mates drift apart per column removal — the demo shows the total moved share across all 150 flowers x 4 columns is about 1.96, roughly two full separations. Almost nothing moves: the clustering survives losing a column. A score of 0.5 would mean that, on average, **half of all cluster-mates** end up in a different cluster after each column removal — a clustering that shatters whenever a column goes missing.

## Problem 2 — Real R: run the stability tournament

The winners table from `optimalScores(stab)`:

```
          Score       Method Clusters
APN  0.003266667 hierarchical        2
AD   1.004288856          pam        6
ADM  0.016087089 hierarchical        2
FOM  0.455750052          pam        6
```

(a) APN: hierarchical, 2 clusters. AD: PAM, 6 clusters. ADM: hierarchical, 2 clusters. FOM: PAM, 6 clusters.

(b) k-means at 2 clusters: APN = 0.0128. k-means at 6 clusters: APN = 0.2950336. APN gets **worse** (larger) as the cluster count grows — more, smaller clusters are more easily rearranged by a missing column.

(c) PAM at 6 clusters: AD = 1.004289. PAM at 2 clusters: AD = 1.505979. AD naturally favors higher cluster counts because more clusters means smaller clusters, and smaller clusters mean shorter distances between survivors. If you used AD to pick the number of clusters, you would always pick the largest count you tried — even when it is not the right answer. Compare algorithms at one fixed count instead.

(d) ADM at 2 clusters is won by **hierarchical at 0.01608709**. The second-best score is **0.05545039, shared by k-means and PAM (both at 2 clusters)** — a tie.

## Problem 3 — The APN formula, decoded

(a) `k` = the number of clusters used. `N` = the number of observations (rows). `M` = the number of variables (columns). `C^{i,0}` = the cluster containing observation i, computed on the **full** data. `C^{i,l}` = the cluster containing observation i, computed after **column l** is removed. For the iris demo: `N` = 150 flowers, `M` = 4 measurement columns.

(b) The term is `1 - n(overlap) / n(full-data cluster)` = `1 - 49/50` = **0.02**. Two percent of flower 1's cluster-mates left it when Petal.Length was removed.

(c) When all 50 stay together, the overlap equals the full cluster, so the term is `1 - 50/50` = **0** for each of the three removals. Flower 1 contributes only one non-zero term (0.02) out of its four terms — its average contribution to the APN is 0.005. It is a very stable flower.

(d) Each inner term is `1 - (a proportion)`, so each term lies in [0, 1]. The double sum adds `N x M` such terms (150 x 4 = 600 for iris), and dividing by `M x N` turns the sum into an **average of proportions**. An average of numbers that all lie in [0, 1] must itself lie in [0, 1]. 0 means nobody ever moved; 1 means every cluster-mate left, every time.

## Problem 4 — The second-best table

(a)

| Measure | Best (method, k, score) | Second best (method, k, score) |
|---------|------------------------|-------------------------------|
| APN | hierarchical, 2, 0.003266667 | k-means + PAM (tie), 2, 0.0128 |
| AD | PAM, 6, 1.004288856 | PAM, 5, 1.072620 |
| ADM | hierarchical, 2, 0.01608709 | k-means + PAM (tie), 2, 0.05545039 |
| FOM | PAM, 6, 0.455750052 | PAM, 5, 0.4788582 |

(b) The ties for second best are on **APN** (k-means and PAM, both at 2 clusters, 0.0128) and **ADM** (k-means and PAM, both at 2 clusters, 0.05545039). What they have in common: both measures are built from the cross-classification of the full-data clustering against the column-removed clustering, and at 2 clusters **all three methods produced the identical 50-vs-100 split** (verified: `table(km2, pm2)` shows 50/0 and 0/100). Identical starting clusters → identical APN/ADM terms for k-means and PAM.

(c) **k-means with 5 clusters at 0.4804886** — just behind PAM/5's 0.4788582.

## Problem 5 — The split crown

(a) "Hierarchical wins" is only half the story. Hierarchical (2 clusters) won the two measures that count **moved flowers and drifting centers** (APN, ADM): the clustering that changes least when data goes missing. PAM (6 clusters) won the two measures that count **distances and variance** (AD, FOM): the clustering whose groups stay tight and predictable. If you care that your clusters hold their membership and shape when a sensor drops out, pick the APN/ADM winner. If you care that the groups stay compact and can predict missing values, the FOM winner is your answer. A clustering worth trusting answers yes to all four.

(b) AD measures distances inside the surviving clusters, and FOM averages within-cluster variance of the removed column. Both shrink mechanically when clusters get smaller — more clusters, tighter groups, shorter distances, lower variance. So across counts they will always point at the largest k you tried. They are only fair as **algorithm** comparisons at one fixed cluster count, where the shrinking is held constant.

(c) The script saves `stability_curves.png`. On the APN curve the **hierarchical (blue) line sits lowest**, hugging zero, while k-means and PAM rise as k grows. "Lowest" means most stable — APN is a smaller-is-better measure, so the lowest line is the winner.
