# CA-16 Assignment — Verifying Dendrograms: Cophenetic Correlation

Try all five problems before looking at the solutions. One honest attempt beats a copied answer. You will need R (4.0 or newer). Problems 4 and 5 need the `dendextend` package (`install.packages("dendextend")`). Remember the big ideas: the cophenetic distance between two observations is the height in the tree where they first join; the cophenetic correlation correlates those tree heights with the original pairwise distances; closer to 1 means the tree reflects the data well; and the course rule is that above 0.75 is a good tree.

---

## Problem 1 — Say it in plain English

(a) In your own words: what is a cophenetic distance? How do you read one off a dendrogram?
(b) What is the cophenetic correlation? What are the two lists of numbers being correlated?
(c) State the course rule for judging the number. If a tree scores 0.62, what do you conclude, in plain English?
(d) In one or two sentences: why does a high cophenetic correlation make average linkage popular? (Hint: it is not that average is "the best" at everything.)

## Problem 2 — Real R: the WS11 example

Run the episode's exact worked example for real:

```r
data <- c(7, 10, 22, 24)
d <- dist(data)
hc <- hclust(d, method = "ward.D")
coph <- cophenetic(hc)
cor(d, coph)
```

(a) What does `dist(data)` compute? Write down all six pairwise distances and say, in one sentence, how each is calculated from the four numbers.
(b) What does `hc$height` print? Explain in plain English what each of the three numbers means.
(c) What does `cophenetic(hc)` return? Pick the pair (1, 3) and explain, using the merge heights, why its cophenetic distance is what R prints.
(d) What does `cor(d, coph)` print (round it to 4 decimals)? Apply the course rule: is this a good tree?

## Problem 3 — By hand: the cophenetic table

You are given a dendrogram of the same four items with merge heights: items 3 and 4 join at height 2, items 1 and 2 join at height 3, and the two pairs join at height 26.5.

(a) Without using R, write down the cophenetic distance for all six pairs: (1,2), (1,3), (1,4), (2,3), (2,4), (3,4).
(b) The original distances are 3, 15, 17, 12, 14, 2 (in pair order). For the pair (3, 4): the original distance is 2 and the cophenetic distance is 2 — an exact match. For the pair (1, 3): the original distance is 15 but the cophenetic distance is 26.5. In one or two sentences, explain why the tree "stretches" this pair.
(c) Now check yourself in R with `cophenetic(hc)` from Problem 2. Does your hand table match? If any pair differs, find your mistake before moving on.

## Problem 4 — Real R: the linkage shootout

Same four items, three more trees:

```r
s_single   <- cor(d, cophenetic(hclust(d, method = "single")))
s_average  <- cor(d, cophenetic(hclust(d, method = "average")))
s_complete <- cor(d, cophenetic(hclust(d, method = "complete")))
c(s_single, s_average, s_complete)
```

(a) Write down the three scores (4 decimals). Which linkage method scores highest?
(b) All three scores clear 0.75. In plain English, why is this shootout "too easy" — why can't it separate the methods well? (Hint: how many data points are there?)
(c) The course notes star the finding that average linkage tends to produce high values of this statistic. In one or two sentences, connect that finding to why average linkage is so widely used.

## Problem 5 — Real R: do two trees agree?

Run the episode's second-half demo for real (needs `dendextend`):

```r
library(dendextend)
df <- scale(USArrests)
set.seed(123)
df <- df[sample(1:50, 10), ]
hc1 <- hclust(dist(df), method = "average")
hc2 <- hclust(dist(df), method = "ward.D2")
dend1 <- as.dendrogram(hc1)
dend2 <- as.dendrogram(hc2)
cor(dist(df), cophenetic(hc1))
cor(dist(df), cophenetic(hc2))
cor_cophenetic(dend1, dend2)
dend_list <- untangle(dendlist(dend1, dend2), method = "step1side")
entanglement(dend_list)
```

(a) Write down the two tree-vs-data correlations (4 decimals). Do they clear 0.75? What does that tell you about these two trees?
(b) What does `cor_cophenetic(dend1, dend2)` print? In plain English, what question does this number answer — and how is it different from the two numbers in part (a)?
(c) What does `entanglement(dend_list)` print after untangling? Is a low or a high value better, and what does the value you got mean for the tanglegram layout?
(d) Put it together in two or three sentences: the two trees score below 0.75 against the data, yet nearly 1.0 against each other. Is that a contradiction? Explain.
