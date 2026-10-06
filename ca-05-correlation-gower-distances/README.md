# CA-5 Assignment — Correlation & Gower Distances

Try all six problems before looking at the solutions. One honest attempt beats a copied answer. You will need R (4.0 or newer) with the `cluster` package for the R problems.

---

## Problem 1 — Correlation distance by hand

Three weeks of spending:

- Shopper A: (1, 2, 3)
- Shopper B: (2, 4, 6)
- Shopper C: (3, 2, 1)

(a) A and B are perfectly proportional (B doubles A every week). What is Pearson's r between A and B, and what is the correlation distance d = 1 − r?
(b) C is exactly reversed relative to A. What is Pearson's r between A and C, and the correlation distance?
(c) In one sentence: why does correlation distance care about the *pattern* (moving together) and not the *wallet size*?

## Problem 2 — Gower by hand (quantitative + nominal)

Three award winners, with age (quantitative) and continent (nominal):

| Winner | Age | Continent |
|--------|-----|-----------|
| W1 | 30 | Asia |
| W2 | 40 | Europe |
| W3 | 20 | Asia |

The age range across all winners is 40 − 20 = 20.

Compute the Gower distance between W1 and W2 by hand: quantitative recipe |x − y| / range, nominal recipe 0 if same / 1 if different, then average the two column scores.

## Problem 3 — The ordinal recipe

Now add a medal column (ordinal): W1 = Gold, W2 = Silver, W3 = Bronze.

(a) Convert the medals to scores over [0, 1] using (rank − 1) / (number of levels − 1): what score does each medal get?
(b) For the W1–W3 pair, what is the medal column's contribution |x − y|?
(c) Recompute the Gower distance between W1 and W3 with all three columns (age range is still 20). How does it compare to what daisy() will give in Problem 4?

## Problem 4 — Confirm it in R

Build the three winners in R and let `daisy()` check your hand work:

```r
library(cluster)
winners <- data.frame(
  age       = c(30, 40, 20),
  continent = factor(c("Asia", "Europe", "Asia")),
  medal     = ordered(c("Gold", "Silver", "Bronze"),
                      levels = c("Bronze", "Silver", "Gold"))
)
daisy(winners, metric = "gower")
```

(a) What are the three pairwise Gower distances? Do they match your Problem 2 and 3(c) answers?
(b) Which winner pair is the most similar, and does that match the lesson's Winner-table moral?

## Problem 5 — Which ruler, when?

Three datasets. For each, pick the distance from {Euclidean, correlation distance, Gower} and give a one-sentence reason.

(a) Monthly sales curves of 50 stores — you want stores whose sales rise and fall together, even if one store sells ten times more.
(b) Customer profiles: age (number), subscription tier (Basic/Premium — nominal), satisfaction (low < medium < high — ordinal).
(c) Two lab sensors' voltage readings over time, no outliers, and you want absolute closeness of the readings.

## Problem 6 — Reading a daisy() matrix

The lesson's WS1a employees printed these Gower dissimilarities:

- E1–E2: 0.590
- E1–E3: 0.250
- E2–E3: 0.720

(a) Which two employees are the most alike? Which are the most different?
(b) A dissimilarity of 0 would mean what, in plain words? And why does Gower *average* the column scores instead of summing them?
