# CA-14 Assignment — Hierarchical K-means: The Best of Both

Try all five problems before looking at the solutions. One honest attempt beats a copied answer. You will need R (4.0 or newer) with the `factoextra` package installed. Remember the big ideas: hierarchical k-means (`hkmeans`) is the hybrid — build the hierarchical tree, cut it for an initial partition, then let k-means refine it; k-means is sensitive to random starts (a bad start traps it in a local minimum — a pretty good answer that blocks the best one); the tree is fully deterministic, so the cut hands k-means a smart start instead of a dice roll; and the final partition can differ slightly from the initial cut because k-means improves it.

---

## Problem 1 — The hybrid in plain English

(a) Name the three stages of hierarchical k-means, in order.
(b) What is a local minimum, in your own words? Why is it k-means' famous weakness?
(c) The tree is "deterministic." What does that mean, and why does it make the tree's cut a better starting partition than random centers?
(d) The lecture script carries a note: the final partition can differ slightly from the initial cut. In one or two sentences, explain why.

## Problem 2 — Real R: the hkmeans call

Run the episode's exact demo for real (this needs `library(factoextra)`):

```r
df <- scale(USArrests)
res.hk <- hkmeans(df, 4)
names(res.hk)
res.hk$size
res.hk$iter
res.hk$tot.withinss
```

(a) How many pieces does `names(res.hk)` list? Name any five of them.
(b) What are the four group sizes in `res.hk$size`? What does `size` count?
(c) What is `res.hk$iter`? In plain English, what did k-means do that many times?
(d) What is `res.hk$tot.withinss`, and what does it measure? (Answer check: about 56.40.)

## Problem 3 — The cut proposes, k-means improves

The tree is stored inside the result, so you can compare the initial cut with the final answer:

```r
table(cutree(res.hk$hclust, k = 4))   # the initial partition
table(res.hk$cluster)                # the final partition
```

(a) Write down both tables. Did any group's headcount change?
(b) How many states switched groups between the initial cut and the final answer? (Answer check: 3. Hint: for each group, match it to the final group it overlaps most, then count the movers.)
(c) Name the states that moved. (No peeking — compute it first.)
(d) In one or two sentences: does this confirm or contradict the lecture script's note? Explain.

## Problem 4 — The reproducibility demo

Plain k-means with a single start is a dice roll. See it for yourself:

```r
set.seed(1); km1 <- kmeans(df, 4, nstart = 1)
set.seed(2); km2 <- kmeans(df, 4, nstart = 1)
km1$tot.withinss
km2$tot.withinss
```

(a) Write down both `tot.withinss` values. (Answer check: one is about 69.87, the other about 56.40.)
(b) Which try landed in the local minimum trap, and how can you tell from the numbers?
(c) Now run `hkmeans(df, 4)` twice and compare `tot.withinss` and the cluster assignments. Do the two runs agree?
(d) In two or three sentences: when does hierarchical k-means beat plain k-means, and why?

## Problem 5 — Think: limits and defaults

(a) The tree costs real compute. For a dataset with a million rows, would you reach for `hkmeans`? What would you use instead (hint: episode 11)?
(b) By default, which linkage method does `hkmeans` use to grow its tree, and which distance does it use? (Hint: check `args(hkmeans)` in R, and recall the industry pick from episode 13.)
(c) `fviz_dend(res.hk)` draws the tree and `fviz_cluster(res.hk)` draws the final groups. In one sentence each: what is stage 2's visual, and what is stage 3's visual?
