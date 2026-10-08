# CA-21 Assignment — clValid: Which Algorithm Wins?

Try all five problems before looking at the solutions. One honest attempt beats a copied answer. You will need R (4.0 or newer) with the `clValid` package (`install.packages("clValid")`; it will also load `cluster`). The R script in this folder (`clvalid_demo.R`) is the episode's real demo — run it yourself. Remember the big ideas: **clValid** is a tournament referee — you hand it your data, a list of clustering algorithms, and the cluster counts to try, and it scores every combination with validation measures; **internal validation** uses only the clustered data (no answer key); the three judges are **connectivity** (LOW wins), the **Dunn index** (HIGH wins), and the **silhouette score** (HIGH wins).

---

## Problem 1 — Say it in plain English

(a) In your own words: what does the `clValid` function do? What are its four main arguments in this episode (`df`, the cluster counts, the method list, `"internal"`), and what does each one mean?
(b) On the iris data, the call tries 3 algorithms at cluster counts 2 through 6. How many clustering runs is that in total? Why is doing it in one call better than running each combination by hand?
(c) The `summary()` output has four blocks: the clustering methods, the cluster counts, the validation measures, and the optimal scores. In one sentence each, say what the validation-measures block and the optimal-scores block tell you.

## Problem 2 — Real R: run the tournament

Run `clvalid_demo.R` for real.

(a) Look at the connectivity row of the scoreboard. What score did all three methods get at 2 clusters? What does PAM score at 6 clusters? Which is better, and why?
(b) Look at the Dunn row. What did k-means score at 3 clusters — and what does a Dunn index near zero tell you about the clusters? Which method holds up best at 3 and 4 clusters?
(c) Look at the silhouette row. What did all three methods score at 2 clusters? As the cluster count grows to 6, do the averages go up or down, and what does that say about splitting the flowers into more groups?
(d) Read the Optimal Scores table (or run `optimalScores(intern)`). Which method and cluster count wins on each of the three measures?

## Problem 3 — The tie: same scores, three algorithms

At 2 clusters, hierarchical, k-means, and PAM all scored exactly 0.9762 on connectivity, 0.2674 on Dunn, and 0.5818 on silhouette.

(a) Run these three lines in R and look at the tables:
`hc2 <- cutree(hclust(dist(df), method = "average"), 2)`
`km2 <- kmeans(df, 2, nstart = 25)$cluster`
`pm2 <- cluster::pam(df, 2)$clustering`
then `table(hc2, km2)` and `table(hc2, pm2)`. Did the three methods produce the same clusters, or different ones?
(b) In one or two sentences: why does finding the *same* clusters explain the *identical* scores?
(c) Run `table(hc2, iris$Species)`. Which species sits alone in cluster 1, and how many flowers are in each cluster? In one sentence, why is this the "easy split" every algorithm finds?

## Problem 4 — The crown question

(a) The Optimal Scores table crowns hierarchical with 2 clusters — even though all three methods tied at 2 clusters. Re-run the tournament with the method list reordered as `c("pam", "kmeans", "hierarchical")`. What does the Optimal Scores table say now?
(b) Did the data change between your two runs? Then why did the winner change? Explain the tie-break rule in one sentence.
(c) A friend says: "clValid says hierarchical is the best algorithm for iris." Using what you learned in (a) and (b), correct them in one or two sentences.

## Problem 5 — The plots decide

(a) Run `plot(intern)` (the tournament object from the demo). It draws the silhouette curves for the three methods. Describe the shape in one sentence: where do the three lines start, and where do they go as the cluster count grows?
(b) Build the hand-made Dunn plot from the demo script (Dunn index against the cluster count, one line per method). At which cluster count do all three lines meet? After that, which method's line stays on top through 3 and 4 clusters?
(c) In one or two sentences: what do these two plots add that the Optimal Scores table alone does not show you?
