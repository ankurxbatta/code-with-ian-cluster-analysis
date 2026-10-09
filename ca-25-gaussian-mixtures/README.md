# CA-25 Assignment — Model-Based Clustering: Gaussian Mixtures

Solve these **before** peeking at `solutions/`. All problems come from the
episode's R demo (`Mclust(scale(diabetes[, -1]))` with `set.seed(42)`). You
need R with the `mclust` and `MASS` packages.

## Problem 1 — Gaussian, mixture, component: in your own words

In plain English (no jargon), define each of these four terms the way the
episode does:

(a) **Gaussian** (what shape is it, and what do its center and width mean?)

(b) **Mixture** (what is being mixed, and what is the puzzle?)

(c) **Component** (what is one component, and what does it become for us?)

(d) **Covariance** (what does it describe about two variables? Give the
episode's height-and-weight example.)

## Problem 2 — Read the summary output

Running the episode's R code prints:

```
> summary(mc)
Mclust VVV (ellipsoidal, varying volume, shape, and orientation) model with 3 components:

 log-likelihood   n df       BIC       ICL
      -169.0908 145 29 -482.5069 -501.4662

Clustering table:
 1  2  3
81 36 28
```

(a) What model won, and how many components (clusters) did it use?

(b) Decode **VVV** in plain English: what does "ellipsoidal" mean (use the
soccer-ball-vs-American-football comparison), and what do "varying volume",
"varying shape", and "varying orientation" each allow?

(c) The clustering table reads 81 / 36 / 28. Add them up. What should the
total be, and why?

## Problem 3 — The BIC shootout (R)

```r
library(mclust)
data(diabetes)
df <- scale(diabetes[, -1])
set.seed(42)
mc <- Mclust(df)
b <- mc$BIC
ord_all <- order(as.vector(b), decreasing = TRUE)
pos <- arrayInd(ord_all, dim(b))
for (i in 1:5) cat(sprintf("rank %d: BIC %.2f  G=%s model=%s\n", i,
    b[pos[i,1], pos[i,2]], rownames(b)[pos[i,1]], colnames(b)[pos[i,2]]))
```

(a) Report the top 5 rows R prints.

(b) The episode's rule is **higher BIC = better**. Which model won, and by
about how many points did it beat the runner-up? (A "point" here is one
unit of BIC.)

(c) In plain English, what does BIC reward and what does it penalize? Why
is it good news — not bad news — that a 9-component model did **not** win?

## Problem 4 — The posterior-probability audit (R)

```r
head(mc$z)
rs <- rowSums(mc$z)
c(min(rs), max(rs))
```

(a) Write down the three numbers in row 1 of `mc$z`. Which cluster does
patient 1 belong to most, and what would their **hard label** be?

(b) Report `min(rs)` and `max(rs)`. What does this tell you? (This is the
episode's "honesty seal" — the same idea as the fuzzy membership audit in
CA-24.)

(c) Explain what the hard label **hides** that the `mc$z` row **shows**.

## Problem 5 — Row 59, the coin flip (R)

```r
ord <- order(mc$uncertainty, decreasing = TRUE)
head(mc$uncertainty[ord], 5)
mc$z[ord[1], ]
mean(mc$uncertainty)
```

(a) Which row is the most uncertain patient in the data, and what is its
uncertainty value?

(b) Write down that patient's three posterior probabilities. Why is this
patient "a coin flip"?

(c) The mean uncertainty is only 0.056. In plain English, what does that
say about the other 144 patients?

(d) The episode says bigger symbols mean more uncertain points. If you run
`plot(mc, what = "uncertainty")`, where on the plot do the biggest symbols
sit, and why does that location make sense?

## Problem 6 (stretch) — The honest confusion table (R)

The diabetes data comes with true labels (`diabetes$class`: Normal 76,
Chemical 36, Overt 33). The model never saw them. Run:

```r
table(mc$classification, diabetes$class)
```

(a) Copy the table R prints.

(b) Which true group did cluster 1 mostly find? Cluster 2? Cluster 3? Give
the key counts from the table.

(c) One-sentence verdict: the model was unsupervised — it never saw the
labels — so how impressive is this match, and what does it say about
model-based clustering on this data?
