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
  "pvclust", "mclust", "EMCluster", "dbscan", "proxy", "hopkins",
  "pheatmap", "gplots"
))
# ComplexHeatmap comes from Bioconductor:
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("ComplexHeatmap")
```

## Episodes

| # | Topic | Assignment | Solutions | Video |
|---|-------|------------|-----------|-------|
| CA-1 | What Is Cluster Analysis? | [assignment](ca-01-what-is-cluster-analysis/) | [solutions](ca-01-what-is-cluster-analysis/solutions/) | [full lesson](https://youtu.be/kB555PLfsoY) · [Short](https://youtube.com/shorts/qtxLOkMYSu8) (live Mar 2, 2027) |
| CA-2 | Variable Types & Data Import | [assignment](ca-02-variable-types-data-import/) | [solutions](ca-02-variable-types-data-import/solutions/) | [full lesson](https://youtu.be/ahdDVF7H0bQ) · [Short](https://youtube.com/shorts/pztY1bWpbW0) (live Mar 3, 2027) |
| CA-3 | Binary Similarity Coefficients | [assignment](ca-03-binary-similarity-coefficients/) | [solutions](ca-03-binary-similarity-coefficients/solutions/) | [full lesson](https://youtu.be/FNLq2MD0ZHU) · [Short](https://youtube.com/shorts/gQmYhHjxUCU) (live Mar 4, 2027) |
| CA-4 | Euclidean & Manhattan Distance | [assignment](ca-04-euclidean-manhattan-distance/) | [solutions](ca-04-euclidean-manhattan-distance/solutions/) | [full lesson](https://youtu.be/Cd059odGZkk) · [Short](https://youtube.com/shorts/kZxb7m8_UU8) (live Mar 5, 2027) |
| CA-5 | Correlation & Gower Distances | [assignment](ca-05-correlation-gower-distances/) | [solutions](ca-05-correlation-gower-distances/solutions/) | [full lesson](https://youtu.be/IjYE543fD-Q) · [Short](https://youtube.com/shorts/-iomjLaJXLM) (live Mar 6, 2027) |
| CA-6 | K-means Clustering | [assignment](ca-06-k-means-clustering/) | [solutions](ca-06-k-means-clustering/solutions/) | [full lesson](https://youtu.be/cqdZSCBobbQ) — [Short](https://youtube.com/shorts/OztkFV69Lo8) (live Sat Mar 6, 2027 2:00 PM PT) |
| CA-7 | Is Your Data Clusterable? Hopkins Statistic & VAT | [assignment](ca-07-hopkins-vat/) | [solutions](ca-07-hopkins-vat/solutions/) | [full lesson](https://youtu.be/rVIBCx2WzKM) (live Sat Mar 6, 2027) |
| CA-8 | Choosing k: Elbow & Silhouette | [assignment](ca-08-elbow-silhouette/) | [solutions](ca-08-elbow-silhouette/solutions/) | [full lesson](https://youtu.be/0J0Vf5l7G74) (live Sun Mar 7, 2027) |
| CA-9 | The Gap Statistic | [assignment](ca-09-gap-statistic/) | [solutions](ca-09-gap-statistic/solutions/) | [full lesson](https://youtu.be/SylRj26gZQo) (live Sun Mar 7, 2027) |
| CA-10 | PAM: Clustering Around Medoids | [assignment](ca-10-pam-medoids/) | [solutions](ca-10-pam-medoids/solutions/) | [full lesson](https://youtu.be/SZvyahyLG1c) (live Sun Mar 7, 2027) |
| CA-11 | CLARA: Clustering for Large Datasets | [assignment](ca-11-clara-big-data/) | [solutions](ca-11-clara-big-data/solutions/) | [Full lesson](https://youtu.be/3hXm0vznXV8) · [Short](https://youtube.com/shorts/hUy6f4urrJM) (live Mon Mar 8, 2027) |
| CA-12 | Hierarchical Clustering & Dendrograms | [assignment](ca-12-hierarchical-dendrograms/) | [solutions](ca-12-hierarchical-dendrograms/solutions/) | [Full lesson](https://youtu.be/c2SmlSPdmaM) · [Short](https://youtube.com/shorts/ElVXC87suuc) (live Tue Mar 9, 2027) |
| CA-13 | Ward's Linkage & the Lance-Williams Formula | [assignment](ca-13-wards-linkage-lance-williams/) | [solutions](ca-13-wards-linkage-lance-williams/solutions/) | [Full lesson](https://youtu.be/02PybPFXGV8) · [Short](https://youtube.com/shorts/LrGo1M7OnKA) (live Wed Mar 10, 2027) |
| CA-14 | Hierarchical K-means: The Hybrid | [assignment](ca-14-hierarchical-kmeans/) | [solutions](ca-14-hierarchical-kmeans/solutions/) | [Full lesson](https://youtu.be/SUbhqWAQMt4) · [Short](https://youtube.com/shorts/jbi6xfDJpoI) (live Thu Mar 11, 2027) |
| CA-15 | Heatmaps: Seeing Clusters in Color | [assignment](ca-15-heatmaps-color/) | [solutions](ca-15-heatmaps-color/solutions/) | [Full lesson](https://youtu.be/FOrT3-mgSm8) · [Short](https://youtube.com/shorts/eQdnCla9tb8) (live Fri Mar 12, 2027) |
| CA-16 | Verifying Dendrograms: Cophenetic Correlation | [assignment](ca-16-cophenetic-correlation/) | [solutions](ca-16-cophenetic-correlation/solutions/) | [Full lesson](https://youtu.be/j8dAmJmLp1A) · [Short](https://youtube.com/shorts/axNk6yvm-Pc) (live Sat Mar 13, 2027) |
| CA-17 | Baker's Gamma: Rank-Based Tree Check | [assignment](ca-17-bakers-gamma/) | [solutions](ca-17-bakers-gamma/solutions/) | [Full lesson](https://youtu.be/jcrHY-KaxhE) · [Short](https://youtube.com/shorts/Ip2gzRX41W0) — live Sat Mar 13, 2027 2:00 PM PT |
| CA-18 | P-values for Hierarchical Clusters | [assignment](ca-18-pvclust-pvalues/) | [solutions](ca-18-pvclust-pvalues/solutions/) | [Full lesson](https://youtu.be/Cv-R5ZYHdZI) · [Short](https://youtube.com/shorts/iDnSeBhGoyg) — live Sat Mar 13, 2027 6:00 PM PT |
| CA-19 | Rand Index: External Validation | [assignment](ca-19-rand-index/) | [solutions](ca-19-rand-index/solutions/) | [Full lesson](https://youtu.be/hs33Pwk-Ksk) · [Short](https://youtube.com/shorts/-W5D0T2ILLA) — Sun Mar 14, 2027 10:00 AM PT |
| CA-20 | Dunn Index & Connectivity | [assignment](ca-20-dunn-connectivity/) | [solutions](ca-20-dunn-connectivity/solutions/) | [Full lesson](https://youtu.be/bzQVdRFERPM) · [Short](https://youtube.com/shorts/aKQ_USmdLb4) — Sun Mar 14, 2027 2:00 PM PT |
| CA-21 | clValid: Which Algorithm Wins? | [assignment](ca-21-clvalid-algorithm-comparison/) | [solutions](ca-21-clvalid-algorithm-comparison/solutions/) | [Full lesson](https://youtu.be/CSyK8tQtpUA) · [Short](https://youtube.com/shorts/f1Ujvu4bWeg) — Sun Mar 14, 2027 6:00 PM PT |
| CA-22 | Stability of Clustering | coming with the episode | coming with the episode | coming Mar 2027 |
| CA-23 | DBSCAN: Density-Based Clustering | coming with the episode | coming with the episode | coming Mar 2027 |
| CA-24 | Fuzzy Clustering: Belonging to Many | coming with the episode | coming with the episode | coming Mar 2027 |
| CA-25 | Model-Based Clustering: Gaussian Mixtures | coming with the episode | coming with the episode | coming Mar 2027 |

New assignments land here as each episode is released. The full "Cluster Analysis" playlist goes live on YouTube with the series.

## About

- YouTube channel: https://www.youtube.com/@codewithian
- Material is based on Ankur Batta's DANA 4840 (Cluster Analysis) course notes and lecture R code.
