# CA-24 Assignment — Fuzzy Clustering: Belonging to Many

Solve these **before** peeking at `solutions/`. All problems come from the
episode's R demo (`fanny(scale(USArrests), 2)` with `set.seed(123)`). You
need R with the `cluster` and `factoextra` packages.

## Problem 1 — Hard vs soft, in your own words

In plain English (no jargon), explain the difference between **hard
assignment** (what k-means does) and **soft assignment** (what fuzzy
clustering does). Your explanation must define the **membership
coefficient** and must say what the membership coefficients of one point
always add up to.

## Problem 2 — Read the membership matrix

Running the episode's R code prints:

```
> head(res.fanny$membership, 3)
           [,1]      [,2]
Alabama 0.6641977 0.3358023
Alaska  0.6098062 0.3901938
Arizona 0.6862278 0.3137722
```

(a) Which of the three states leans **most** toward cluster 1? How can you
tell from the numbers?

(b) Which cluster does Arizona belong to most? What would Arizona's
**hard label** be, and why?

(c) Add up each row. What do you get, and why does that number matter?
(This is the episode's "honesty seal.")

## Problem 3 — The rows-sum-to-one audit (R)

```r
library(cluster)
set.seed(123)
df <- scale(USArrests)
res.fanny <- fanny(df, 2)
rs <- rowSums(res.fanny$membership)
```

(a) Report `min(rs)` and `max(rs)`.

(b) In one or two sentences each, explain what it would mean if a row
summed to **more** than 1, and what it would mean if a row summed to
**less** than 1.

## Problem 4 — Delaware, the coin flip

The episode sorts every state by its strongest membership:

```
> topm <- apply(res.fanny$membership, 1, max)
> sort(topm)[1:3]
  Delaware     Oregon New Jersey
 0.5034392 0.5072644 0.5077570
```

(a) What are Delaware's two membership coefficients (hint: the row must
sum to 1)?

(b) Delaware's hard label is 2. Explain why that label is misleading, and
what the memberships say instead.

(c) `sum(topm < 0.75)` returns 49. In plain English, what does that tell
you about the 50 states? Which single state is the exception, and what is
its top membership?

## Problem 5 — Dunn's partition coefficient: is the fuzziness honest? (R)

```r
res.fanny$coeff
```

(a) Report the two numbers R prints (`dunn_coeff` and `normalized`).

(b) The episode says a perfectly crisp clustering scores 1, and a
maximally mushy one scores 1/k (here, 0.5). Where does our score sit, and
what does that tell you about the two groups?

(c) One-sentence verdict: is fuzzy clustering the honest tool for this
data, or would k-means have been enough? Justify with the numbers.

## Problem 6 (stretch) — Read the two plots

Run `factoextra::fviz_cluster(res.fanny)` and
`factoextra::fviz_silhouette(res.fanny)`.

(a) Describe what the cluster plot looks like (do the two ellipses
overlap?). Which states sit in the overlap region, and what does that
mean for their memberships?

(b) The silhouette summary prints average widths 0.32 (cluster 1, 22
states) and 0.44 (cluster 2, 28 states). Explain in plain English what a
low average silhouette width means, and why these two numbers agree with
the Dunn coefficient from Problem 5.
