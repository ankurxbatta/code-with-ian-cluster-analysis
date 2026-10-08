# CA-20 Assignment — Dunn Index & Connectivity: Internal Validation

Try all five problems before looking at the solutions. One honest attempt beats a copied answer. You will need R (4.0 or newer) with the `fpc` and `clValid` packages (`install.packages(c("fpc", "clValid"))`). The two R scripts in this folder (`dunn_demo.R`, `connectivity_demo.R`) are the episode's real demos — run them yourself. Remember the big ideas: **internal validation** uses only the clustered data (no answer key); the **Dunn index** = (smallest inter-cluster distance) / (largest diameter), and **HIGH** means compact and well-separated clusters; **connectivity** scores each point's nearest neighbours — same cluster costs 0, the j-th neighbour in a different cluster costs 1/j — and **LOW** is better, with 0 meaning perfectly connected.

---

## Problem 1 — Say it in plain English

(a) In your own words: what is "internal validation"? How does it differ from the "external validation" you met in CA-19? Name the two internal measures from this episode.
(b) Define the **diameter** of a cluster and the **inter-cluster distance** in your own words. Then write the Dunn index formula in words (no symbols).
(c) The course notes hide a fill-in-the-blank: "If the dataset contains compact and well-separated clusters, the Dunn index will be ___." What goes in the blank, and why? Explain it through the numerator and the denominator.
(d) What does **connectivity** measure, in one sentence? Is a high or a low score better, and what would a score of exactly 0 mean?

## Problem 2 — By hand: the Dunn example

Four points sit on a number line at 1, 2, 5, and 6. A clustering algorithm puts {1, 2} in cluster 1 and {5, 6} in cluster 2.

(a) Compute the diameter of each cluster. What is the denominator of the Dunn index (the largest diameter)?
(b) List the cross-cluster pairs and find the smallest distance between members of different clusters. What is the numerator?
(c) Compute the Dunn index. Is that high or low, and what does it tell you about these two clusters?
(d) Now suppose the clusters were {1, 2} and {3, 4} instead (same tight clusters, but a much smaller gap). Recompute the Dunn index and compare it with part (c). What changed, and why?

## Problem 3 — By hand: the connectivity board example

Five points stand in a row: A, B, C, D, E. Cluster 1 = {A, B}, cluster 2 = {C, D, E}. B and C sit right next to each other (but in different clusters); A stands far to the left; D and E stand far to the right, together. The neighbour count is 2.

(a) Point A: name its 1st and 2nd nearest neighbours, the cost of each (same cluster = 0, j-th neighbour in a different cluster = 1/j), and A's total score.
(b) Point B: same thing — neighbours, costs, total.
(c) Point C: same thing — neighbours, costs, total.
(d) Points D and E: same thing. Then add up all five scores. What is the total connectivity?
(e) Where did most of the total come from — the border between the clusters, or the deep interior? Suppose C were moved far away from B, deep inside cluster 2. Recompute C's score and the new total. What does that teach you about what connectivity punishes?

## Problem 4 — Real R: Dunn and connectivity

Run the two scripts in this folder for real (`dunn_demo.R`, `connectivity_demo.R`).

(a) In the Dunn demo, what cluster labels did k-means assign to the 8 points? How many points landed in each of the 3 groups?
(b) What is the Dunn index for those 3 groups? It sits above 1 — in one sentence, what does "above 1" tell you about the gap versus the stretch?
(c) In the connectivity demo, what score does `connectivity(distance, cluster, neighbSize = 2)` return for the 10 points? (It should match your hand calculation style from Problem 3.)
(d) Change `neighbSize` to 1 and rerun. What is the new score — higher or lower than with 2? In one or two sentences, explain why the neighbour count changes the score, and why the course tells you this number will always be given.
(e) Verify the Problem 2 hand example in R: run `cluster.stats(dist(data.frame(x = c(1, 2, 5, 6))), c(1, 1, 2, 2))$dunn`. What do you get, and does it match your answer from Problem 2(c)?

## Problem 5 — The two judges side by side

(a) A clustering has a Dunn index of 0.4 and a connectivity of 0. Which judge is happy with this clustering, and which one is not? Explain each verdict in one sentence.
(b) Describe, in one or two sentences, what a clustering with a HIGH Dunn index AND a connectivity of 0 looks like. (Hint: think about what each score demands.)
(c) The `clValid` package can compute the Dunn index too, and next episode it lets whole algorithms compete on these internal measures. Why is it useful to have more than one internal judge instead of trusting a single number?
