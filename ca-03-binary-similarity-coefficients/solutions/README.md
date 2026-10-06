# CA-3 Worked Solutions

Work through the assignment first — these are here for checking, not copying.

---

## Solution 1 — Label the 2×2 table

Comparing position by position:

| Product | 1 | 2 | 3 | 4 | 5 |
|---|---|---|---|---|---|
| C | 1 | 1 | 0 | 1 | 0 |
| D | 0 | 1 | 1 | 1 | 0 |
| Cell | b | a | c | a | d |

- **a = 2** (products 2 and 4 — both bought)
- **b = 1** (product 1 — C bought, D did not)
- **c = 1** (product 3 — D bought, C did not)
- **d = 1** (product 5 — neither bought)

Check: 2 + 1 + 1 + 1 = 5, which is the number of products. Good.

## Solution 2 — All three coefficients, by hand

(a) Simple matching: (a + d) / (a + b + c + d) = (2 + 1) / 5 = **3/5 = 0.6**
(b) Jaccard: a / (a + b + c) = 2 / (2 + 1 + 1) = 2/4 = **1/2 = 0.5**
(c) Dice: 2a / (2a + b + c) = 4 / (4 + 1 + 1) = 4/6 = **2/3 ≈ 0.6667**

Dice gives the highest value. That makes sense: Dice counts the 1–1 matches twice (2a in the numerator), so it rewards shared yeses more generously than the other two.

## Solution 3 — Symmetric or asymmetric?

(a) **Symmetric → simple matching.** A 0 here means "does not have high blood pressure" — a real, meaningful medical fact about the patient. Both 0s carry the same weight as both 1s, so the d cell should count.
(b) **Asymmetric → Jaccard.** Most species are absent from both islands simply because the species are rare — shared absence says nothing about the islands being alike. Jaccard drops the d cell so the score is driven only by shared sightings.

## Solution 4 — Similarity to dissimilarity

(a) Dissimilarity = 1 − similarity:
- Simple matching: 1 − 0.6 = **0.4**
- Jaccard: 1 − 0.5 = **0.5**
- Dice: 1 − 1/3… carefully: 1 − 2/3 = **1/3 ≈ 0.3333**

(b) The largest dissimilarity (0.5, from Jaccard) belongs to the smallest similarity (0.5) — and a "dissimilarity" should be big when two rows are *unlike* each other, which is exactly what we see. Also note: a distance is a dissimilarity, so 0 means "identical" and larger values mean "farther apart" — the mirror image of similarity.

## Solution 5 — Confirm it in R

Real console output (R 4.3.3, `proxy` package):

```
> simil(M, method = "Dice")
          C
D 0.6666667

> simil(M, method = "Jaccard")
     C
D 0.5

> simil(M, method = "simple matching")
     C
D 0.6
```

(a) All three match the hand work from Solution 2 exactly: Dice 2/3, Jaccard 1/2, simple matching 3/5.
(b) `dist(M, method = "binary")` returns:

```
     C
D 0.5
```

That is a **dissimilarity** (distances are dissimilarities). It equals 1 − Jaccard similarity = 1 − 0.5 = 0.5. The shortcut computes the Jaccard *dissimilarity* directly.

## Solution 6 — Reading a similarity matrix

(a) **C2 and C4** are the most similar pair (0.85 — the largest off-diagonal value). The diagonal is all 1.00 because each shopper compared with themselves is a perfect match (similarity of 1 = most similar).

(b) After the two shared-zero questions: a = 3, b = 1, c = 0, d = 1 + 2 = 3, and n = 7.
- Jaccard = 3 / (3 + 1 + 0) = **3/4 = 0.75** — unchanged.
- Simple matching = (3 + 3) / 7 = **6/7 ≈ 0.8571** — went up from 0.8.

Simple matching changed (two extra d matches raised the score), while Jaccard ignored the new d cell entirely — which is exactly why Jaccard is the right choice for asymmetric zeros: adding more shared absences shouldn't make two rows look more alike.
