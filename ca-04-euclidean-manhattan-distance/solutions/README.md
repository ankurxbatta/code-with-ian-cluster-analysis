# CA-4 Worked Solutions

Work through the assignment first — these are here for checking, not copying.

---

## Solution 1 — Euclidean by hand

(a) Differences: (4 − 1, 6 − 2) = (3, 4). Squares: 9, 16. Sum: 25. Square root: **5**.

(b) In 2-D, the differences are the legs of a right triangle and the distance is the hypotenuse — the square root of the sum of squared differences is just `c = √(a² + b²)` with as many legs as there are dimensions.

## Solution 2 — Manhattan by hand

|4 − 1| + |6 − 2| = 3 + 4 = **7**. In plain words: Manhattan is the walking route on a street grid — you can only move along the axes (like city blocks), so you walk 3 blocks one way and 4 the other instead of cutting the diagonal.

## Solution 3 — The ranking flips

(a) Manhattan: X–Y = 2 + 9 = 11; X–Z = 6 + 6 = 12. Under Manhattan, **Y is closer** (11 < 12).

(b) Euclidean: X–Y = √(4 + 81) = √85 ≈ **9.22**; X–Z = √(36 + 36) = √72 ≈ **8.49**. Under Euclidean, **Z is closer** (8.49 < 9.22).

(c) Squaring exaggerates the big gap: Y's 9 becomes 81 inside the sum, dominating the 4, while Manhattan's plain 9 is just one of two equal contributions — so the one-lopsided-gap point looks worse under Euclidean.

## Solution 4 — Units change the answer

(a) Differences: (30, 2). Euclidean = √(900 + 4) = √904 ≈ **30.07**. Weight dominates — its 900 dwarfs height's 4.

(b) Differences: (30,000, 2). Euclidean = √(900,000,000 + 4) ≈ **30,000.00**. The height information is now completely invisible (4 vs 900,000,000).

(c) Always `scale()` your data before distance-based clustering — otherwise whichever variable has the biggest units wins every distance.

## Solution 5 — The scale() fix in R

(a) `dist(kg, method = "euclidean")` → 30.0666 (matches Solution 4a); `dist(g, method = "euclidean")` → 30000 (matches Solution 4b).

(b) Both give **2.0** (exactly 2 in R). It proves `scale()` erased the units choice: kilograms and grams now give identical answers — the same "both become 2.0" result the lesson showed on its own weight example.

(c) `scale()` subtracts each column's mean and divides by its standard deviation, so every column ends up with mean 0 and standard deviation 1 — no variable can bully the others by unit size.

## Solution 6 — Reading the R console

(a) **Iowa–Indiana (1.8)** are the closest pair; **New Mexico–Iowa (4.1)** are the most distant.

(b) Smaller distance = closer in crime profiles. A distance is a dissimilarity: 0 would mean identical rows, and larger values mean farther apart in the (scaled) arrest data.
