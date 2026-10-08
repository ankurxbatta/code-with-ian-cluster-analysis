# CA-17 Assignment — Baker's Gamma: Rank-Based Dendrogram Check

Try all five problems before looking at the solutions. One honest attempt beats a copied answer. You will need R (4.0 or newer) with the `dendextend` package (`install.packages("dendextend")`). Remember the big ideas: a merge rank says WHEN a pair of objects first lands in the same cluster (first merge earns the highest rank); Baker's gamma is the Spearman rank correlation of the two trees' merge-rank lists — it compares merge ORDER, never raw heights, so one giant height cannot hijack it; and the worksheet caution — Pearson on the rank lists is NOT the gamma.

---

## Problem 1 — Say it in plain English

(a) In your own words: what is a "merge rank"? For a tree built on 5 objects, what merge rank does a pair earn if the two objects join in the very first merge? What if they only join in the final merge? (Hint: the rank is 5 minus the merge step.)
(b) What is a rank correlation? Explain it without formulas — what does it compare, and what does it deliberately ignore?
(c) What is Baker's gamma? What are the two lists of numbers being rank-correlated?
(d) In one or two sentences: why is Baker's gamma called "outlier robust" while the cophenetic correlation is not? (Hint: which of the two ever looks at the actual height values?)

## Problem 2 — By hand: the five-object merge ranks

The worksheet gives 5 objects with pairwise distances: 9, 3, 6, 11, 7, 5, 10, 9, 2, 8 for the pairs (1,2), (1,3), (1,4), (1,5), (2,3), (2,4), (2,5), (3,4), (3,5), (4,5) in order.

The average-linkage tree merges: (3,5) at height 2.0, then (2,4) at 5.0, then (1,{3,5}) at 7.0, then everything at 8.1667.

(a) Without using R, write down the merge rank of all ten pairs for the average-linkage tree (rank = 5 − merge step).
(b) The ward.D2 tree merges: (3,5) at 2.0, then (2,4) at 5.0, then (1,{2,4}) at 8.3467, then everything at 11.3725. Write down the merge rank of all ten pairs for this tree.
(c) Which pairs have DIFFERENT merge ranks in the two trees? In one or two sentences, say what that disagreement means in plain English (which object's placement do the two trees disagree about?).
(d) Now check yourself in R with the `merge_ranks` helper from `solutions/verify_bakers.R`. Does your hand table match? If any pair differs, find your mistake before moving on.

## Problem 3 — Real R: the worksheet's two numbers

Run the worksheet code for real:

```r
library(dendextend)
item1 <- c(0,9,3,6,11)
item2 <- c(9,0,7,5,10)
item3 <- c(3,7,0,9,2)
item4 <- c(6,5,9,0,8)
item5 <- c(11,10,2,8,0)
mydist <- as.dist(rbind(item1, item2, item3, item4, item5))
hc1 <- hclust(mydist, method = "average")
hc2 <- hclust(mydist, method = "ward.D2")
dend1 <- as.dendrogram(hc1)
dend2 <- as.dendrogram(hc2)
cor_cophenetic(dend1, dend2)
cor_bakers_gamma(dend1, dend2)
```

(a) Write down both numbers (7 decimals). The cophenetic correlation is 0.8651635 and Baker's gamma is 0.503876.
(b) In one or two sentences: why do the two numbers disagree? Which one is looking at merge heights, and which one is looking at merge order?
(c) The course asks you to "show how" each number was obtained. For the cophenetic correlation, what are the two lists of ten numbers being correlated? (Hint: `cophenetic(hc1)`.) For Baker's gamma, what are the two lists? (Hint: Problem 2.)
(d) Apply the course rule from CA-16 (above 0.75 is a good tree): the cophenetic correlation says the two trees "look good" together. What does gamma 0.50 tell you that the cophenetic correlation missed?

## Problem 4 — Real R: the 0.8019802 trap

The worksheet shows this too:

```r
x <- c(1,2,1,2,1,3,1,1,4,1)
y <- c(2,1,2,1,1,3,1,1,4,1)
cor(x, y)                            # 0.8019802
cor.test(x, y, method = "spearman")  # rho = 0.503876
```

(a) What are `x` and `y`? (Where have you seen these two lists before — Problem 2 or 3?)
(b) What does `cor(x, y)` compute, and what does `cor.test(x, y, method = "spearman")` compute? Why are the two answers different?
(c) Which one is Baker's gamma, and why is the other one wrong for this job? (Hint: what does Pearson still do with the rank values that Spearman refuses to do?)
(d) A classmate says "0.80 is higher, so the trees agree more than gamma claims." In two sentences, explain their mistake.

## Problem 5 — Real R: the outlier demo

Add a sixth object whose distances to everything are 100:

```r
m6 <- rbind(cbind(rbind(item1, item2, item3, item4, item5), c(100,100,100,100,100)),
            c(100,100,100,100,100,0))
d6 <- as.dist(m6)
g1 <- hclust(d6, method = "average")
g2 <- hclust(d6, method = "ward.D2")
cor(cophenetic(g1), cophenetic(g2))          # 0.9997
```

(a) Write down the two trees' merge heights (`g1$height`, `g2$height`). Which merge is the giant one in each tree?
(b) The cophenetic correlation is now 0.9997 — "near perfect". In one or two sentences: is the agreement really near perfect? What does the giant final merge do to a Pearson correlation? (Hint: one huge value can dominate the whole calculation.)
(c) Compute the manual gamma with the `merge_ranks` helper from `solutions/verify_bakers.R`: rank each tree's 15 pairs, then `cor(r1, r2, method = "spearman")`. You should get about 0.873. In two sentences: why did the giant heights (100 and 128.95) not push gamma to 0.9997 as well?
(d) Decision time — in your own words, name two situations where you would reach for Baker's gamma instead of (or alongside) the cophenetic correlation. (Hint: the episode gives three; any two in your own words count.)
