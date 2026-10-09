# CA-22 Assignment — Stability of Clustering: Does It Survive Losing a Column?

Try all five problems before looking at the solutions. One honest attempt beats a copied answer. You will need R (4.0 or newer) with the `clValid` package (`install.packages("clValid")`; it will also load `cluster`). The R script in this folder (`stability_demo.R`) is the episode's real demo — run it yourself. Remember the big ideas: **stability** = how little a clustering changes when each column is removed one at a time; the four judges are **APN** (average proportion of non-overlap, 0 to 1), **AD** (average distance, 0 to infinity), **ADM** (average distance between means, 0 to 1), **FOM** (figure of merit, 0 to 1); on every measure **smaller is better**.

---

## Problem 1 — Say it in plain English

(a) In your own words: what is a "stable" clustering? Describe the column-removal test in two or three sentences, as you would explain it to a friend.
(b) Define each of the four measures (APN, AD, ADM, FOM) in plain English — no formulas. For each one, give its range and say whether stable clusters score low or high.
(c) In the episode, APN on the iris data scored 0.003266667. Why does this number tell you the clustering is stable? What would a score of 0.5 mean, in plain English?

## Problem 2 — Real R: run the stability tournament

Run `stability_demo.R` for real.

(a) Look at the `optimalScores()` table. Which method and cluster count wins on each of the four measures?
(b) Read the APN scoreboard (the full grid of scores). What is the APN score for k-means with 2 clusters? What is it for k-means with 6 clusters? Is APN getting better or worse as the cluster count grows?
(c) Read the AD scoreboard. What is the AD score for PAM with 6 clusters? What is it for PAM with 2 clusters? Why does AD naturally favor higher cluster counts — and what mistake would you make if you used it to pick the number of clusters?
(d) Read the ADM scoreboard. Which method wins at 2 clusters, and what is the score? What is the second-best score, and which methods share it?

## Problem 3 — The APN formula, decoded

The course notes give the APN formula as:

```
APN(k) = 1/(M x N) * sum over i, sum over l of ( 1 - n(C^{i,l} n C^{i,0}) / n(C^{i,0}) )
```

(a) Say what each symbol means: `k`, `N`, `M`, `C^{i,0}`, `C^{i,l}`. For the iris demo in the episode, what are the values of `N` and `M`?
(b) In the episode's hand-worked example, flower 1 sits in a cluster of 50 flowers on the full data. After the Petal.Length column is removed, 49 of the 50 are still with it. Compute that flower's term in the sum for the Petal.Length removal. Show your work.
(c) For the other three column removals in that example, all 50 flowers stay together. What is flower 1's term for each of those removals? What does that tell you about this flower's contribution to the final APN?
(d) Explain why APN must land between 0 and 1. (Hint: what kind of average is it?)

## Problem 4 — The second-best table

(a) Fill in this table from the episode's R output — no guessing, read the scoreboards:

| Measure | Best (method, k, score) | Second best (method, k, score) |
|---------|------------------------|-------------------------------|
| APN     |                        |                               |
| AD      |                        |                               |
| ADM     |                        |                               |
| FOM     |                        |                               |

(b) Two of the four measures have a TIE for second best. Which measures, which methods, and what is the tied score in each case? What do those two measures have in common that explains the tie?
(c) The FOM second best is PAM with 5 clusters at 0.4788582. Which method sits right behind it at 5 clusters, and what is its score?

## Problem 5 — The split crown

On the iris data, APN and ADM crowned hierarchical with 2 clusters, while AD and FOM crowned PAM with 6 clusters.

(a) Why is "hierarchical wins" not the full story here? In one paragraph, say which kind of stability each side won, and when you would pick each.
(b) AD and FOM both crowned 6 clusters. The episode says you should use these measures to compare algorithms AT the same cluster count, not to pick the count itself. Explain why in your own words.
(c) Bonus: make a `plot(stab, measure = c("APN", "AD", "ADM"))` plot from the demo object, with a hand-built legend of the three methods. Which line sits lowest on the APN curve — and what does "lowest" mean for this measure?
