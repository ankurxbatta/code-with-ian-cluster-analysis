# CA-15 Assignment — Heatmaps: Reading Clusters in Color

Try all five problems before looking at the solutions. One honest attempt beats a copied answer. You will need R (4.0 or newer) with the `RColorBrewer`, `gplots`, and `dendextend` packages installed. Remember the big ideas: a heatmap is a data table colored by value (the color IS the value); dendrograms on both axes cluster the rows AND the columns at once; red means high and yellow means low in base R; solid color blocks are the clusters and a sharp edge between blocks is a cluster boundary; and you must scale() first, or the colors lie.

---

## Problem 1 — Reading a heatmap in plain English

(a) In your own words: what is a heatmap? What is a dendrogram?
(b) What is row clustering, and what is column clustering? Why does a heatmap do both at once?
(c) What is a color palette (or color scale)? Why do you read the legend before reading the blocks?
(d) What are side colors? Give one example of an outside label you could paint beside the rows of the mtcars heatmap.

## Problem 2 — Real R: the base heatmap

Run the episode's exact first demo for real:

```r
df <- scale(mtcars)
dim(df)
heatmap(df, scale = "none")
```

(a) What does `dim(df)` print? In plain English, what do the two numbers count?
(b) Why do we run `scale(mtcars)` before plotting, instead of plotting `mtcars` directly? (Hint: compare `range(mtcars$disp)` with `range(mtcars$wt)`.)
(c) What does `scale = "none"` tell R? Why is it correct here?
(d) Look at the plot: where are the two dendrograms, and what does each one cluster?

## Problem 3 — The scale() rule, with numbers

Still in R, run:

```r
range(mtcars$disp)
range(mtcars$wt)
round(colMeans(df), 2)
round(apply(df, 2, sd), 2)
range(df[, "disp"])
range(df[, "wt"])
```

(a) Write down the unscaled ranges of `disp` and `wt`. In plain English, why would the unscaled heatmap let `disp` "hog the whole color range"?
(b) After `scale()`, what is every column's mean and standard deviation? (Answer check: 0 and 1.)
(c) Write down the scaled ranges of `disp` and `wt`. Are they now on a comparable footing? Explain in one or two sentences.

## Problem 4 — Palettes and side colors

```r
library("RColorBrewer")
col <- colorRampPalette(brewer.pal(10, "RdYlBu"))(256)
length(col)
library("gplots")
heatmap.2(df, scale = "none", col = bluered(100),
          trace = "none", density.info = "none")
```

(a) What does `length(col)` print, and what does that number count?
(b) In the `heatmap.2` plot, find the color key. What values does it span, and which end is blue vs red? (Answer check: about -3 to +3.)
(c) What do `trace = "none"` and `density.info = "none"` turn off?
(d) The lecture demo also uses `RowSideColors = rep(c("blue", "pink"), each = 16)` and `ColSideColors = c(rep("purple", 5), rep("orange", 6))`. How many rows and columns get labeled? In plain English, what does a side-color bar tell you?

## Problem 5 — The mtcars story

Cut the trees and read the groups:

```r
table(cutree(hclust(dist(df)), k = 3))      # row groups
table(cutree(hclust(dist(t(df))), k = 2))   # column groups
```

(a) Write down both tables. (Answer check: rows 5, 15, 12; columns 6, 5.)
(b) The five sporty cars are Mazda RX4, Mazda RX4 Wag, Ford Pantera L, Ferrari Dino, and Maserati Bora. Verify with R that these five are exactly row group 1. (Hint: `rownames(mtcars)[cutree(hclust(dist(df)), k = 3) == 1]`.)
(c) Name the six variables in column group 1 and the five in column group 2. Which family would you call "efficiency" and which "power"? Why?
(d) In two or three sentences: what are the "two stories in one picture" that this heatmap tells?
