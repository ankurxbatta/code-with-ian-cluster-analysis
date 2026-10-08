# CA-18 Assignment — P-values for Hierarchical Clusters (pvclust)

Try all five problems before looking at the solutions. One honest attempt beats a copied answer. You will need R (4.0 or newer) with the `pvclust` package (`install.packages("pvclust")`). Remember the big ideas: a dendrogram shows structure but never confidence; the bootstrap resamples your data (with replacement) and regrows the tree many times; **BP** (bootstrap probability) is the raw share of regrown trees where a cluster reappears; **AU** (approximately unbiased) repeats the count at many data sizes (multiscale) and extrapolates back — it corrects BP's bias, so read the red number first; the course rule is AU >= 95% means strongly supported, and `pvrect` draws rectangles around exactly those clusters.

---

## Problem 1 — Say it in plain English

(a) In your own words: what is a "bootstrap copy" of a dataset? If your data has 916 genes, how many genes does one bootstrap copy have, and why can the same gene appear twice in it?
(b) What is a "bootstrap replicate" of a tree? How is it different from the original tree?
(c) What is the BP score of a cluster, in plain English? If a cluster appears in 94 of 100 regrown trees, what is its BP?
(d) What is the AU score, and how does it differ from BP? Why does the package bother computing both?
(e) In one or two sentences: what does "AU >= 95% means strongly supported" actually promise you about a cluster?

## Problem 2 — Read the edges table

Here is a (real) excerpt from the episode's `res.pv$edges` table, AU and BP as percentages:

| edge | AU % | BP % |
|------|------|------|
| 7    | 100  | 100  |
| 15   | 63.4 | 99.0 |
| 23   | 95.0 | 83.0 |
| 25   | 99.2 | 73.0 |
| 28   | 94.9 | 55.4 |

(a) Which of these five clusters are "strongly supported" by the course rule? Which ones get a `pvrect` rectangle?
(b) Edge 25 has AU 99.2% but BP only 73%. If you only saw the green number (BP), what would you conclude? What does the red number (AU) tell you instead?
(c) Edge 15 shows the reverse: BP 99.0% but AU 63.4%. In one or two sentences, explain why "the raw count looks perfect but the corrected score says no" can happen.
(d) Edge 28 is the very top split of its half of the tree, yet it gets no rectangle. Why not? What does this teach you about big, high branches?

## Problem 3 — Real R: your own pvclust run

Run this for real (it uses a small synthetic dataset so it finishes fast — the ideas are identical to the lung demo):

```r
library(pvclust)
set.seed(42)
# 40 genes, 12 samples in 3 true groups
grp <- rep(1:3, each = 4)
x <- matrix(rnorm(40 * 12), nrow = 40)
x[, grp == 2] <- x[, grp == 2] + 1.5
x[, grp == 3] <- x[, grp == 3] - 1.5
colnames(x) <- paste0("S", 1:12)
res <- pvclust(x, method.dist = "cor", method.hclust = "average", nboot = 100)
```

(a) Print `res$edges` and find the AU and BP of the cluster containing S1, S2, S3, S4. Is it strongly supported?
(b) Run `plot(res, hang = -1, cex = 0.8)` and then `pvrect(res)`. How many rectangles do you see? Do they match your answer in (a)?
(c) Run `pvpick(res)$edges`. What does it return, and how does that relate to the rectangles?
(d) Re-run the whole thing with `set.seed(7)` instead of `set.seed(42)`. Do the AU values change a little or a lot? In one sentence, say why a bootstrap-based number is never exactly reproducible across seeds.

## Problem 4 — By hand: counting support

A tiny bootstrap experiment regrows a tree 100 times. Cluster C = {S1, S2} appears in 94 of the 100 regrown trees.

(a) What is the BP of cluster C?
(b) Suppose the multiscale counts for cluster C are: at r = 0.5 it appears 80 times, at r = 1.0 it appears 94 times, at r = 1.4 it appears 98 times. The counts RISE as the data size grows. In one or two sentences, say whether the AU (extrapolated back to the true size) will be higher or lower than the raw BP, and why.
(c) Now suppose a different cluster D appears 99 times at r = 0.5, 94 times at r = 1.0, and 88 times at r = 1.4. The counts FALL as the data size grows. Will D's AU be higher or lower than its BP? Is D strongly supported?
(d) In one sentence: why does fitting a curve across sizes and extrapolating give a fairer number than the single-size count?

## Problem 5 — The interpretation challenge

(a) A colleague shows you a dendrogram branch with BP = 96% and says "this cluster is rock solid." You run pvclust and find AU = 61%. Write two or three sentences explaining to them, in plain English, why you are not convinced — and what AU is correcting.
(b) Another branch has AU = 99% and BP = 71%. Your colleague wants to cut the tree right below this branch to define two groups for a report. Do you support the cut? Why? (Hint: which number did the extra work?)
(c) You compare average-linkage and Ward trees on the same data. One shared branch scores AU = 97% under average but AU = 88% under Ward. Which tree's version of that branch do you trust more, and what would you do next?
(d) `pvclust` on your 500-sample dataset with `nboot = 1000` has been running for two hours. Your teammate suggests `nboot = 10` "to get an answer today." In two or three sentences, explain the trade-off you are making — what do you gain and what do you risk?
