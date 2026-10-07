# CA-12 Solutions — Hierarchical Clustering & Dendrograms

Worked solutions. If you peeked before trying, go back and do the hand-run yourself — the marks live in the min()/max() updates.

---

## Problem 1 — Reading a dendrogram with a ruler

(a) Leaf order along the bottom: **3, 5, 1, 2, 4**. (3 and 5 merged first so they stand together; 2 and 4 merged so they stand together; 1 joined the (3,5) side.) The y-axis ("Distance") has ticks at 2, 3, 5, 6.

(b) Ruler at height 4: only merges at heights 2 and 3 have happened, so {3,5,1} form one cluster; the (2,4) merge sits at height 5, above the ruler, so 2 and 4 are still separate. Result: one cluster {3,5,1}, plus 2 alone, plus 4 alone.

(c) For exactly 2 clusters, cut between heights 5 and 6 (e.g. at 5.5). Clusters: {1,3,5} and {2,4}.

(d) For exactly 3 clusters, cut between heights 3 and 5 (e.g. at 4). Clusters: {1,3,5}, {2}, {4}.

## Problem 2 — Single linkage by hand

(a) Smallest entry is d(A,B) = 1. Merge (A,B) at height **1**.

(b) MIN updates: d(AB)→C = min(5, 4) = **4**; d(AB)→D = min(6, 7) = **6**.

(c) Merges: (A,B) at 1; (C,D) at 2 (smallest remaining is d(C,D) = 2); then d(AB)→(CD) = min(4, 6) = 4, so everything merges at **4**. Heights: 1, 2, 4.

(d) Leaf order: **A, B, C, D**.

## Problem 3 — Same matrix, complete linkage

(a) Same first merge: (A,B) at height 1. The smallest matrix entry does not depend on the linkage — linkage only changes how you *update* the matrix afterwards.

(b) MAX updates: d(AB)→C = max(5, 4) = **5**; d(AB)→D = max(6, 7) = **7**.

(c) Merges: (A,B) at 1; (C,D) at 2; then d(AB)→(CD) = max(5, 7) = 7, so everything merges at **7**. Heights: 1, 2, 7.

(d) Complete linkage merged everything at height 7 vs single's 4 — a taller final height. Complete linkage is stricter (it demands even the farthest pair be close), so it produces more compact clusters and taller trees.

## Problem 4 — The tie rule

(a) d(P,Q) = 3 and d(P,R) = 3 tie for smallest.

(b) Say you pick (P,Q) at height 3. Update: d(PQ)→R = min(3, 5) = 3. Final merge at height 3. Merges: (P,Q) at 3, everything at 3.

(c) Picking (P,R) instead: d(PR)→Q = min(3, 5) = 3, final merge still at 3. The final height does not change here, but the tree's shape (which pair sits together at the bottom) differs. Either choice is legal — the notes say to name your choice and move on.

## Problem 5 — Real R: dist → hclust → plot

(a) First three merge heights (complete linkage): **0.206, 0.350, 0.429**. Final merge height: **6.077**.

(b) Yes — single and average start with the identical three heights (0.206, 0.350, 0.429). The first merge is always the smallest entry of the distance matrix, regardless of linkage; the linkage only changes the updates afterwards. (Their final heights differ: single 2.058, average 3.322.)

(c) **Iowa and New Hampshire**, at height **0.206**.

(d) `hclust` clusters from pairwise dissimilarities — it needs the distance matrix because the merge decisions are made from distances between objects/clusters, and the linkage rules (min/max/average) are defined on those distances.

## Problem 6 — Cutting the tree

(a) Group sizes: **8, 11, 21, 10**. Sum: 8 + 11 + 21 + 10 = 50. ✓

(b) Cluster 1: **Alabama, Alaska, Georgia, Louisiana, Mississippi, North Carolina, South Carolina, Tennessee** (8 states).

(c) "Choosing k after the fact" means growing the full tree first and then slicing it at whatever height gives the number of groups you want. Hierarchical clustering can do this because the tree contains every possible grouping; k-means cannot because it commits to k before it starts and only returns that one flat partition.

---

All hand calculations verified in R — see `verify_hierarchical.R`.
