# CA-17 Solutions — Baker's Gamma: Rank-Based Dendrogram Check

Work through the assignment first. These are the worked answers.

---

## Problem 1 — Say it in plain English

(a) A merge rank records WHEN a pair of objects first ends up in the same cluster: the merge step at which they join. Rank = 5 − merge step, so a pair joining in the very first merge earns rank 4, and a pair that only joins in the final merge earns rank 1. Early joiners get the high ranks.
(b) A rank correlation compares two ORDERINGS: does list A's first, second, third... match list B's first, second, third? It deliberately ignores the actual values — a height of 100 and a height of 8.2 are both just "the last merge". Spearman correlation is the standard way to compute one.
(c) Baker's gamma is the Spearman rank correlation of the two dendrograms' merge-rank lists: for every pair of objects, take its merge rank in tree 1 and its merge rank in tree 2, and rank-correlate the two lists. `0.503876` in the worksheet.
(d) The cophenetic correlation is a Pearson correlation on raw merge heights, so one gigantic height (an outlier's final merge) can dominate the whole number. Baker's gamma never looks at the heights at all — only at the merge order — so a giant height is just "the last merge" and cannot hijack the result. That is what makes it outlier robust.

## Problem 2 — By hand: the five-object merge ranks

Average-linkage merges: (3,5) step 1 → rank 4; (2,4) step 2 → rank 3; (1,{3,5}) step 3 → rank 2; everything step 4 → rank 1.

(a) Average-linkage merge ranks for pairs (12,13,14,15,23,24,25,34,35,45): **1, 2, 1, 2, 1, 3, 1, 1, 4, 1**.
Check a few: (3,5) joins at step 1 → rank 4. (2,4) joins at step 2 → rank 3. (1,3) and (1,5) first meet when 1 joins {3,5} at step 3 → rank 2. (1,2) only meets in the final merge → rank 1.

(b) Ward.D2 merge ranks for pairs (12,13,14,15,23,24,25,34,35,45): **2, 1, 2, 1, 1, 3, 1, 1, 4, 1**.
The difference from (a): step 3 joins (1,{2,4}) instead of (1,{3,5}), so (1,2) and (1,4) earn rank 2 here, while (1,3) and (1,5) drop to rank 1.

(c) The pairs with different ranks are (1,2), (1,3), (1,4), (1,5) — every pair involving object 1 except none. In plain English: the two trees agree on the early merges (3 with 5, 2 with 4) but disagree about WHERE object 1 belongs — with {3,5} under average linkage, with {2,4} under ward.D2.

(d) Run `Rscript verify_bakers.R` in this folder and compare. Both rank lists should match exactly.

## Problem 3 — Real R: the worksheet's two numbers

(a) `cor_cophenetic(dend1, dend2)` → **0.8651635**. `cor_bakers_gamma(dend1, dend2)` → **0.503876**.
(b) The cophenetic correlation looks at merge HEIGHTS (Pearson): both trees end in big final merges (8.1667 and 11.3725), so the height lists line up and the number looks good. Baker's gamma looks at merge ORDER (Spearman): the trees disagree on where object 1 joins, so the order lists only moderately agree.
(c) Cophenetic: the two lists are the cophenetic distances — for each of the ten pairs, the height in tree 1 where the pair first joins, and the height in tree 2 where the pair first joins (`cophenetic(hc1)` and `cophenetic(hc2)`). Gamma: the two lists are the merge-rank lists from Problem 2 — `x = c(1,2,1,2,1,3,1,1,4,1)` and `y = c(2,1,2,1,1,3,1,1,4,1)`.
(d) The cophenetic correlation says the trees' heights agree well; gamma 0.50 says the trees only moderately agree on STRUCTURE. Gamma caught the disagreement about object 1 that the heights hid — this is exactly why the course keeps both measures.

## Problem 4 — Real R: the 0.8019802 trap

(a) `x` and `y` are the two merge-rank lists from Problem 2(c) — the average-linkage ranks and the ward.D2 ranks.
(b) `cor(x, y)` is the PEARSON correlation of the rank lists: 0.8019802. `cor.test(x, y, method = "spearman")` is the SPEARMAN rank correlation: rho = 0.503876. (R warns "Cannot compute exact p-value with ties" — the rho value itself is still correct; the p-value is only approximate because of the tied ranks.)
(c) Baker's gamma is the Spearman value, 0.503876. Pearson treats the ranks as if they were measurements — a rank of 4 counts as "four times" a rank of 1 — which reintroduces the very magnitude sensitivity that ranking was supposed to remove. Spearman re-ranks and only asks about order, which is the whole point of the method.
(d) The classmate's mistake: 0.80 is not "more agreement", it is a different (and wrong-for-this-job) calculation. Pearson on ranks smuggles magnitudes back in; gamma deliberately uses Spearman so that only the merge order matters. Comparing the two numbers is comparing a ruler to a finishing order.

## Problem 5 — Real R: the outlier demo

(a) Average heights: **2, 5, 7, 8.1667, 100**. Ward.D2 heights: **2, 5, 8.3467, 11.3725, 128.9522**. The giant merge in each tree is the final one — object 6 joining everything at height 100 (average) and 128.9522 (ward.D2).
(b) No — the agreement is not near perfect. The two trees still disagree about object 1's placement, exactly as before. But one pair of enormous values (100 vs 128.95) dominates the Pearson calculation, dragging the correlation to 0.9997. The number is describing the outlier, not the trees.
(c) The manual gamma is **0.8730159**. The giant heights never entered because gamma only uses merge ranks: object 6's pairs all earn rank 1 (last merge) in BOTH trees, so they contribute tied "last" ranks, not hundred-scale values. Gamma stays honest — moderately high, not near perfect.
(d) Any two in your own words: (1) when an outlier or a very late giant merge might be dominating the heights; (2) when comparing linkages whose heights live on different scales (ward.D2's heights are squared distances, so raw-height comparisons are apples to oranges); (3) always, as a second opinion — if cophenetic and gamma disagree, dig into the merge order before trusting either tree.
