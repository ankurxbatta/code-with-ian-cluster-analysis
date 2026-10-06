# CA-3 Assignment — Binary Similarity Coefficients

Try all six problems before looking at the solutions. One honest attempt beats a copied answer. You will need R (4.0 or newer) with the `proxy` package for the R problems.

---

## Problem 1 — Label the 2×2 table

Two shoppers answered a yes/no survey about five products (1 = bought, 0 = did not buy):

| Product | 1 | 2 | 3 | 4 | 5 |
|---|---|---|---|---|---|
| Shopper C | 1 | 1 | 0 | 1 | 0 |
| Shopper D | 0 | 1 | 1 | 1 | 0 |

Build the 2×2 contingency table: count **a** (both 1), **b** (C=1, D=0), **c** (C=0, D=1), and **d** (both 0). The notes' study tip from the lesson: always label a, b, c, d first, before computing anything.

## Problem 2 — All three coefficients, by hand

Using your a, b, c, d from Problem 1, compute by hand:

(a) the simple matching coefficient: (a + d) / (a + b + c + d)
(b) the Jaccard coefficient: a / (a + b + c)
(c) the Dice coefficient: 2a / (2a + b + c)

Leave (a) as a fraction and, for practice, also write each answer as a decimal. Which coefficient gives the highest value here, and why does that make sense?

## Problem 3 — Symmetric or asymmetric? (choose the right coefficient)

Two datasets. For each, say whether the zeros are **symmetric** or **asymmetric**, and pick the coefficient you would use — simple matching or Jaccard. One sentence of reasoning each.

(a) A medical survey records whether each patient has high blood pressure (1 = yes, 0 = no). Two patients both have 0 for this trait.
(b) An ecologist records the presence (1) or absence (0) of 200 rare bird species across two islands. The two islands both have 0 for most species.

## Problem 4 — Similarity to dissimilarity

Take your three answers from Problem 2 and convert each to a **dissimilarity** using the lesson's rule: dissimilarity = 1 − similarity.

(a) What are the three dissimilarity values?
(b) Which pair — the most similar or the least similar shoppers — has the largest dissimilarity? Does that match your intuition for what "dissimilar" means?

## Problem 5 — Confirm it in R

Recreate the two shoppers from Problem 1 in R and let the computer check your hand work:

```r
library(proxy)
M <- rbind(C = c(1, 1, 0, 1, 0),
           D = c(0, 1, 1, 1, 0))
```

(a) Run `simil(M, method = "Dice")`, `simil(M, method = "Jaccard")`, and `simil(M, method = "simple matching")`. Do the three numbers match your Problem 2 answers exactly?
(b) Run `dist(M, method = "binary")`. What does this give you — a similarity or a dissimilarity? Which of your Problem 2 answers is it related to, and how?

## Problem 6 — Reading a similarity matrix

The course R code produced this Jaccard similarity matrix for four shoppers:

|        | C1   | C2   | C3   | C4   |
|--------|------|------|------|------|
| **C1** | 1.00 | 0.60 | 0.75 | 0.40 |
| **C2** | 0.60 | 1.00 | 0.50 | 0.85 |
| **C3** | 0.75 | 0.50 | 1.00 | 0.30 |
| **C4** | 0.40 | 0.85 | 0.30 | 1.00 |

(a) Which pair of shoppers is the most similar? Why is the diagonal all 1.00?
(b) Shoppers C1 and C3 currently have counts a = 3, b = 1, c = 0, d = 1 (check: Jaccard = 3/4 = 0.75, matching the matrix). Two new survey questions are added, and both C1 and C3 answer 0 to both. Recompute the Jaccard similarity and the simple matching similarity. Which one changed? Explain in one sentence why the other one didn't.
