# CA-7 assignment R script — Hopkins statistic checks
# Run each block and compare with your hand predictions.
library(hopkins)

# Problem 1: two huddles on a line
x1 <- c(2, 2.3, 2.1, 15, 15.4, 14.8, 15.1, 2.5)
mean(replicate(100, hopkins(matrix(x1, ncol = 1), 5)))

# Problem 4a: single runs wobble
x <- c(1, 1.2, 1.4, 21, 20.2, 19.8, 21, 21.2, 20, 21)
hopkins(matrix(x, ncol = 1), 5)
hopkins(matrix(x, ncol = 1), 5)
hopkins(matrix(x, ncol = 1), 5)

# Problem 4b: mean of 100 settles
mean(replicate(100, hopkins(matrix(x, ncol = 1), 5)))
mean(replicate(100, hopkins(matrix(x, ncol = 1), 5)))
mean(replicate(100, hopkins(matrix(x, ncol = 1), 5)))

# Lesson demos (for reference)
# ten worksheet numbers -> H ~ 0.96, clusterable
# uniform runif(150, 2, 27) -> H ~ 0.48, random
u <- matrix(runif(150, 2, 27), ncol = 1)
mean(replicate(100, hopkins(u, 5)))

# Problem 5d: VAT picture of the 3-item matrix
# install.packages("factoextra")  # once, if needed
m3 <- matrix(c(0, 2, 9,
               2, 0, 10,
               9, 10, 0), nrow = 3, byrow = TRUE,
             dimnames = list(c("P", "Q", "R"), c("P", "Q", "R")))
factoextra::fviz_dist(dist(m3), show_labels = TRUE)
