# CA-9: The Gap Statistic — R companion script
# Real executed R from the episode (R 4.3.3, cluster package).
# Run top to bottom.

library(cluster)

# ---- 1. Building one reference column (notes' runif example) ----
set.seed(7)
runif(11, 1, 9)

# ---- 2. The gap statistic on scaled USArrests ----
df <- scale(USArrests)
set.seed(123)
gap <- clusGap(df, FUN = kmeans, K.max = 10, B = 20, nstart = 25)
round(gap$Tab, 4)          # logW | E.logW | gap | SE.sim

# ---- 3. The decision rule, applied by R ----
maxSE(gap$Tab[, "gap"], gap$Tab[, "SE.sim"])

# ---- 4. The gap curve with the margin as error bars ----
plot(gap, main = "Gap statistic: scaled USArrests (B = 20)")

# ---- 5. Feel the wobble: change the seed and watch maxSE ----
set.seed(7)
gap2 <- clusGap(df, FUN = kmeans, K.max = 10, B = 20, nstart = 25)
maxSE(gap2$Tab[, "gap"], gap2$Tab[, "SE.sim"])

# ---- 6. The wobble, by hand (Problem 5) ----
v <- c(3.10, 3.25, 3.18, 3.30, 3.12)
B <- length(v)
wbar <- mean(v)                       # 3.19
sdk  <- sqrt(sum((v - wbar)^2) / B)   # 0.0759
sk   <- sqrt(1 + 1 / B) * sdk         # 0.0831
c(wbar = wbar, sd_k = sdk, s_k = sk)
