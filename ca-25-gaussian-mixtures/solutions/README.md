# CA-25 Solutions — Model-Based Clustering: Gaussian Mixtures

Worked solutions. The R script `solutions_mclust.R` reproduces every number
below (R 4.3.3, `mclust` 6.1.3 + `MASS`, `set.seed(42)`).

## Problem 1 — Gaussian, mixture, component, covariance

(a) **Gaussian**: the normal curve — the bell curve. Its **center** is the
mean (the average); its **width** is the standard deviation (the typical
spread). A wide bell means points scatter far; a narrow bell means they
huddle close.

(b) **Mixture**: a blend — several bell curves poured into one bowl of
data. Each **cluster** is one bell curve in the blend; each point was drawn
from exactly one of the curves, but we do not know which one. That is the
puzzle model-based clustering solves.

(c) **Component**: the model word for one bell curve in the mixture. For
us, a component is a cluster — three components, three clusters.

(d) **Covariance**: how two variables move together — the tilt of the
multivariate bell. Taller people tend to weigh more: height and weight
covary, and that tilt is the covariance.

## Problem 2 — Read the summary output

(a) The winner is model **VVV** with **3** components (clusters).

(b) **VVV** = the most flexible shape in the lineup. **Ellipsoidal** means
stretched spheres, not perfect balls — soccer ball versus American
football. **Varying volume**: each cluster can be bigger or smaller.
**Varying shape**: each cluster can be rounder or more stretched.
**Varying orientation**: each cluster can point a different direction. VVV
lets every cluster pick its own size, stretch, and direction.

(c) 81 + 36 + 28 = **145** — every patient gets exactly one label, so the
total must equal the 145 rows of the diabetes data. Nobody is lost.

## Problem 3 — The BIC shootout

(a) R prints:

```
rank 1: BIC -482.51  G=3 model=VVV
rank 2: BIC -493.04  G=3 model=VEV
rank 3: BIC -509.21  G=4 model=VEV
rank 4: BIC -514.77  G=4 model=VVE
rank 5: BIC -515.41  G=4 model=VVV
```

(b) **VVV with 3 components** won at −482.51. The runner-up (VEV, G=3, at
−493.04) is about **10 points** behind — a clear win, not a landslide.

(c) BIC **rewards** how well the model fits and **penalizes** complexity
(more parameters = bigger penalty). A 9-component model losing is good
news: it means the extra curves could not earn their keep — the penalty
outweighed the fit gain, so BIC protected us from overfitting.

## Problem 4 — The posterior-probability audit

(a) Row 1 reads **0.9907 / 0.0090 / 0.0003**. Patient 1 belongs most to
**curve 1** (99%), so the hard label is **1** — the label is simply the
curve with the highest posterior probability.

(b) `min(rs)` = **1**, `max(rs)` = **1**. All 145 rows sum to exactly 1:
100% of belief, divided among the curves. The honesty seal — the method
neither invents nor loses belonging.

(c) The hard label **hides the doubt**: it prints "1" and walks away. The
`mc$z` row **shows** it — 0.9907 versus 0.0090 tells you this patient is
sure, while a 0.505/0.455 row (see Problem 5) would tell you the model is
torn. Labels are the headline; the probabilities are the full story.

## Problem 5 — Row 59, the coin flip

(a) **Row 59**, uncertainty **0.495** — the highest in the data.

(b) Row 59's probabilities are **0.505 / 0.455 / 0.04**. It is a coin flip
because the top two curves are nearly tied (0.505 vs 0.455): the model
genuinely cannot decide between curve 1 and curve 2.

(c) A mean of **0.056** means the typical patient is very sure — most of
the 145 uncertainties are near zero. Only a handful of patients (rows 59,
85, 50, 75, 61) are torn.

(d) The biggest symbols sit **where the clouds touch** — in the overlap
regions between the Gaussian components. That makes sense: where two bell
curves overlap, a point could plausibly have come from either one, so the
model's doubt is highest there.

## Problem 6 — The honest confusion table

(a) R prints:

```
    Chemical Normal Overt
  1        9     72     0
  2       26      4     6
  3        1      0    27
```

(rows = `mc$classification`, columns = `diabetes$class`).

(b) **Cluster 1** mostly found **Normal** (72 of the 76 Normal patients).
**Cluster 2** is the **Chemical** group (26 of the 36 Chemical patients,
with some spillover). **Cluster 3** mostly found **Overt** (27 of the 33
Overt patients).

(c) Extremely impressive: three true groups, three found clusters, with the
big majorities landing together — and the model did it **blind**, never
seeing the labels. On this data, model-based clustering recovered the
doctors' own grouping from the measurements alone.
