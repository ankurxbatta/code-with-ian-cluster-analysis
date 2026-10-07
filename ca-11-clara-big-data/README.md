# CA-11 Assignment — CLARA: Clustering for Large Datasets

Try all five problems before looking at the solutions. One honest attempt beats a copied answer. You will need R (4.0 or newer) with the `cluster` and `factoextra` packages (`install.packages(c("cluster", "factoextra"))`). Remember the big idea: CLARA runs PAM on small random samples, then picks the winner by measuring each candidate on the FULL dataset.

---

## Problem 1 — Why PAM is too slow on big data

PAM's swap phase checks k × (n − k) medoid↔outsider swaps per round, and every check reassigns every point and recomputes the whole cost.

(a) With n = 4 points and k = 2 medoids, how many swap checks per round? (Answer check: 4.)
(b) With n = 100,000 customers and k = 2, how many swap checks per round? Show the arithmetic.
(c) In one or two sentences: why does doubling n MORE than double PAM's work? (Hint: what happens to (n − k) when n doubles, and what else has to be recomputed per check?)
(d) The typed notes also call PAM "memory-heavy" on big data. What object grows as n squared?

## Problem 2 — The CLARA recipe, in your own words

(a) Define each term in plain English, as if explaining to a friend: **sample**, **sampsize**, **full-data cost**.
(b) Write CLARA's three steps in order: what does it draw, what does it run, and how does it pick the winner?
(c) Why is it fair to judge every candidate on the full dataset, even though each candidate was found on a small sample? (One or two sentences.)

## Problem 3 — Sampsize arithmetic

CLARA's default sampsize is 40 + 2k, capped at n (the number of rows).

(a) With k = 2 clusters, what is the sampsize? (Answer check: 44.)
(b) With k = 5 clusters, what is the sampsize?
(c) If your dataset has only n = 30 rows and k = 2, what sampsize does CLARA actually use? Why?
(d) In one sentence: why is running PAM on 44 points so much faster than running it on 100,000?

## Problem 4 — Real R: run the class demo

Run the class script's demo for real (this is the exact code from the episode):

```r
library(cluster)
library(factoextra)
set.seed(1234)
df <- rbind(cbind(rnorm(200, 0, 8), rnorm(200, 0, 8)),
            cbind(rnorm(300, 50, 8), rnorm(300, 50, 8)))
colnames(df) <- c("x", "y")
rownames(df) <- paste0("S", 1:nrow(df))

# 1. pick k with the silhouette (episode 8's method)
fviz_nbclust(df, clara, method = "silhouette") + theme_classic()

# 2. run CLARA
clara.res <- clara(df, 2, samples = 50, pamLike = TRUE)
print(clara.res)
```

(a) What k does the silhouette plot suggest? How do you read that from the plot?
(b) Report the two medoids (row labels AND their x, y coordinates) and the two cluster sizes. The data was built as 200 + 300 points — did CLARA recover the true split?
(c) Report the objective function value. In one sentence, what does that number measure?
(d) Run `head(clara.res$clustering, 10)`. Which cluster do the first ten points belong to, and why does that make sense given how the data was built?

## Problem 5 — Picking the winner + honest caveats

Suppose CLARA draws 3 samples (k = 2) and the full-data costs come out as:

| Sample | Full-data cost |
|--------|---------------|
| 1 | 10.41 |
| 2 | 9.88 |
| 3 | 10.02 |

(a) Which sample's medoids win, and why?
(b) A friend says "just average the three medoid sets instead of picking one." In one or two sentences, explain why CLARA measures instead of averaging.
(c) Your dataset has one tiny group of 12 points among 100,000. Each sample has 44 points. In one or two sentences, explain the risk — and what the R docs suggest you raise to fight it.
(d) `pamLike = TRUE` vs `pamLike = FALSE`: what does TRUE change about the swap phase inside each sample, and why did the class script choose TRUE?
