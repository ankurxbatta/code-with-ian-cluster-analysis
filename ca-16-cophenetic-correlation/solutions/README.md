# CA-16 Solutions — Verifying Dendrograms: Cophenetic Correlation

Worked solutions. If you have not tried the problems yet, go back — one honest attempt beats a copied answer. The script `verify_cophenetic.R` in this folder runs every R computation below so you can check your own console against it.

---

## Problem 1 — Say it in plain English

(a) A cophenetic distance is the tree's version of the distance between two observations: the height in the dendrogram at which the two observations first land in the same cluster. You read it off the y-axis — find the lowest horizontal merge bar that sits above both leaves and read its height.
(b) The cophenetic correlation is the correlation between two lists of six numbers (for four items): list 1 holds the original pairwise distances from `dist()`, and list 2 holds the cophenetic (tree-height) distances from `cophenetic(hc)`. It measures how tightly the tree's distances move with the real distances.
(c) The course rule: above 0.75 is a good tree. A score of 0.62 falls short, so you read that tree with suspicion — its merges distort the data more than the course accepts.
(d) Average linkage tends to score highest on cophenetic correlation, so its trees mirror the data more faithfully than its rivals'. That faithfulness is one reason practitioners reach for it so often.

## Problem 2 — Real R: the WS11 example

(a) `dist(data)` computes all six Euclidean pairwise distances. With one variable, Euclidean distance is just the absolute difference: |10−7| = 3, |22−7| = 15, |24−7| = 17, |22−10| = 12, |24−10| = 14, |24−22| = 2.
(b) `hc$height` prints `2.0 3.0 26.5`. In order: items 3 and 4 merge at height 2, items 1 and 2 merge at height 3, and the two pairs merge at height 26.5.
(c) `cophenetic(hc)` returns the tree-height distance table. Pair (1, 3): item 1 sits in the (1,2) branch and item 3 sits in the (3,4) branch, so they first join at the final merge — height 26.5, which is what R prints.
(d) `round(cor(d, coph), 4)` prints `0.9675`. That clears 0.75 with room to spare: a good tree, faithfully representing the four items.

## Problem 3 — By hand: the cophenetic table

(a) (1,2): 3; (3,4): 2; (1,3), (1,4), (2,3), (2,4): 26.5 each.
(b) Items 1 and 3 live in different first-round pairs, so the tree cannot join them until the final merge — the tree "rounds up" their distance to the pair-of-pairs height, 26.5, stretching the original 15.
(c) `cophenetic(hc)` prints exactly the table from (a): 3.0 for (1,2), 2.0 for (3,4), 26.5 for the four cross pairs. If any of yours differ, re-trace which merge first puts both items in one branch.

## Problem 4 — Real R: the linkage shootout

(a) Single: 0.9678; average: 0.9679; complete: 0.9678. Average scores highest — by a hair.
(b) Four points make only six pairs and three merges, so every reasonable tree looks good; the data is too simple to separate the methods. On real data with real noise, the gaps grow and the choice matters.
(c) Because average linkage's trees track the original distances most faithfully (highest cophenetic correlation), practitioners trust its pictures more — faithfulness is a practical reason behind its popularity, exactly what the course notes star.

## Problem 5 — Real R: do two trees agree?

(a) Tree 1 (average) vs data: 0.6929. Tree 2 (ward.D2) vs data: 0.6886. Neither clears 0.75 — on ten states in four dimensions, both trees distort the data somewhat, so read them with a little suspicion.
(b) `cor_cophenetic(dend1, dend2)` prints 0.9926. It answers "do these two trees tell the same story?" by correlating one tree's cophenetic distances with the other's — tree-vs-tree instead of tree-vs-data. The part (a) numbers grade each tree against the data; this one grades the trees against each other.
(c) After `untangle(dend_list, method = "step1side")`, `entanglement(dend_list)` prints 0. Lower is better, and 0 means perfect alignment — the tanglegram's connecting lines run straight with no crossings. (Without the untangle step, R prints about 0.094 — the trees start slightly rotated.)
(d) No contradiction. Each tree is an imperfect compression of 45 distances into 9 heights (both below 0.75), but the two methods distort in the same way, so they agree with each other almost perfectly (0.9926). Agreement is not perfection: two trees can tell the same slightly-wrong story.
