# CA-13 Solutions — Ward's Linkage & the Lance-Williams Formula

Worked solutions. If you peeked before trying, go back and do the hand calculations yourself — the marks live in the coefficients.

---

## Problem 1 — Decode the boxed formula

(a) d(ij)k is the distance from the newly merged cluster (ij) — clusters i and j have just fused into one — to the untouched cluster k. It is the "updated" distance you need before the next merge step.

(b) n_i is the number of items inside cluster i; n_j the number inside cluster j; n_k the number inside cluster k. (They are counts, not indexes.)

(c) d_ik is the distance between cluster i and cluster k; d_jk between j and k; d_ij between i and j (the pair that just merged).

(d) The new distance is mostly a weighted mix of the two old distances d_ik and d_jk — but both of those measured from k to only *half* of the merged cluster, so the mix overcounts k's separation a little. The subtracted third term corrects for that double-counting, pulling the estimate back down. (Bigger k → bigger correction, which is why n_k sits in the numerator.)

## Problem 2 — Lance-Williams by hand (ward.D and ward.D2)

(a) n_i + n_j + n_k = 1 + 1 + 1 = 3. Coefficients: (1+1)/3 = **2/3**, (1+1)/3 = **2/3**, −1/3.

(b) ward.D: d(ij)k = (2/3)(8) + (2/3)(5) − (1/3)(3) = 16/3 + 10/3 − 3/3 = 23/3 ≈ **7.667**.

(c) ward.D2: square first — 64, 25, 9. d(ij)k = √[(2/3)(64) + (2/3)(25) − (1/3)(9)] = √[(128 + 50 − 9)/3] = √(169/3) ≈ √56.333 ≈ **7.506**.

(d) The ward.D answer (7.667) is bigger than the ward.D2 answer (7.506), by about 0.16. (They live on different scales — ward.D2 takes the square root outside — so a direct size comparison is apples-to-oranges; the episode's R proof shows how the two scales relate.)

## Problem 3 — Unequal cluster sizes

(a) Total = 2 + 1 + 3 = 6. Coefficients: (2+3)/6 = **5/6**, (1+3)/6 = 4/6 = **2/3**, −3/6 = **−1/2**.

(b) ward.D: d(ij)k = (5/6)(10) + (2/3)(6) − (1/2)(4) = 50/6 + 4 − 2 = 50/6 + 12/6 = 62/6 = **31/3 ≈ 10.333**.

(c) Cluster k is the biggest (n_k = 3), so every coefficient leans on it: the first two numerators both contain n_k (5/6 and 2/3 are the largest weights), and the subtracted correction −n_k/6 = −1/2 is also the largest it can be. The formula trusts distances involving the big cluster most, and corrects hardest for it.

## Problem 4 — Real R: ward.D vs ward.D2 (and the spelling trap)

(a) R prints ≈ **2.84e-14** (essentially zero). It proves the relationship: ward.D2 squares the distances inside and takes the square root outside, so feeding ward.D *squared* distances gives heights that are exactly the *squares* of the ward.D2 heights. Same clustering, different height scale.

(b) R prints: `ERROR: invalid clustering method Ward.D` (an error — R is case-sensitive and only accepts lowercase "ward").

(c) Two things are wrong. First, the spelling is exact — "Ward.D" with a capital W is not a method at all. Second, they are not interchangeable inputs: ward.D expects *squared* distances (feed it raw distances and the heights come out on the wrong scale), while ward.D2 takes raw distances and handles the squaring itself.

## Problem 5 — Real R: Ward's personality on USArrests

(a) **Iowa and New Hampshire** merge first, at height **0.206** — the exact same first merge as episode 12's single/complete/average runs. The smallest entry never depends on the linkage.

(b) Ward (k = 4): **7, 12, 19, 12**. Single linkage (k = 4): **46, 1, 2, 1**.

(c) The single-linkage table shows chaining: one cluster swallowed 46 of the 50 states while three strays sit alone — one close pair was enough to keep gluing groups together. The Ward table shows minimum-variance behavior: four real groups of similar size (7, 12, 19, 12), because Ward kept rejecting the lopsided merges that would have exploded the total within-cluster variance. Compact, similar-size clusters — which is exactly why industry reaches for Ward.
