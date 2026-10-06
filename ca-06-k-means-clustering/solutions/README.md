# CA-6 Solutions — K-means Clustering

Worked solutions. If you peeked before trying, close this and redo the problems from scratch — the hand-run only sticks if your own pencil did it.

---

## Problem 1 — A different start, by hand

**(a)** Start: centroid 1 at A = 1, centroid 2 at D = 6.

Assign:
- A(1): |1−1| = 0 vs |1−6| = 5 → cluster 1.
- B(2): |2−1| = 1 vs |2−6| = 4 → cluster 1.
- C(5): |5−1| = 4 vs |5−6| = 1 → cluster 2.
- D(6): |6−1| = 5 vs |6−6| = 0 → cluster 2.

Clusters: (A,B) and (C,D). Recompute: (1+2)/2 = **1.5**, (5+6)/2 = **5.5**.

Reassign vs 1.5 / 5.5: A: 0.5 vs 4.5 stays; B: 0.5 vs 3.5 stays; C: 3.5 vs 0.5 stays; D: 4.5 vs 0.5 stays. Nothing moves → stop.

Answer: clusters **(A,B), (C,D)**, means **1.5 / 5.5** — same as the lesson.

**(b)** No — matching answers here prove nothing about real data. These four points form two clean, far-apart pairs, so almost any start lands in the same valley. On messy, overlapping data, different starts fall into different valleys with different total WSS — that is exactly why the notes demand nstart = 25.

## Problem 2 — WSS by hand, new data

**(a)** Start: centroid 1 at F = 4, centroid 2 at G = 9.

Assign: E(3): |3−4| = 1 vs |3−9| = 6 → cluster 1. F → cluster 1 (distance 0). G → cluster 2 (distance 0). H(10): |10−4| = 6 vs |10−9| = 1 → cluster 2.

Recompute: (3+4)/2 = **3.5**, (9+10)/2 = **9.5**. Reassign: E: 0.5 vs 6.5 stays; F: 0.5 vs 5.5 stays; G: 5.5 vs 0.5 stays; H: 6.5 vs 0.5 stays. Stop.

Final clusters: **(E,F) and (G,H)**, means **3.5 / 9.5**.

**(b)** Cluster 1: (3−3.5)² + (4−3.5)² = 0.25 + 0.25 = **0.5**. Cluster 2: (9−9.5)² + (10−9.5)² = 0.25 + 0.25 = **0.5**. Total WSS = **1.0**.

**(c)** total_SS: (3−6.5)² + (4−6.5)² + (9−6.5)² + (10−6.5)² = 12.25 + 6.25 + 6.25 + 12.25 = **37**. between_SS = 37 − 1.0 = **36**. 36/37 = 0.9730 = **97.3%**. Better than the lesson's 94.1% — the two pairs here sit further apart relative to their within-cluster spread.

## Problem 3 — The notes' R check

**(a)** `kmeans(data1, 2, nstart = 25)` prints: `K-means clustering with 2 clusters of sizes 2, 2`; cluster means 1.5 / 5.5; clustering vector `A B C D → 1 1 2 2`; within SS `0.5 0.5`; `(between_SS / total_SS = 94.1 %)`. Every digit matches the hand work.

**(b)** `set.seed(42); kmeans(data1, 2, nstart = 1)` gives the same answer (means 1.5 / 5.5, tot.withinss = 1.0). The notes still insist on nstart = 25 because toy data has one obvious valley — real data has many local valleys, and a single random start can strand you in a bad one; 25 starts keep the best of 25 runs.

## Problem 4 — MacQueen's in 2-D (worksheet style)

**(a)** Start: c1 = A = (5,3), c2 = C = (1,−2). Compare **squared** Euclidean distances (same ordering, no square roots needed).

- A(5,3): distance 0 to c1 → cluster 1.
- B(−1,1): to c1: (−1−5)² + (1−3)² = 36+4 = 40; to c2: (−1−1)² + (1+2)² = 4+9 = 13 → cluster 2. **Point moved → update c2 immediately** (MacQueen!): c2 = ((1 + −1)/2, (−2+1)/2) = **(0, −0.5)**.
- C(1,−2): to c1: (1−5)² + (−2−3)² = 16+25 = 41; to c2 = (0,−0.5): (1−0)² + (−2+0.5)² = 1+2.25 = 3.25 → stays in cluster 2.
- D(−3,−2): to c1: (−3−5)² + (−2−3)² = 64+25 = 89; to c2 = (0,−0.5): (−3−0)² + (−2+0.5)² = 9+2.25 = 11.25 → cluster 2. **Point moved → update c2 immediately**: c2 = ((1 + −1 + −3)/3, (−2+1−2)/3) = **(−1, −1)**.

End of pass 1: cluster 1 = {A}, c1 = (5,3); cluster 2 = {B,C,D}, c2 = (−1,−1).

Reassign pass vs (5,3) / (−1,−1): A: 0 vs 52 → 1. B: 40 vs 4 → 2. C: 41 vs 5 → 2. D: 89 vs 5 → 2. Nothing moves → stop.

Final: cluster 1 = **{A}**, centroid **(5,3)**; cluster 2 = **{B,C,D}**, centroid **(−1,−1)**.

**(b)** Cluster 1 WSS = 0 (single point). Cluster 2: B: (−1+1)² + (1+1)² = 0+4 = 4; C: (1+1)² + (−2+1)² = 4+1 = 5; D: (−3+1)² + (−2+1)² = 4+1 = 5. Total WSS = **14**.

**(c)** R prints `km$cluster` = A:1, B:2, C:2, D:2; `km$centers` = (5,3) and (−1,−1); `km$tot.withinss` = 14. Matches the hand work exactly.

## Problem 5 — USArrests, the walkthrough's core

**(a)** `print(km.res)`: `K-means clustering with 4 clusters of sizes 8, 13, 16, 13`; `(between_SS / total_SS = 71.2 %)`.

**(b)** `head(km.res$cluster, 4)`: Alabama 1, Alaska 4, Arizona 4, Arkansas 1. Alabama is in **cluster 1**; Alaska is in **cluster 4**.

**(c)** `aggregate(USArrests, by = list(cluster = km.res$cluster), mean)`:

| cluster | Murder | Assault | UrbanPop | Rape |
|---|---|---|---|---|
| 1 | 13.93750 | 243.62500 | 53.75000 | 21.41250 |
| 2 | 3.60000 | 78.53846 | 52.07692 | 12.17692 |
| 3 | 5.65625 | 138.87500 | 73.87500 | 18.78125 |
| 4 | 10.81538 | 257.38462 | 76.00000 | 33.19231 |

**Cluster 1** has the highest mean Murder rate: **13.93750**.

## Problem 6 — The three rules

**(a)** Tell them it will not work: a distance matrix has no coordinates, so k-means cannot compute new centroids (centroids are averages, and you cannot average a table of distances). They must supply the raw data. If only the distance matrix exists, use **PAM** with `diss = TRUE` (episode 10).

**(b)** No. K-means takes quantitative (numerical) data only — it cannot average the labels red / blue / green.

**(c)** `nstart = 25`: R tries 25 different random sets of starting centroids and keeps the run with the lowest total within-cluster variation (tames the random-start sensitivity). `set.seed(123)`: fixes the random number generator so the 25 starts — and the answer — are reproducible.
