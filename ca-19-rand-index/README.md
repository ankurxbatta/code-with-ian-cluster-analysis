# CA-19 Assignment — Rand Index: External Validation

Try all four problems before looking at the solutions. One honest attempt beats a copied answer. You will need R (4.0 or newer) with the `EMCluster` package (`install.packages("EMCluster")`). Remember the big ideas: **external validation** grades your clusters against outside truth (labels the algorithm never saw, like the iris species column), while **internal validation** (silhouette, Dunn, connectivity) uses only the data; the **Rand index** compares two partitions **pair by pair** — **a** = pairs together in both, **b** = pairs apart in both, **R = (a + b) / n choose 2**; random labels still score above zero on the plain Rand index, so the **adjusted Rand index** (corrected for chance, near zero for luck) is the preferred score.

---

## Problem 1 — Say it in plain English

(a) In your own words: what is "external validation"? How does it differ from "internal validation"? Name one measure of each kind that you met in this series.
(b) Why does the Rand index compare **pairs** of objects instead of comparing cluster **labels** directly? Give a one-sentence example of two clusterings that use different label names for the same groups.
(c) What do the letters **a**, **b**, and **n choose 2** mean in the Rand formula? Write the formula in words.
(d) What is the largest possible value of the Rand index, and when does it happen? What is the smallest possible value, and when does it happen?

## Problem 2 — By hand: the four-object example

The ground truth for objects A, B, C, D is (1, 1, 2, 2). Your clustering returns (1, 1, 1, 2).

(a) How many pairs are there in total? Show the n choose 2 calculation.
(b) Fill in the pair table (columns: pair, a, b):

| pair  | a | b |
|-------|---|---|
| (A, B) |   |   |
| (A, C) |   |   |
| (A, D) |   |   |
| (B, C) |   |   |
| (B, D) |   |   |
| (C, D) |   |   |

(c) Compute the Rand index from your table. What fraction of the pairs agreed?
(d) Object C sits on the border in this example. Which three pairs cast the disagreement votes, and what does that tell you about how the Rand index treats borderline objects?
(e) Now suppose your clustering returned exactly the ground truth, (1, 1, 2, 2). What is the Rand index? And what if it returned (2, 2, 1, 1) — the same groups, but with the label names swapped? What does that teach you?

## Problem 3 — Real R: RRand on the six-object example and on iris

Run this for real:

```r
library(EMCluster)
method1 <- c(1, 1, 2, 2, 3, 3)   # ground truth
method2 <- c(1, 1, 1, 2, 2, 2)   # a second method
RRand(method1, method2)
```

(a) The console prints Rand and adjusted Rand (ignore the third column, the E index — the course never uses it). What are the two numbers?
(b) By hand: six objects make 15 pairs. Count a and b yourself (hint: only pairs (1,2) and (5,6) are together in both) and verify that (a + b) / 15 matches the Rand index from R.
(c) Now the iris demo. Run:

```r
set.seed(42)
km <- kmeans(iris[, 1:4], centers = 3, nstart = 25)
RRand(km$cluster, as.integer(iris$Species))
```

What are the Rand and adjusted Rand values? In one or two sentences, say what a Rand index near 0.88 means about how well k-means recovered the three species.
(d) Look at the confusion table `table(km$cluster, iris$Species)`. One cluster is pure (all 50 flowers are setosa). Which of the three clusters is it, and in one sentence, why does that cluster contribute so many "a" votes?

## Problem 4 — The weakness: random labels still get paid

The plain Rand index pays for luck. Test it yourself:

```r
set.seed(7)
rand_iris <- sample(1:3, 150, replace = TRUE)   # pure guessing
RRand(as.integer(iris$Species), rand_iris)
```

(a) What are the Rand and adjusted Rand values for pure guessing on iris? Compare them: which number "falls for" the luck, and which one subtracts it?
(b) On the tiny six-object example, random labels give Rand 0.4667 but adjusted Rand −0.1111. A NEGATIVE adjusted Rand index — what does "worse than random" mean here, in plain English?
(c) In one or two sentences: why is the adjusted Rand index preferred over the plain Rand index whenever you have outside truth to compare against?
(d) Suppose two different clusterings of the same data both score Rand 0.9 against the ground truth, but their adjusted Rand scores are 0.85 and 0.40. Which clustering is actually better, and why?
