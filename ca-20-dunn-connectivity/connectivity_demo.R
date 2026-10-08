# CA-20: connectivity demo (worksheet example, real executed R)
library(clValid)
x <- c(1,1,1,1,2,2,2,2,2.5,6); y <- c(1,2,3,4,1,2,3,4,3,3)
df <- data.frame(x, y)
distance <- dist(df)
cluster <- c(1,1,1,1,1,1,1,1,2,2)
connectivity(distance, cluster, neighbSize = 2)  # 3
connectivity(distance, cluster, neighbSize = 1)  # 2
