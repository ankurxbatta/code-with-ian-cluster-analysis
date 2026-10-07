# CA-9 Solutions — The Gap Statistic

Worked solutions. Peek only after your own honest attempt.

---

## Problem 1 — Build a reference dataset

(a) The bounding box is the smallest box holding all the data: column 1 spans 2 to 8, column 2 spans 10 to 40. With two columns it is a rectangle, 6 units wide (8 − 2) by 30 units tall (40 − 10).

(b)
```r
col1 <- runif(30, 2, 8)
col2 <- runif(30, 10, 40)
```
Each call draws 30 uniform random numbers between that column's min and max. Stacked together, the two columns are one reference dataset: 30 points, same box as the real data, purely random positions.

(c) A fancy shape would smuggle assumptions about the data into the reference. The box assumes nothing — it is the honest simple choice, so the comparison stays fair.

## Problem 2 — The formula in numbers

(a) `log(45.2)` = 3.811. Gap(3) = 3.90 − 3.811 = 0.089. (R: `wbar <- 3.90; wbar - log(45.2)` gives 0.0890.)

(b) WSS spans orders of magnitude across k, so raw differences are dominated by scale. On the log scale, differences compare ratios — twice as tight reads the same at any scale. All the gap tables live in log units.

(c) A tiny gap means their data's log-WSS is barely below the noise baseline: their "clusters" pack hardly tighter than random points. Either k is wrong, or the data has no real clusters at this k.

## Problem 3 — Q8 by hand

(a) Bar = Gap(2) − s_2 = 0.45 − 0.04 = 0.41. Check: 0.20 ≥ 0.41? No. k = 1 fails.

(b) Bar = Gap(3) − s_3 = 0.42 − 0.03 = 0.39. Check: 0.45 ≥ 0.39? Yes. k = 2 passes. Chosen k = 2 — stop at the first success.

(c) The rule asks whether the current gap is already within the margin of everything ahead, and k = 2 is. Two more clusters buy nothing beyond the wobble, so the rule stops early and picks the simplest surviving answer. "Stop at the first success" is what keeps the rule from degenerating into "always pick more clusters" — without it, a bigger k would always win, since a bigger k always fits tighter.

## Problem 4 — A new table

(a) k = 1: bar = 0.38 − 0.03 = 0.35. 0.15 ≥ 0.35? No, fail. k = 2: bar = 0.44 − 0.03 = 0.41. 0.38 ≥ 0.41? No, fail. k = 3: bar = 0.47 − 0.04 = 0.43. 0.44 ≥ 0.43? Yes, pass. Chosen k = 3.

(b) The tallest gap is k = 4 (0.47), but the rule picks k = 3. They disagree — and the rule wins. Lesson: never chase the tallest bar; the margin rule stops at the first gap that is good enough.

(c) With all s_k = 0, the rule becomes: smallest k with Gap(k) ≥ Gap(k+1) — the first k whose gap is at least as big as the next one, i.e. the first local peak of the gap curve. The margin is what makes it a statistical rule instead of a peak-hunt.

## Problem 5 — The wobble, by hand

(a) wbar = (3.10 + 3.25 + 3.18 + 3.30 + 3.12) / 5 = 15.95 / 5 = 3.19.

(b) Deviations from 3.19: −0.09, 0.06, −0.01, 0.11, −0.07. Squared: 0.0081, 0.0036, 0.0001, 0.0121, 0.0049. Sum = 0.0288. Divide by 5: 0.00576. sd(2) = sqrt(0.00576) = 0.0759.

(c) s_2 = sqrt(1 + 1/5) · 0.0759 = sqrt(1.2) · 0.0759 ≈ 1.0954 · 0.0759 = 0.0831.

(d) As B → ∞, s_k → sd(k): with infinitely many reference copies the average wbar has no wobble left, so no adjustment margin is needed.

## Problem 6 — clusGap + maxSE in R

(a) Row 4 has the tallest gap: 0.2836, SE.sim 0.0392. (Row 3 sits just below at 0.2497.)

(b) `maxSE` returns 3 — not the tallest row.

(c) The tallest gap is only the eye's answer. `maxSE` applies the boxed rule: it walks k = 1, 2, … and stops at the first k whose gap survives the SE.sim margin of the next row. At k = 3 the gap is already within the margin of everything ahead, so the rule stops early — the margin keeps the decision honest instead of letting it chase the peak.

(d) With a different seed the chosen k can wobble (e.g. `set.seed(7)` gives k = 4, while `set.seed(123)` gives k = 3) because B = 20 is a classroom budget. The lecture script's own comment recommends B = 500 for real analysis — more copies shrink the margin and steady the answer.
