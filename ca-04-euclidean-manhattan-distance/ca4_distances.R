# CA-4 — Euclidean & Manhattan distance in R
# Pairs with the CA-4 lesson (Euclidean & Manhattan Distance | Code With Ian).
# Every number here also appears on screen in the episode, computed the same way.

cat("=== Problems 1-2: P=(1,2), Q=(4,6) ===\n")
P <- c(1, 2); Q <- c(4, 6)
M <- rbind(P, Q)
cat("Euclidean:", dist(M, method = "euclidean"), "(hand: sqrt(9+16) = 5)\n")
cat("Manhattan:", dist(M, method = "manhattan"), "(hand: 3+4 = 7)\n")

cat("\n=== Problem 3: the ranking flips ===\n")
M3 <- rbind(X = c(0, 0), Y = c(2, 9), Z = c(6, 6))
print(as.matrix(dist(M3, method = "manhattan")))
print(round(as.matrix(dist(M3, method = "euclidean")), 2))

cat("\n=== Problems 4-5: the units trap and the scale() fix ===\n")
kg <- rbind(A = c(70, 170), B = c(100, 172))
g  <- rbind(A = c(70000, 170), B = c(100000, 172))
cat("kg, unscaled:  ", dist(kg, method = "euclidean"), "\n")
cat("g,  unscaled:  ", dist(g,  method = "euclidean"), "\n")
cat("kg, scaled:    ", dist(scale(kg), method = "euclidean"), "\n")
cat("g,  scaled:    ", dist(scale(g),  method = "euclidean"), "\n")
