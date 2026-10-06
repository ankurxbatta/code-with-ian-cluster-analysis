# CA-4 Assignment — Euclidean & Manhattan Distance

Try all six problems before looking at the solutions. One honest attempt beats a copied answer. You will need R (4.0 or newer) for the R problems.

---

## Problem 1 — Euclidean by hand

Two points: P = (1, 2) and Q = (4, 6).

(a) Write out the differences per coordinate, square them, add them, and take the square root. What is the Euclidean distance?
(b) Explain in one sentence how this is the Pythagorean theorem "grown up".

## Problem 2 — Manhattan by hand

For the same two points P = (1, 2) and Q = (4, 6), compute the Manhattan distance (sum of absolute differences). In plain words: if Euclidean is the straight diagonal, what everyday path does Manhattan describe?

## Problem 3 — The ranking flips

Take X = (0, 0), Y = (2, 9), and Z = (6, 6).

(a) Compute the Manhattan distance from X to Y and from X to Z. Which of Y, Z is closer to X under Manhattan?
(b) Compute the Euclidean distance from X to Y and from X to Z (round to 2 decimals). Which is closer under Euclidean?
(c) The rankings disagree. Explain in one sentence why the big gap in Y's second coordinate (9) hurt it more under Euclidean than under Manhattan.

## Problem 4 — Units change the answer

Two people are described by (weight, height):

- Person A: (70 kg, 170 cm)
- Person B: (100 kg, 172 cm)

(a) Compute the Euclidean distance between them. Which variable dominates the answer — weight or height?
(b) Now the weights are recorded in grams instead: A = (70,000 g, 170 cm), B = (100,000 g, 172 cm). Recompute. What happened to the height information?
(c) State the lesson's standing rule in one sentence.

## Problem 5 — The scale() fix in R

Recreate Problem 4 in R:

```r
kg <- rbind(A = c(70, 170), B = c(100, 172))
g  <- rbind(A = c(70000, 170), B = c(100000, 172))
```

(a) Run `dist(kg, method = "euclidean")` and `dist(g, method = "euclidean")`. Compare with your Problem 4 answers.
(b) Now run `dist(scale(kg), method = "euclidean")` and `dist(scale(g), method = "euclidean")`. What are the two answers, and what does it prove about `scale()`?
(c) In one sentence, say what `scale()` does to each column (mean and standard deviation).

## Problem 6 — Reading the R console

The lesson's course handout R demo ran `dist(method = "euclidean")` on scaled USArrests data and printed, among others:

- New Mexico – Iowa: 4.1
- New Mexico – Indiana: 2.5
- Iowa – Indiana: 1.8

(a) Which two states are the closest pair here? Which are the most distant?
(b) Since this is a distance (a dissimilarity), what does the smaller number mean in plain words — closer in crime profiles, or farther apart?
