# CA-7 Solutions — Is Your Data Clusterable? Hopkins Statistic & VAT

Worked solutions. Try the problems first — the struggle is the lesson.

---

## Problem 1 — Predict, then verify

(a) The numbers huddle: 2, 2.3, 2.1, 2.5 sit near 2, and 15, 15.4, 14.8, 15.1 sit near 15, with a big empty gap between. Prediction: H near 1 (clusterable).

(b) R gives about 0.94 (your exact value will wobble slightly — see Problem 4 for why):

```r
library(hopkins)
x <- c(2, 2.3, 2.1, 15, 15.4, 14.8, 15.1, 2.5)
mean(replicate(100, hopkins(matrix(x, ncol = 1), 5)))
# [1] 0.9397703  (example; expect ~0.9+)
```

0.94 falls in the 0.7–1 band: **clusterable**. Next step of the workflow: find k (episode 8), then pick an algorithm.

---

## Problem 2 — Read the number

(a) H = 0.15 → **regular** (0–0.3 band: evenly spaced, like a grid). H = 0.52 → **random** (0.3–0.7 band, near 0.5 = uniform). H = 0.83 → **clusterable** (0.7–1 band).

(b) 0.15 (regular): do not cluster for groups — the even spacing means there are no natural bunches; check whether the data is on a grid or needs a different analysis. 0.52 (random): walk away — clustering uniform noise just imposes groups that are not real. 0.83 (clusterable): proceed — this data earns step 2 of the workflow, finding k.

(c) For uniform random data, a real point's nearest neighbour and a fresh random point's nearest neighbour are drawn from the same kind of scatter, so the x distances and y distances look alike. H = (sum y)/(sum x + sum y) then has a numerator about equal to half the denominator — about one half.

---

## Problem 3 — The reversed-scale trap

(a) 1 − 0.96 = 0.04. The conversion is (approximately) H_clustertend = 1 − H_hopkins. The two packages mirror each other.

(b) On the `hopkins` scale, 0.04 sits deep in the 0–0.3 regular band — you would conclude the data is evenly spaced with no groups worth finding, and you would never cluster it. But the data is actually strongly clusterable (H = 0.96). You would walk away from real structure because you read the number on the wrong ruler. That is why the lesson's rule is absolute: the `hopkins` package only, never `clustertend`.

---

## Problem 4 — One run wobbles, one hundred settle

(a) The three single runs give different numbers (e.g. 0.97, 0.95, 0.98 — yours will differ). They differ because every call to `hopkins()` generates **fresh uniform random y points**, so the y distances — and the resulting fraction — change each time.

(b) The three means of 100 will agree to about ±0.01 (e.g. 0.966, 0.965, 0.967). Averaging washes out the luck of any single random draw: one H is a single draw from a noisy process, while the mean of 100 draws is a stable measurement of the underlying tendency. No seed needed — the average is steady on its own.

---

## Problem 5 — Hand VAT, three items

(a) The distance matrix (order P, Q, R):

```
    P  Q  R
P   0  2  9
Q   2  0 10
R   9 10  0
```

(b) P and Q are the closest pair (distance 2), so the order P, Q, R already puts friends together. No reorder needed.

(c) Shading (under 6.5 white, else black):

```
        P      Q      R
P     white  white  black
Q     white  white  black
R     black  black  white
```

Two white blocks on the diagonal: the 2×2 block {P, Q} and the 1×1 block {R}. Two blocks → **two clusters**: {P, Q} + {R}. R is the outsider (distances 9 and 10 to the others).

(d) `fviz_dist()` on this matrix shows the same structure in colour: a red 2×2 block for P–Q (small distances = similar) against blue for anything involving R (large distances = dissimilar). The hand shading and the R picture agree — white blocks on black are the same idea as red blocks on blue.
