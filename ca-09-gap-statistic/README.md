# CA-9 Assignment — The Gap Statistic

Try all six problems before looking at the solutions. One honest attempt beats a copied answer. You will need R (4.0 or newer) with the `cluster` package (`install.packages("cluster")`). Remember: the gap compares your data against random noise, and the rule — not the tallest bar — picks k.

---

## Problem 1 — Build a reference dataset

You have a dataset with 30 points and 2 columns. Column 1 ranges from 2 to 8, column 2 ranges from 10 to 40.

(a) Describe the bounding box of this data in plain words (what are its sides?).
(b) Write the two `runif` calls that build ONE reference dataset with the same shape (30 points). What does each call do?
(c) In one or two sentences: why do the notes use a plain box with uniform points, instead of a fancier shape?

## Problem 2 — The formula in numbers

At k = 3, your data's total within-cluster SS is w_3 = 45.2, and the average of the B reference log-WSS values is wbar = 3.90.

(a) Compute log(w_3) with R (`log(45.2)`). Then compute Gap(3) = wbar − log(w_3). Show your subtraction.
(b) In one or two sentences, explain why the formula takes the log of WSS instead of using raw WSS.
(c) A classmate's data gives Gap(2) = 0.05. In plain words, what does a tiny gap tell you about their data compared to random noise?

## Problem 3 — Q8 by hand

The handwritten notes give this gap table (B reference sets already used):

| k | Gap(k) | s_k |
|---|--------|-----|
| 1 | 0.20 | 0.03 |
| 2 | 0.45 | 0.04 |
| 3 | 0.42 | 0.03 |
| 4 | 0.50 | 0.05 |

The boxed rule: choose the smallest k with Gap(k) ≥ Gap(k+1) − s_{k+1}.

(a) Test k = 1: write out the bar (Gap(2) − s_2) and the comparison. Pass or fail?
(b) Test k = 2: write out the bar (Gap(3) − s_3) and the comparison. Pass or fail? What is the chosen k?
(c) Row 4 has the tallest gap (0.50). In two or three sentences, explain why the rule does NOT pick k = 4 — and why "stop at the first success" is part of the rule.

## Problem 4 — A new table

A different dataset gives this table:

| k | Gap(k) | s_k |
|---|--------|-----|
| 1 | 0.15 | 0.02 |
| 2 | 0.38 | 0.03 |
| 3 | 0.44 | 0.03 |
| 4 | 0.47 | 0.04 |

(a) Apply the boxed rule starting at k = 1. Show each bar and each pass/fail. Which k is chosen?
(b) Which k has the tallest gap? Does the rule agree with the tallest bar here? What lesson does that teach?
(c) Suppose the s_k column were all zeros (no wobble at all). What would the rule reduce to, in plain words?

## Problem 5 — The wobble, by hand

For k = 2, five reference copies give these log(w_2^ref) values: 3.10, 3.25, 3.18, 3.30, 3.12.

(a) Compute wbar (the average of the five).
(b) Compute sd(2) = sqrt((1/5) Σ (value − wbar)²). Show the five squared deviations.
(c) Compute s_2 = sqrt(1 + 1/5) · sd(2).
(d) In one sentence: as B grows huge, what does s_k approach, and why does that make sense?

## Problem 6 — clusGap + maxSE in R

Run the episode's pattern on scaled USArrests:

```r
library(cluster)
df <- scale(USArrests)
set.seed(123)
gap <- clusGap(df, FUN = kmeans, K.max = 10, B = 20, nstart = 25)
round(gap$Tab, 4)
maxSE(gap$Tab[, "gap"], gap$Tab[, "SE.sim"])
```

(a) Which row has the tallest gap? Write down its gap and its SE.sim.
(b) What does `maxSE` return? Is it the same row as (a)?
(c) In two or three sentences, explain why the answer is not simply the tallest-gap row — what does the SE.sim column do in the decision?
(d) Change the seed (e.g. `set.seed(7)`) and rerun. Does the chosen k stay put or wobble? What does the lecture script recommend to steady the answer for real analysis?
