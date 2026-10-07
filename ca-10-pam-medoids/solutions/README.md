# CA-10 Worked Solutions

Work through the assignment first — these are here to check your thinking, not replace it.

---

## Problem 1 — The Manhattan dissimilarity matrix

Manhattan distance = |x1 − x1'| + |x2 − x2'|.

(a) AB: |5 − (−1)| + |3 − 1| = 6 + 2 = **8**.

(b)
- AC: |5 − (−4)| + |3 − 4| = 9 + 1 = **10**
- AD: |5 − (−3)| + |3 − (−2)| = 8 + 5 = **13**
- BC: |−1 − (−4)| + |1 − 4| = 3 + 3 = **6**
- BD: |−1 − (−3)| + |1 − (−2)| = 2 + 3 = **5**
- CD: |−4 − (−3)| + |4 − (−2)| = 1 + 6 = **7**

Full matrix:

| | A | B | C | D |
|---|---|---|---|---|
| A | 0 | 8 | 10 | 13 |
| B | 8 | 0 | 6 | 5 |
| C | 10 | 6 | 0 | 7 |
| D | 13 | 5 | 7 | 0 |

(c) The typed notes' rule of thumb: outliers → Manhattan distance. Manhattan sums per-column gaps without squaring, so a large single-column gap does not get exaggerated the way Euclidean squares it.

## Problem 2 — BUILD: initial medoids {A, B}

(a) C: to A = 10, to B = 6 → **B**. D: to A = 13, to B = 5 → **B**. Clusters: {A}, {B, C, D}.

(b) Cost = C's bill + D's bill + A's bill = 6 + 5 + 0 = **11**.

(c) A medoid's distance to itself is zero — it sits on its own location, so it adds nothing to the sum.

## Problem 3 — SWAP: try B ↔ C

(a) Trial medoids {A, C}. B: to A = 8, to C = 6 → **C**. D: to A = 13, to C = 7 → **C**.

(b) Cost{A, C} = 6 + 7 = **13**.

(c) **Undo.** PAM's rule: keep the swap only if the cost fell; 13 > 11, so the cost rose and the swap is undone. B returns as medoid.

## Problem 4 — SWAP: try B ↔ D

(a) Trial medoids {A, D}. B: to A = 8, to D = 5 → **D** (pays 5). C: to A = 10, to D = 7 → **D** (pays 7). Cost{A, D} = 5 + 7 = **12**.

(b) **Undo** — 12 > 11.

(c) k × (n − k) = 2 × 2 = **4** cost calculations. The four swaps: A↔C, A↔D, B↔C, B↔D (each medoid paired with each non-medoid). The other two — A↔C → 13, A↔D → 14 — also lose to 11, so the final answer stays {A, B} with cost 11. (Check them yourself!)

## Problem 5 — Robustness and the matrix trick

(a) A mean is an average of ALL points, so one far-away outlier pulls the average toward itself. A medoid must be an actual data point — the most central one — so the outlier can scream from the corner while the center stays a real, central point. That is why the notes call PAM the robust alternative to k-means.

(b) k-means recomputes its centers as averages after every assignment, which requires the raw numbers. PAM's swaps only ever read distances from the matrix — the raw values never enter a calculation — so a precomputed dissimilarity matrix is all it needs.

(c) R confirms the hand work (see `verify_costs.R`):

- `pam4$medoids` → **A and B** (rows (5, 3) and (−1, 1))
- `pam4$clustering` → **1 2 2 2** (A alone; B, C, D together)
- `pam(as.matrix(mydist), 2, diss = TRUE)$medoids` → **A and B** — the same answer, from the matrix alone.
