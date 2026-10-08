# CA-19 Worked Solutions — Rand Index: External Validation

Try the problems yourself first. These solutions show every step.

---

## Problem 1 — Say it in plain English

(a) **External validation** grades a clustering against outside truth — labels the algorithm never saw during clustering, like the iris species column. **Internal validation** uses only the clustered data itself, with no outside labels — for example the silhouette width or the Dunn index (both internal), while the Rand index is external.

(b) Label names are arbitrary: "cluster 1" in one method might be called "cluster 2" in another, even when the groups are identical. Comparing labels directly would call identical groups different. Pairs sidestep this: asking "are these two objects together in both?" does not depend on what the groups are named. Example: truth = (1, 1, 2, 2) and yours = (2, 2, 1, 1) describe the same two groups, but no label matches.

(c) **a** = number of pairs grouped together in BOTH partitions. **b** = number of pairs kept apart in BOTH partitions. **n choose 2** = the total number of pairs the n objects can form, n(n − 1)/2. In words: Rand = (pairs that agree together + pairs that agree apart) ÷ (all possible pairs).

(d) Largest = **1**, reached when the two partitions agree on every single pair (identical groupings, even with different label names). Smallest = **0**, reached when no pair agrees at all (every pair is together in one partition and apart in the other).

---

## Problem 2 — By hand: the four-object example

(a) 4 objects → 4 choose 2 = 4 × 3 / 2 = **6 pairs**.

(b) Ground truth (1,1,2,2): A,B together; C,D together. Yours (1,1,1,2): A,B,C together; D alone.

| pair   | a | b | reasoning |
|--------|---|---|-----------|
| (A, B) | 1 | 0 | together in both → a |
| (A, C) | 0 | 0 | apart in truth, together in yours → disagreement |
| (A, D) | 0 | 1 | apart in both → b |
| (B, C) | 0 | 0 | apart in truth, together in yours → disagreement |
| (B, D) | 0 | 1 | apart in both → b |
| (C, D) | 0 | 0 | together in truth, apart in yours → disagreement |
| **total** | **1** | **2** | |

(c) R = (1 + 2) / 6 = 3/6 = **0.5**. Exactly half the pairs agreed.

(d) The three disagreement votes came from the pairs **(A, C), (B, C), (C, D)** — every one of them involves C. C is the borderline object: the truth put it with D, your clustering put it with A and B, and each of its three pairs with A, B, D disagrees. Lesson: one misplaced object costs as many votes as it has pairs, so the Rand index punishes borderline objects hard.

(e) Exactly the ground truth → every pair agrees → **R = 1**. Labels swapped, (2, 2, 1, 1) → the groups are identical, so every pair still agrees → **R = 1** again. Lesson: the Rand index grades the *groupings*, never the label names.

---

## Problem 3 — Real R: RRand on the six-object example and on iris

(a) Real console output:

```
> RRand(method1, method2)
   Rand adjRand  Eindex
 0.6667  0.2424 -0.0129
```

**Rand = 0.6667, adjusted Rand = 0.2424.**

(b) 15 pairs. Together in both: (1,2) — obs 1,2 are both in group 1 of truth and both in group 1 of method2 — and (5,6) — both in group 3 of truth and both in group 2 of method2. So **a = 2**. Apart in both: (1,4), (1,5), (1,6), (2,4), (2,5), (2,6), (3,5), (3,6) → **b = 8**. (2 + 8) / 15 = 10/15 = **0.6667** — matches R exactly.

(c) Real console output:

```
> RRand(km$cluster, as.integer(iris$Species))
   Rand adjRand  Eindex
 0.8797  0.7302  0.2231
```

**Rand = 0.8797, adjusted Rand = 0.7302.** Nearly 88% of all flower pairs agree between the k-means clusters and the true species — k-means recovered the species structure well; the adjusted 0.7302 says that agreement is far beyond what luck explains.

(d) Cluster 1 is the pure one: all 50 of its flowers are setosa. It contributes so many "a" votes because **every pair of setosa flowers** (50 choose 2 = 1,225 pairs) is together in the k-means clusters AND together in the truth — 1,225 automatic a-votes, about 40% of all the a-votes (a = 3,075 in total).

---

## Problem 4 — The weakness: random labels still get paid

(a) Real console output:

```
> RRand(as.integer(iris$Species), rand_iris)
    Rand  adjRand   Eindex
0.558031 0.001739 0.217209
```

**Rand = 0.558, adjusted Rand = 0.0017.** The plain Rand index "falls for" the luck (56% agreement from pure guessing); the adjusted Rand index subtracts it (0.0017 ≈ 0 — luck honestly scored).

(b) "Worse than random" means the random labels agreed with the truth *less* than chance alone would predict on average — the guess had a bias that actively worked against the true grouping. The adjusted Rand index can go negative exactly to report that.

(c) The plain Rand index pays for luck: even random labels score well above zero, so a high Rand score might mean "good clustering" or might mean "lucky guessing". The adjusted Rand index removes the chance-expected agreement, so a high adjusted score can only mean the clusters genuinely match the truth.

(d) The clustering with adjusted Rand **0.85** is actually better. Both have the same raw agreement (0.9), but 0.85 vs 0.40 after removing chance means the first clustering's agreement is real structure while much of the second's was luck.
