# CA-7 Assignment — Is Your Data Clusterable? Hopkins Statistic & VAT

Try all five problems before looking at the solutions. One honest attempt beats a copied answer. You will need R (4.0 or newer) with the `hopkins` package (`install.packages("hopkins")`) and `factoextra` for the VAT plot. Remember the hard rule: the `hopkins` package ONLY — never `clustertend` (its scale is reversed).

---

## Problem 1 — Predict, then verify (WS14 style)

Eight numbers on a line: 2, 2.3, 2.1, 15, 15.4, 14.8, 15.1, 2.5.

(a) Before touching R: look at the numbers. Do they huddle into groups, or spread evenly? Predict: will the Hopkins statistic come out near 1 or near 0.5? One sentence of reasoning.
(b) Verify in R:

```r
library(hopkins)
x <- c(2, 2.3, 2.1, 15, 15.4, 14.8, 15.1, 2.5)
mean(replicate(100, hopkins(matrix(x, ncol = 1), 5)))
```

Report the value. Which band does it fall in (0–0.3 regular, 0.3–0.7 random, 0.7–1 clusterable), and what does that tell you to do next?

## Problem 2 — Read the number

A classmate runs the Hopkins check on three datasets and reports H = 0.15, H = 0.52, and H = 0.83.

(a) Classify each one: regular, random, or clusterable?
(b) For each, say in one sentence what the analyst should do next (cluster it? pick k? walk away?).
(c) The 0.52 came from `runif(200, 0, 10)`. Why is "near 0.5" exactly what you expect for uniform random data? (Hint: x and y distances look the same, so the fraction is about one half.)

## Problem 3 — The reversed-scale trap

A forum answer tells you to use `clustertend::hopkins()` instead. You try it on the lesson's ten worksheet numbers and get 0.04.

(a) The `clustertend` scale is reversed: near 0 means clusterable there. The lesson's real answer with the `hopkins` package was H = 0.96. Show the arithmetic that converts one scale to the other (what operation turns 0.96 into about 0.04?).
(b) In two or three sentences, explain why mixing up the two packages is dangerous: what wrong decision would you make if you read 0.04 on the `hopkins` (0–1, high = clusterable) scale?

## Problem 4 — One run wobbles, one hundred settle

(a) Run a SINGLE Hopkins computation on the lesson's ten numbers and record it:

```r
library(hopkins)
x <- c(1, 1.2, 1.4, 21, 20.2, 19.8, 21, 21.2, 20, 21)
hopkins(matrix(x, ncol = 1), 5)
```

Run it three times. Do you get the same number each time? Why not? (Hint: what is freshly generated on every call?)
(b) Now run `mean(replicate(100, hopkins(matrix(x, ncol = 1), 5)))` three times. How much do the three answers differ? In one or two sentences, explain why the mean of 100 is the measurement and one H is just a draw.

## Problem 5 — Hand VAT, three items

Three items with Manhattan distances: P–Q = 2, P–R = 9, Q–R = 10.

(a) Write the 3×3 distance matrix (order P, Q, R; diagonal is 0).
(b) Reorder so friends sit together (which two are closest? put them first).
(c) Shade it by hand with the WS14a rule: under 6.5 → white, 6.5 or more → black. How many white blocks do you see on the diagonal? How many clusters does that suggest?
(d) Check yourself in R with `factoextra::fviz_dist()` on your matrix. Does the picture's block structure match your hand shading? (Red = small distances, blue = large — the same idea in colour.)
