# CA-15 Solutions — Heatmaps: Reading Clusters in Color

Worked solutions. If you have not tried the problems yet, go back — one honest attempt beats a copied answer. The script `verify_heatmaps.R` in this folder runs every R computation below so you can check your own console against it.

---

## Problem 1 — Reading a heatmap in plain English

(a) A heatmap is a data table colored by value: every cell gets a color, and the color IS the value. A dendrogram is the merge tree (from episodes 12–13) — it shows which rows or columns are most similar by placing similar ones next to each other.
(b) Row clustering groups the observations (the cars); column clustering groups the variables (the specs). A heatmap does both at once because it draws a dendrogram on each axis — down the left for rows, across the top for columns — so similar rows AND similar columns each stack into solid color blocks.
(c) A color palette (color scale) is the full color range a plot uses — which color stands for which value. You read the legend first because the same block pattern means opposite things under different palettes (red = high in base R, but blue = low in a blue-red palette).
(d) Side colors are thin bars drawn beside the heatmap that paint each row or column with a label from outside the data — for example, painting each car by its cylinder count (4, 6, or 8 cylinders), so you can see where the 4-cylinder cars landed after clustering.

## Problem 2 — Real R: the base heatmap

(a) `dim(df)` prints `32 11`: 32 cars down the rows, 11 variables across the columns.
(b) `range(mtcars$disp)` is 71.1 to 472.0 while `range(mtcars$wt)` is 1.513 to 5.424 — same cars, wildly different units (cubic inches vs thousands of pounds). Without scaling, engine size would hog the whole color range and weight would look almost flat, so the colors would exaggerate the big-number variable and hide the rest.
(c) `scale = "none"` tells R not to re-scale inside the plot. It is correct here because we already scaled with `df <- scale(mtcars)`.
(d) One dendrogram runs down the left side and clusters the rows (the cars); the second runs across the top and clusters the columns (the variables).

## Problem 3 — The scale() rule, with numbers

(a) Unscaled: `disp` 71.1–472.0, `wt` 1.513–5.424. `disp` would hog the color range because its numbers are roughly a hundred times bigger — nearly the whole red-to-yellow gradient would be spent on `disp` alone, leaving `wt` painted almost one flat color.
(b) Every column's mean is 0 and every column's standard deviation is 1.
(c) Scaled: `disp` about -1.29 to 1.95, `wt` about -1.74 to 2.26. Yes — both now sit on the same roughly -2 to +2 footing, so no variable can bully the colors.

## Problem 4 — Palettes and side colors

(a) `length(col)` prints 256: the number of blended paint shades in the red-yellow-blue gradient (built from 10 anchor colors).
(b) The color key spans about -3 (deep blue) to +3 (deep red), with 0 white in the middle. It is the decoder ring for every cell.
(c) They turn off the extra decoration: no trace lines over the cells and no density strip — just the heatmap.
(d) 32 rows and 11 columns get labeled (16 blue + 16 pink rows; 5 purple + 6 orange columns). A side-color bar paints a row or column with a label you supply, so after clustering you can see where your labeled groups landed — scattered colors mean the label ignores the clusters, solid chunks mean it matches them.

## Problem 5 — The mtcars story

(a) Rows: 5, 15, 12. Columns: 6, 5.
(b) `rownames(mtcars)[cutree(hclust(dist(df)), k = 3) == 1]` returns exactly Mazda RX4, Mazda RX4 Wag, Ford Pantera L, Ferrari Dino, Maserati Bora — the five sporty cars.
(c) Column group 1: mpg, drat, qsec, vs, am, gear — the efficiency family (fuel economy and drivetrain specs that rise and fall together). Column group 2: cyl, disp, hp, wt, carb — the power family (size and power specs that move together).
(d) Story one: which cars group together — 5 sporty, 15 everyday, 12 heavyweights. Story two: which specs move together — the efficiency family vs the power family. One picture answers both, which is why the heatmap earns its place.
