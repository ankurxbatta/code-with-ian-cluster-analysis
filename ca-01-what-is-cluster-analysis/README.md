# CA-1 Assignment — What Is Cluster Analysis?

Try all five problems before looking at the solutions. One honest attempt beats a copied answer.

## Problem 1 — Many valid groupings

A standard deck has 52 cards. Two perfectly valid ways to group it are **red vs black** (2 groups) and **by suit** — hearts, diamonds, clubs, spades (4 groups).

(a) Name **two more** valid ways to group the 52 cards.
(b) In one sentence, explain why there is no single "correct" grouping.

## Problem 2 — Clusters that aren't real

Clustering algorithms will happily find clusters even when the data has no real groups in it.

In plain words, why is this dangerous for someone analyzing customer data? (2–3 sentences.)

## Problem 3 — Classification or clustering?

For each situation, say whether it calls for **classification** or **clustering**, and give the reason in one sentence.

(a) A bank has records of past loan applicants labeled "repaid" or "defaulted", and wants to predict whether new applicants will repay.
(b) A biologist has gene measurements for 200 unlabelled cells and wants to discover the cell types present.

## Problem 4 — Know your families

Match each method to its clustering family — **partitioning**, **hierarchical**, **density-based**, or **model-based**:

(a) k-means · (b) agglomerative hierarchical · (c) DBSCAN · (d) PAM · (e) Gaussian mixture models · (f) divisive hierarchical

Bonus: which family forces you to choose the number of clusters **up front**, before running the algorithm?

## Problem 5 — Reading a dendrogram

Five points A–E are merged one step at a time at these heights: two points merge at height **1.0**, a third point joins them at **1.5**, a fourth joins at **2.5**, and finally all five come together at **5.0**.

(a) If you cut the tree at height **2.0**, how many clusters do you get, and which points are together?
(b) If you cut at height **4.0**, how many clusters do you get?
