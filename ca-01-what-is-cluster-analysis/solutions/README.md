# CA-1 Solutions — What Is Cluster Analysis?

Read these only after attempting the assignment. If a solution confuses you, rewatch the episode section it refers to, then redo the problem from scratch.

## Problem 1 — Many valid groupings

(a) Any two sensible groupings earn full marks. Examples: **face cards (J/Q/K) vs number cards vs aces** (3 groups); **even ranks vs odd ranks** (2 groups); **red face cards vs everything else**. (b) There is no single correct grouping because a "good" grouping depends on the **question you are asking** — the deck carries no labels saying which grouping is right, so red/black and by-suit can both be correct at once.

## Problem 2 — Clusters that aren't real

If the algorithm invents customer segments out of pure noise, the analyst may "discover" groups of customers that don't really exist and then spend real marketing money targeting them. That is why clustering is never just "run the algorithm and trust it" — you check cluster tendency first (is the data even clusterable?), validate the result with indices like silhouette or Dunn, and sanity-check it against domain knowledge.

## Problem 3 — Classification or clustering?

(a) **Classification.** The bank already has labeled examples ("repaid"/"defaulted"), so this is supervised learning: learn from the labels and predict them for new applicants.
(b) **Clustering.** The biologist has no labels at all, so there is nothing to predict — this is unsupervised learning: discover the natural groupings in the data and see whether they look like cell types.

## Problem 4 — Know your families

(a) k-means → **partitioning** · (b) agglomerative hierarchical → **hierarchical** · (c) DBSCAN → **density-based** · (d) PAM → **partitioning** · (e) Gaussian mixture models → **model-based** · (f) divisive hierarchical → **hierarchical**.

Bonus: the **partitioning** family (k-means, PAM, CLARA) forces you to choose k up front. Hierarchical methods don't — you build the whole tree first and decide where to cut it afterwards.

## Problem 5 — Reading a dendrogram

The rule: a horizontal cut at height *h* gives **one cluster per branch that the cut line crosses**. Merges below the cut have already happened; merges above it haven't.

(a) Cut at 2.0: the merges at 1.0 and 1.5 have happened, the one at 2.5 has not. So you get **3 clusters**: the three points that merged by height 1.5 together as one cluster, and the other two points each alone.
(b) Cut at 4.0: the merge at 2.5 has now happened too, but the final merge at 5.0 has not. So you get **2 clusters**: a group of four points and one point alone.
