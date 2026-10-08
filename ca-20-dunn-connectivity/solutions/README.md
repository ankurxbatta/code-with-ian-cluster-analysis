# CA-20 Worked Solutions — Dunn Index & Connectivity: Internal Validation

Try the problems yourself first. These solutions show every step.

---

## Problem 1 — Say it in plain English

(a) **Internal validation** judges a clustering using only the clustered data itself — no outside labels, no answer key. **External validation** (CA-19's Rand index) grades against outside truth, like the iris species column. The two internal measures in this episode are the **Dunn index** and **connectivity**.

(b) The **diameter** of a cluster is the largest distance between any two members of that cluster — the worst-case stretch inside one group. The **inter-cluster distance** is the smallest distance from a member of one cluster to a member of another — the closest approach between two different groups. In words: the Dunn index equals the smallest inter-cluster distance, divided by the largest diameter.

(c) The blank is **high**. Compact clusters have small diameters, so the denominator shrinks; well-separated clusters have large inter-cluster distances, so the numerator grows. Small denominator and big numerator make a big score — so a higher Dunn index means more compact and better-separated clusters.

(d) **Connectivity** measures to what extent items sit in the same cluster as their nearest neighbours in the data space. A **low** score is better. A score of exactly **0** means every point's nearest neighbours all sit in its own cluster — perfectly connected.

---

## Problem 2 — By hand: the Dunn example

(a) Cluster 1 = {1, 2}: only one pair, diameter = |2 − 1| = **1**. Cluster 2 = {5, 6}: diameter = |6 − 5| = **1**. The denominator (largest diameter) = max(1, 1) = **1**.

(b) Cross-cluster pairs: (1,5), (1,6), (2,5), (2,6). Distances: 4, 5, 3, 4. The smallest is |5 − 2| = **3** — the numerator.

(c) Dunn = 3 / 1 = **3**. That is high: the clusters are tight (small diameters) with a wide gap between them — exactly the fill-in-the-blank from Problem 1(c).

(d) Clusters {1, 2} and {3, 4}: diameters are still 1 and 1, so the denominator is 1. The closest cross-cluster pair is now 2 and 3, distance 1 — the numerator is 1. Dunn = 1 / 1 = **1**, much lower than 3. What changed: only the gap shrank. The Dunn index fell because the numerator (separation) collapsed while the denominator (compactness) stayed the same — the score tracks separation, not just tightness.

---

## Problem 3 — By hand: the connectivity board example

Rule: same cluster → 0; j-th nearest neighbour in a different cluster → 1/j. Neighbour count = 2.

(a) **A**: 1st NN is B (same cluster) → 0; 2nd NN is C (different cluster, 2nd) → 1/2. A = 0 + 1/2 = **0.5**.

(b) **B**: 1st NN is C (different cluster, 1st) → 1; 2nd NN is A (same cluster) → 0. B = 1 + 0 = **1**.

(c) **C**: 1st NN is B (different cluster, 1st) → 1; 2nd NN is in the other cluster (2nd) → 1/2. C = 1 + 1/2 = **1.5**.

(d) **D**: 2 nearest neighbours are E and C, both in cluster 2 (same) → **0**. **E**: 2 nearest neighbours are D and C, both in cluster 2 (same) → **0**. Total = 0.5 + 1 + 1.5 + 0 + 0 = **3**.

(e) Almost all of the 3 sits on the **border**: B and C pay 1 and 1.5 because they touch while living in different clusters, and A pays 0.5 for reaching across. D and E pay nothing. If C moved deep inside cluster 2, its two nearest neighbours would both be in its own cluster → C = 0, and the new total = 0.5 + 1 + 0 + 0 + 0 = **1.5**. Lesson: connectivity punishes exactly the border violations — points whose neighbours belong to another cluster — and ignores the well-placed interior.

---

## Problem 4 — Real R: Dunn and connectivity

(a) k-means assigned the labels **1 1 3 2 2 3 3 3** — groups of **2, 2, and 4** points, exactly the worksheet's picture.

(b) The Dunn index is **1.226616**. "Above 1" means the smallest gap between clusters is bigger than the largest stretch inside any cluster — the gap beats the stretch, so these are reasonably compact, well-separated groups.

(c) `connectivity(distance, cluster, neighbSize = 2)` returns **3**.

(d) With `neighbSize = 1` the score is **2** — lower than with 2. Why: only each point's single nearest neighbour is checked, so cross-cluster 2nd neighbours stop counting. On these 10 points, only points 7 and 9 are each other's nearest neighbour across the cluster boundary (each costs 1); point 8's cross-cluster 2nd neighbour (point 9) no longer counts. The neighbour count changes how many chances each point has to be penalised, which is why the course tells you it will always be given — without it, the score is not defined.

(e) R returns **3**, matching the hand calculation from Problem 2(c) exactly.

---

## Problem 5 — The two judges side by side

(a) **Connectivity is happy** (0 is perfect — every point sits with its neighbours). **The Dunn index is not** (0.4 is low — some cluster is stretched, or two clusters nearly touch). The clustering keeps neighbours together but fails on compactness or separation.

(b) Picture tight little balls of points with wide empty space between the balls, and no point sitting closer to another cluster's members than to its own. The Dunn index is high because the diameters are small and the gaps are large; connectivity is 0 because every point's nearest neighbours are its own cluster-mates.

(c) Each internal judge sees something different — Dunn watches worst-case stretch and closest gaps, connectivity watches neighbourhood structure, silhouette watches per-point fit. One number can be fooled (a lucky gap, a hidden border violation); several judges have to agree before you trust the clustering. That is exactly what `clValid` does next episode: it scores whole algorithms on all of them at once.
