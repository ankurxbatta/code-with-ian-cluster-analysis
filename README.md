# Cluster Analysis — Assignments & Solutions (Code With Ian)

Practice problems for every episode of the [Cluster Analysis](https://www.youtube.com/@codewithian) series on the Code With Ian YouTube channel, built from Ankur's DANA 4840 course notes and lecture R code. Solve the problems yourself first — the worked solutions are here when you need them, but they teach you far less if you read them before trying.

## How to use

1. **Watch the episode** (linked in the table below once it's live).
2. **Try the assignment** without looking at the solutions. Give every problem an honest attempt — even a wrong answer you reasoned through beats a copied right one.
3. **Check `solutions/`** only after attempting. If you got stuck, read the solution, close it, and redo the problem from scratch.

## Setup

You need R (version 4.0 or newer). The series uses these packages at various points — install them all once:

```r
install.packages(c(
  "cluster", "factoextra", "dendextend", "fpc", "clValid",
  "pvclust", "mclust", "dbscan", "proxy", "hopkins",
  "pheatmap", "gplots"
))
# ComplexHeatmap comes from Bioconductor:
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("ComplexHeatmap")
```

## Episodes

| # | Topic | Assignment | Solutions | Video |
|---|-------|------------|-----------|-------|
| CA-1 | What Is Cluster Analysis? | [assignment](ca-01-what-is-cluster-analysis/) | [solutions](ca-01-what-is-cluster-analysis/solutions/) | [full lesson](https://youtu.be/juWkuyncBwg) · [Short](https://youtube.com/shorts/q5W9A2-j_hM) (live Mar 2, 2027) |
| CA-2 | Variable Types & Data Import | [assignment](ca-02-variable-types-data-import/) | [solutions](ca-02-variable-types-data-import/solutions/) | [full lesson](https://youtu.be/ahdDVF7H0bQ) · [Short](https://youtube.com/shorts/pztY1bWpbW0) (live Mar 3, 2027) |
| CA-3 | Binary Similarity Coefficients | [assignment](ca-03-binary-similarity-coefficients/) | [solutions](ca-03-binary-similarity-coefficients/solutions/) | [full lesson](https://youtu.be/FNLq2MD0ZHU) · [Short](https://youtube.com/shorts/gQmYhHjxUCU) (live Mar 4, 2027) |
| CA-4 | Euclidean & Manhattan Distance | [assignment](ca-04-euclidean-manhattan-distance/) | [solutions](ca-04-euclidean-manhattan-distance/solutions/) | [full lesson](https://youtu.be/Cd059odGZkk) · [Short](https://youtube.com/shorts/kZxb7m8_UU8) (live Mar 5, 2027) |
| CA-5 | Correlation & Gower Distances | [assignment](ca-05-correlation-gower-distances/) | [solutions](ca-05-correlation-gower-distances/solutions/) | [full lesson](https://youtu.be/IjYE543fD-Q) · [Short](https://youtube.com/shorts/-iomjLaJXLM) (live Mar 6, 2027) |
| CA-6 | K-means Clustering | [assignment](ca-06-k-means-clustering/) | [solutions](ca-06-k-means-clustering/solutions/) | K-means Clustering, Step by Step (live Mar 6, 2027) |
| CA-7 | The Clustering Workflow: Hopkins & VAT | coming with the episode | coming with the episode | coming Mar 2027 |
| CA-8 | Choosing k: Elbow & Silhouette | coming with the episode | coming with the episode | coming Mar 2027 |
| CA-9 | The Gap Statistic | coming with the episode | coming with the episode | coming Mar 2027 |
| CA-10 | PAM: Clustering Around Medoids | coming with the episode | coming with the episode | coming Mar 2027 |
| CA-11 | CLARA: Clustering for Large Datasets | coming with the episode | coming with the episode | coming Mar 2027 |
| CA-12 | Hierarchical Clustering & Dendrograms | coming with the episode | coming with the episode | coming Mar 2027 |
| CA-13 | Ward's Linkage & the Lance-Williams Formula | coming with the episode | coming with the episode | coming Mar 2027 |
| CA-14 | Hierarchical K-means: The Hybrid | coming with the episode | coming with the episode | coming Mar 2027 |
| CA-15 | Heatmaps: Seeing Clusters in Color | coming with the episode | coming with the episode | coming Mar 2027 |
| CA-16 | Verifying Dendrograms: Cophenetic Correlation | coming with the episode | coming with the episode | coming Mar 2027 |
| CA-17 | Baker's Gamma: Rank-Based Tree Check | coming with the episode | coming with the episode | coming Mar 2027 |
| CA-18 | P-values for Hierarchical Clusters | coming with the episode | coming with the episode | coming Mar 2027 |
| CA-19 | Rand Index: External Validation | coming with the episode | coming with the episode | coming Mar 2027 |
| CA-20 | Dunn Index & Connectivity | coming with the episode | coming with the episode | coming Mar 2027 |
| CA-21 | clValid: Which Algorithm Wins? | coming with the episode | coming with the episode | coming Mar 2027 |
| CA-22 | Stability of Clustering | coming with the episode | coming with the episode | coming Mar 2027 |
| CA-23 | DBSCAN: Density-Based Clustering | coming with the episode | coming with the episode | coming Mar 2027 |
| CA-24 | Fuzzy Clustering: Belonging to Many | coming with the episode | coming with the episode | coming Mar 2027 |
| CA-25 | Model-Based Clustering: Gaussian Mixtures | coming with the episode | coming with the episode | coming Mar 2027 |

New assignments land here as each episode is released. The full "Cluster Analysis" playlist goes live on YouTube with the series.

## About

- YouTube channel: https://www.youtube.com/@codewithian
- Material is based on Ankur Batta's DANA 4840 (Cluster Analysis) course notes and lecture R code.
