# CA-13 Assignment — Ward's Linkage & the Lance-Williams Formula

Try all five problems before looking at the solutions. One honest attempt beats a copied answer. You will need R (4.0 or newer). Remember the big ideas: Ward's method is the minimum variance linkage — it merges the pair that grows the total within-cluster variance the least, which is why its clusters come out compact and at similar sizes; after a merge, distances refresh through the Lance-Williams update formula (boxed in the notes: memorize it); ward.D uses the distances as given while ward.D2 squares them inside and takes the square root outside; the exact R spelling is lowercase "ward", capital "D".

---

## Problem 1 — Decode the boxed formula

The typed notes box this formula (ward.D version):

d(ij)k = (n_i+n_k)/(n_i+n_j+n_k) · d_ik + (n_j+n_k)/(n_i+n_j+n_k) · d_jk − n_k/(n_i+n_j+n_k) · d_ij

(a) In plain English, what is d(ij)k? (What are "ij" and "k" in the clustering story?)
(b) What do n_i, n_j, and n_k count?
(c) What are d_ik, d_jk, and d_ij?
(d) In one or two sentences: why does the formula have a minus sign on the third term — what is being "corrected"?

## Problem 2 — Lance-Williams by hand (ward.D and ward.D2)

Clusters i and j have just merged. Cluster i holds n_i = 1 item, cluster j holds n_j = 1, cluster k holds n_k = 1. The given distances are d_ik = 8, d_jk = 5, d_ij = 3.

(a) Compute the three Lance-Williams coefficients. (Answer check: the denominators are all 3.)
(b) Compute d(ij)k under ward.D. Show every term as a fraction, then the sum. (Answer check: the answer is 23/3.)
(c) Compute d(ij)k under ward.D2. Square the distances first, show every term, then take the square root. (Answer check: the value inside the square root is 169/3.)
(d) Which answer is bigger, and by about how much?

## Problem 3 — Unequal cluster sizes

Now the clusters are bigger: n_i = 2, n_j = 1, n_k = 3, with d_ik = 10, d_jk = 6, d_ij = 4.

(a) Compute the three coefficients (n_i+n_k)/(n_i+n_j+n_k), (n_j+n_k)/(n_i+n_j+n_k), and −n_k/(n_i+n_j+n_k). Simplify each fraction.
(b) Compute d(ij)k under ward.D. (Answer check: the answer is 31/3 ≈ 10.333.)
(c) In one or two sentences: the biggest cluster here is k (n_k = 3). How did that show up in the coefficients — which term got the biggest weight, and which correction got subtracted?

## Problem 4 — Real R: ward.D vs ward.D2 (and the spelling trap)

Run this for real (the episode's exact verification):

```r
data("USArrests")
df <- scale(USArrests)
d <- dist(df, method = "euclidean")
hcD2 <- hclust(d = d,   method = "ward.D2")
hcD  <- hclust(d = d^2, method = "ward.D")
max(abs(hcD$height - hcD2$height^2))
```

(a) What number does R print for the max gap? What does that prove about the two spellings?
(b) Now run `hclust(d = d, method = "Ward.D")` (capital W). Write down exactly what R prints.
(c) In one or two sentences: a classmate says "ward.D and ward.D2 are just two names for the same thing, so I can feed either one my distance matrix." What is wrong with that sentence?

## Problem 5 — Real R: Ward's personality on USArrests

```r
hcW <- hclust(d = dist(scale(USArrests)), method = "ward.D2")
hcS <- hclust(d = dist(scale(USArrests)), method = "single")
table(cutree(hcW, k = 4))
table(cutree(hcS, k = 4))
```

(a) Which two states merge first under Ward, and at what height? (Hint: check `hcW$merge[1, ]` against the row names — and compare with episode 12.)
(b) Write down both cluster-size tables.
(c) In two or three sentences: explain what the two tables tell you about the "personality" difference between Ward's method and single linkage. Which table shows chaining, and which shows Ward's minimum-variance behavior?
