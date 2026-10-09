# CA-24 Solutions — Fuzzy Clustering: Belonging to Many

Worked solutions. The R script `solutions_fuzzy.R` reproduces every number
below (R 4.3.3, `cluster` + `factoextra`, `set.seed(123)`).

## Problem 1 — Hard vs soft

**Hard assignment** (k-means): every point gets exactly one cluster label.
A point is in or out — one home, no visitors. **Soft assignment** (fuzzy
clustering): every point gets a **membership coefficient** per cluster — a
number between 0 and 1 saying how strongly the point belongs to that
cluster. The membership coefficients of one point always add up to **1**:
100% of every point, divided between the clusters. Nothing gained, nothing
lost — just divided honestly.

## Problem 2 — Read the membership matrix

(a) **Arizona** leans most toward cluster 1: its cluster-1 share
(0.6862278) is the largest of the three (Alabama 0.6641977, Alaska
0.6098062).

(b) Arizona belongs most to **cluster 1**, so its hard label is **1** —
the hard label is simply the cluster with the biggest share.

(c) Every row sums to **1**. That is the honesty seal: the method
conserves belonging. If rows did not sum to 1, the method would be
inventing or losing belonging.

## Problem 3 — The rows-sum-to-one audit

(a) `min(rs)` = 1, `max(rs)` = 1. All 50 rows sum to exactly 1.

(b) A row summing to **more** than 1 would mean the method invents
belonging — the point claims more than 100% of itself. A row summing to
**less** than 1 would mean the method loses belonging — part of the point
is unaccounted for. Exactly 1 means the shares are a true division of the
whole point.

## Problem 4 — Delaware, the coin flip

(a) Delaware's top share is 0.5034392, so its two coefficients are
**0.5034392** and **1 − 0.5034392 = 0.4965608** — half and half.

(b) The hard label "2" hides the doubt: Delaware is essentially a coin
flip. The memberships tell the truth — Delaware belongs to both clusters
equally.

(c) 49 of the 50 states have their strongest membership **below 0.75** —
almost the whole country is torn between the two clusters. The one
exception is **Nebraska**, the most confident state, with top membership
**0.76601**.

## Problem 5 — Dunn's partition coefficient

(a) `dunn_coeff` = **0.5547365**, `normalized` = **0.1094731**.

(b) Our score 0.5547365 sits **just above the mush floor** of 0.5
(1/k for k = 2), far from the crisp score of 1. The normalized 0.11, near
zero, confirms it. The two groups overlap heavily — the fuzziness is real,
not decoration.

(c) **Fuzzy clustering is the honest tool here**: a Dunn score barely
above the mush floor plus 49-of-50 torn states means the data is a
spectrum, and a hard k-means label would be a polite lie.

## Problem 6 (stretch) — Read the two plots

(a) The two cluster ellipses **overlap like spilled paint** — no clean
gap, no tidy border. States in the overlap (Delaware, Oregon, New Jersey
and friends) are the torn ones: their memberships sit near 0.5/0.5.

(b) A low average silhouette width means points fit their cluster
**loosely** — they are visiting, not settled (1 = clearly at home, 0 = on
the fence). Averages of 0.32 and 0.44, both well below 0.5, agree with the
Dunn coefficient: these groups overlap, so the fuzzy answer is the honest
one.
