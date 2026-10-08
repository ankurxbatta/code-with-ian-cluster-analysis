# CA-18 Solutions — P-values for Hierarchical Clusters (pvclust)

Worked solutions. If you have not attempted the problems yet, go back and try — the value is in the attempt.

---

## Problem 1 — Say it in plain English

(a) A bootstrap copy is a new dataset made by drawing rows from your own data **with replacement**: reach in, pull a gene out, write it down, put it back, repeat. With 916 genes you draw 916 times, so the copy has 916 genes — but because each draw is replaced, some genes get picked twice and some never get picked. Same size, same columns, rows shuffled with repetition.
(b) A bootstrap replicate of a tree is a tree grown on one bootstrap copy of the data. The original tree grows on the real data; each replicate grows on a resampled copy, so it is a "new opinion" about the same underlying structure.
(c) BP is the share of regrown trees in which the cluster appears. 94 of 100 → **BP = 94%**.
(d) AU is the bias-corrected version: pvclust repeats the bootstrap at many data sizes (multiscale: r = 0.5 … 1.4), fits a curve through the appearance counts, and extrapolates back to the true size. The package prints both because BP is the raw, honest count while AU is the careful recount — and they can disagree.
(e) It promises that the cluster is not a fluke of this one dataset: it survived resampling at many sizes, so the data genuinely supports it. It does NOT promise the cluster is biologically "true" — only that it is statistically sturdy.

## Problem 2 — Read the edges table

(a) Strongly supported = AU >= 95%: edges **7** (100%), **23** (95.0%), and **25** (99.2%). Those three get `pvrect` rectangles. Edges 15 (63.4%) and 28 (94.9%) do not — 28 misses the bar by 0.1.
(b) BP alone (73%) says the cluster reappears only moderately often — you would call it shaky. AU (99.2%) says: after correcting for the bias of fixed-size bootstrapping, this cluster is strongly supported. The red number did the extra work; trust it first.
(c) The raw count can be fooled. At the single fixed bootstrap size, the resampled datasets happen to reproduce that cluster almost always (BP 99.0%), but across sizes the support falls apart — the multiscale extrapolation sees through it and reports AU 63.4%. Bias cuts both ways: BP can be too high as well as too low.
(d) Because its AU (94.9%) is below the 95% bar, even by a hair. The lesson: height and position do not vote — support votes. A huge top-level split can still be uncertain, and a dendrogram without p-values would never tell you that.

## Problem 3 — Real R: your own pvclust run

(a) The S1–S4 cluster should show AU ≈ 99–100% and BP ≈ 85–95% (exact values vary with seed) — yes, strongly supported. The three synthetic groups were built with a ±1.5 shift, so the true structure is loud.
(b) You should see 2–3 rectangles (the three true groups, sometimes minus one if a group is borderline at nboot = 100). They mark the same clusters whose AU cleared 95% in (a).
(c) `pvpick(res)$edges` returns the edge numbers of the significant clusters — the same edges the rectangles surround. The picker and the picture agree.
(d) The AU values change a little (a few percentage points). A bootstrap number is a Monte-Carlo estimate: different random resamples give slightly different counts, so the value wiggles. That is also why the package reports standard errors (`se.au`) — and why production work uses nboot = 1000 to shrink the wiggle.

## Problem 4 — By hand: counting support

(a) **BP = 94%** (94 of 100).
(b) The counts rise with size, so the trend points upward at the true size — the extrapolated AU will be **higher** than the raw BP. The fixed-size count was underestimating support because small datasets break the cluster more easily.
(c) The counts fall with size, so the extrapolated AU will be **lower** than the BP (roughly in the mid-80s). AU < 95% → **not strongly supported**, even though the raw 94% looked close.
(d) A single size can systematically over- or under-count a cluster's support; measuring at many sizes and extrapolating removes that size bias, so the number reflects the cluster rather than the bootstrap settings.

## Problem 5 — The interpretation challenge

(a) "BP = 96% only says the cluster reappears at one fixed resample size — and that count can be biased upward, exactly what we saw with edge 15 in the episode (BP 99, AU 63.4). AU repeats the experiment at ten different data sizes and extrapolates, and it lands at 61%, well below the 95% bar. The raw vote looked great; the careful recount says the support does not survive a change of size. I am not convinced."
(b) Yes, support the cut. AU = 99% is the number that did the extra multiscale work, and it clears the 95% bar comfortably — the cluster is strongly supported. BP = 71% is the raw count being conservative here (the same direction as edge 25 in the episode). Read the red number first.
(c) Trust the average-linkage version (AU 97% clears the bar; Ward's 88% does not). Next: inspect *why* they differ — plot both trees with `pvrect`, check whether Ward's lower support comes with a higher standard error, and consider reporting the branch with the caveat rather than silently picking the prettier tree.
(d) You gain speed — 10 bootstraps finish in minutes instead of hours. You risk noise: with 10 resamples the AU/BP estimates (and especially the multiscale curve fit) are extremely wiggly, rectangles may appear or vanish on re-run, and a 94% vs 96% call becomes a coin flip. The honest middle ground from the episode: 100 bootstraps is affordable and stable enough for exploration; save 1000 for the final published tree.

---

## Verify in R

`verify_pvclust.R` reproduces the episode's real numbers (dim 916 x 73, 30 sampled columns, the edges table, the three rectangles). Run it with `Rscript verify_pvclust.R` and compare its output to `res.pv$edges` in your own session.
