# CA-11 solution check: re-runs the class CLARA demo (script 008) and
# prints the numbers the assignment asks for. Run with:
#   Rscript verify_clara.R
suppressPackageStartupMessages({library(cluster); library(factoextra)})

set.seed(1234)
df <- rbind(cbind(rnorm(200, 0, 8), rnorm(200, 0, 8)),
            cbind(rnorm(300, 50, 8), rnorm(300, 50, 8)))
colnames(df) <- c("x", "y")
rownames(df) <- paste0("S", 1:nrow(df))

clara.res <- clara(df, 2, samples = 50, pamLike = TRUE)

cat("== medoids (Problem 4b) ==\n")
print(round(clara.res$medoids, 2))
cat("\n== cluster sizes (Problem 4b) ==\n")
print(table(clara.res$clustering))
cat("\n== objective function = full-data cost (Problem 4c) ==\n")
print(clara.res$objective)
cat("\n== head of clustering vector (Problem 4d) ==\n")
print(head(clara.res$clustering, 10))
cat("\n== sampsize check (Problem 3a): 40 + 2k, k = 2 ->",
    min(nrow(df), 40 + 2 * 2), "==\n")
