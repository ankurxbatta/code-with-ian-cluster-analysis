# CA-5 Worked Solutions

Work through the assignment first — these are here for checking, not copying.

---

## Solution 1 — Correlation distance by hand

(a) A and B move perfectly together: Pearson's r = **1**, so correlation distance d = 1 − 1 = **0**.
(b) A and C move perfectly opposite: Pearson's r = **−1**, so d = 1 − (−1) = **2**.
(c) Pearson's r only scores the *shape* of the movement (up together, down together), and standardizes away the units — so doubling every number changes nothing.

## Solution 2 — Gower by hand (quantitative + nominal)

With just the two columns (age + continent): W1 vs W2: age |30 − 40| / 20 = 10/20 = **0.5**; continent Asia ≠ Europe → **1**. Average: (0.5 + 1) / 2 = **0.75**.

(Note: once the medal column joins in Problems 3–4, the same pair's distance becomes (0.5 + 1 + 0.5)/3 = 0.6667 — adding a column always re-weights the average.)

## Solution 3 — The ordinal recipe

(a) Three levels (Bronze=1, Silver=2, Gold=3): scores are (1−1)/2 = **0**, (2−1)/2 = **0.5**, (3−1)/2 = **1** — Bronze 0, Silver 0.5, Gold 1.
(b) W1 (Gold, score 1) vs W3 (Bronze, score 0): contribution |1 − 0| = **1**.
(c) W1–W3 with three columns: age |30−20|/20 = 0.5, continent Asia = Asia → 0, medal → 1. Average: (0.5 + 0 + 1) / 3 = 1.5/3 = **0.5** — exactly what `daisy()` returns in Solution 4.

## Solution 4 — Confirm it in R

Real console output (R 4.3.3, `cluster` package):

```
> daisy(winners, metric = "gower")
Dissimilarities :
    1         2
2 0.6666667
3 0.5000000 0.8333333

Metric :  mixed ;  Types = I, N, O
```

(a) Pairwise Gower dissimilarities: W1–W2 = **0.6667**, W1–W3 = **0.5**, W2–W3 = **0.8333**. The three-column W1–W3 value (0.5) matches Solution 3(c) exactly.
(b) W1 and W3 are the most similar pair (0.5 — the smallest dissimilarity), the same moral as the lesson's Winner table: the pair sharing the most column-level agreements wins.

## Solution 5 — Which ruler, when?

(a) **Correlation distance** — "rise and fall together" is literally what r measures, and d = 1 − r ignores the ten-times sales difference.
(b) **Gower** — the row mixes a number, a label, and a ranking; Gower is built for exactly this.
(c) **Euclidean** — pure numbers, no mixing, no patterns to match: the straight-diagonal ruler is the honest default (after `scale()`, per CA-4).

## Solution 6 — Reading a daisy() matrix

(a) **E1–E3 (0.250)** are the most alike; **E2–E3 (0.720)** are the most different.
(b) A dissimilarity of 0 means the two rows are identical on every variable (per the column recipes). Gower averages so the result always stays on the [0, 1] scale no matter how many columns you have — a sum would grow with every new variable and stop being comparable.
