# CA-5 — Correlation & Gower distances in R
# Pairs with the CA-5 lesson (Correlation & Gower Distances | Code With Ian).
# Every number here also appears on screen in the episode, computed the same way.

library(cluster)

cat("=== Problem 1: correlation distance ===\n")
A <- c(1, 2, 3); B <- c(2, 4, 6); C <- c(3, 2, 1)
cat("r(A,B) =", cor(A, B), "-> d =", 1 - cor(A, B), "\n")
cat("r(A,C) =", cor(A, C), "-> d =", 1 - cor(A, C), "\n")

cat("\n=== Problems 2-4: Gower on the three winners ===\n")
winners <- data.frame(
  age       = c(30, 40, 20),
  continent = factor(c("Asia", "Europe", "Asia")),
  medal     = ordered(c("Gold", "Silver", "Bronze"),
                      levels = c("Bronze", "Silver", "Gold"))
)
print(daisy(winners, metric = "gower"))

cat("\nHand check W1-W2 (3 cols): (0.5 + 1 + 0.5)/3 =", (0.5 + 1 + 0.5) / 3, "\n")
cat("Hand check W1-W3 (3 cols): (0.5 + 0 + 1)/3   =", (0.5 + 0 + 1) / 3, "\n")
cat("Hand check W2-W3 (3 cols): (1 + 1 + 0.5)/3   =", (1 + 1 + 0.5) / 3, "\n")
