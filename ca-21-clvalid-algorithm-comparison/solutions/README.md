# CA-21 Worked Solutions — clValid: Which Algorithm Wins?

Try the problems yourself first. These solutions show every step.

---

## Problem 1 — Say it in plain English

(a) **`clValid`** runs a tournament between clustering algorithms. You hand it your data and it tries every combination of algorithm and cluster count, scores each one with validation measures, and reports the best. In this episode the four main arguments are: `df` — the data to cluster (scaled iris, species column removed); the cluster counts `2:6` — try 2, 3, 4, 5, and 6 clusters; the method list `c("hierarchical", "kmeans", "pam")` — the three contestants; and `"internal"` — use the internal validation judges (connectivity, Dunn, silhouette), where the data judges itself with no answer key.
(b) 3 algorithms × 5 cluster counts = **15 runs**. One call is better because it runs all 15 the same way, scores them with the same judges, and collects the answers in one scoreboard — by hand you would repeat the same setup 15 times and could easily score them inconsistently.
(c) The **validation-measures block** is the full scoreboard: for every algorithm and every cluster count, what each of the three judges said. The **optimal-scores block** is the winners table: for each judge, the single best score, which method earned it, and at how many clusters.

---

## Problem 2 — Real R: run the tournament

(a) At 2 clusters every method scored **0.9762** on connectivity. At 6 clusters PAM scored **44.5413** — the worst cell on the whole board. 0.9762 is far better (connectivity: LOW wins): at 2 clusters every method keeps neighbours together, while at 6 the neighbourhoods are sliced apart and every border crossing costs.
(b) K-means scored **0.0265** at 3 clusters — a Dunn index near zero means some gap nearly vanished, with two clusters almost touching. **Hierarchical** holds up best: 0.1874 at 3 clusters and 0.2060 at 4 clusters (PAM manages only 0.0571 and 0.0566 there).
(c) All three methods scored **0.5818** at 2 clusters. The averages go **down** as the count grows (by 6 clusters the best is only 0.3441) — splitting the flowers into more groups makes the average flower less sure of where it belongs.
(d) **Hierarchical with 2 clusters** wins on all three measures: connectivity 0.9762, Dunn 0.2674, silhouette 0.5818.

---

## Problem 3 — The tie: same scores, three algorithms

(a) The tables show perfect agreement — for example `table(hc2, km2)` has 50 and 100 on the diagonal and 0 everywhere else. **The three methods produced the exact same clusters**: one group of 50, one group of 100.
(b) The validation measures are computed from the cluster labels and the distances only. The same labels on the same data give the same diameters, the same gaps, and the same neighbourhoods — so every judge must produce the same score.
(c) Cluster 1 is the **50 setosa** flowers; cluster 2 holds the other **100** (versicolor + virginica). It is the easy split because setosa's petals are tiny and far from the other two species — the most obvious division in the data, so every algorithm finds it.

---

## Problem 4 — The crown question

(a) With `c("pam", "kmeans", "hierarchical")` the Optimal Scores table now crowns **PAM with 2 clusters** on all three measures (same scores: 0.9762, 0.2674, 0.5818).
(b) No — the data did not change at all. The winner changed because of the tie-break rule: **when scores tie, clValid reports the first method in your list**. Hierarchical was listed first in the original call, so it got the crown; list PAM first and the crown moves.
(c) Correction: "clValid did not prove hierarchical is better — all three methods tied at 2 clusters because they found the same split, and clValid just reported the first method in the list. Reorder the list and the crown moves without the data changing."

---

## Problem 5 — The plots decide

(a) All three silhouette lines **start together at 0.5818** (the 2-cluster peak) and **fall as the cluster count grows** — no method ever climbs back up.
(b) All three Dunn lines **meet at 2 clusters (0.2674)**. After that, the **hierarchical** line stays on top through 3 and 4 clusters, while the k-means line dives at 3 clusters (the 0.0265 collapse).
(c) The table gives you only the winners; the plots show you the **whole race** — how each method degrades as the cluster count grows, which one degrades gracefully (hierarchical), and which one falls off a cliff. Pictures decide faster than tables.
