# CA-2 "Variable Types & Data Import" - real executed R demo
# WS0a worksheet values; typed-notes section 2 classification.
# Writes data files, reads them back three ways, converts types,
# and confirms the imports match with identical().

# ---- build the vectors, types matching the notes classification ----
Age <- c(22, 33, 52, 46)                                   # quantitative -> numeric
Income <- c(0.39, 0.34, 0.51, 0.63)                        # quantitative -> numeric
Race <- factor(c(1, 3, 1, 6))                               # nominal: numeric codes, no order
IsMale <- factor(c(TRUE, TRUE, FALSE, TRUE))                # binary nominal
Height <- factor(c("Tall", "Short", "Moderate", "Tall"),    # ordinal
                 levels = c("Short", "Moderate", "Tall"), ordered = TRUE)
Politics <- factor(c("moderate", "liberal", "moderate", "conservative"),  # ordinal
                   levels = c("liberal", "moderate", "conservative"),
                   ordered = TRUE)
df <- data.frame(Age, Race, Height, Income, IsMale, Politics)

cat("===== str(df): the hand-built data frame =====\n")
str(df)

# ---- write data files (as if typed into files) ----
write.table(df, "ca2_data.txt", sep = ",", row.names = FALSE, quote = FALSE)
write.csv(df, "ca2_data.csv", row.names = FALSE, quote = FALSE)

# ---- import 1: read.table ----
df_txt <- read.table("ca2_data.txt", header = TRUE, sep = ",")
cat("\n===== str(df_txt): straight from read.table =====\n")
str(df_txt)

# categoricals arrived as chr/int/logi -> convert with factor()
df_txt$Age <- as.numeric(df_txt$Age)  # import guessed int; ours is num
df_txt$Race <- factor(df_txt$Race)
df_txt$IsMale <- factor(df_txt$IsMale)
df_txt$Height <- factor(df_txt$Height,
                        levels = c("Short", "Moderate", "Tall"), ordered = TRUE)
df_txt$Politics <- factor(df_txt$Politics,
                          levels = c("liberal", "moderate", "conservative"),
                          ordered = TRUE)
cat("\n===== str(df_txt): after factor() conversion =====\n")
str(df_txt)
cat("\nidentical(df, df_txt):", identical(df, df_txt), "\n")

# ---- import 2: read.csv ----
df_csv <- read.csv("ca2_data.csv", header = TRUE, sep = ",")
cat("\n===== str(df_csv): straight from read.csv =====\n")
str(df_csv)
df_csv$Age <- as.numeric(df_csv$Age)  # import guessed int; ours is num
df_csv$Race <- factor(df_csv$Race)
df_csv$IsMale <- factor(df_csv$IsMale)
df_csv$Height <- factor(df_csv$Height,
                        levels = c("Short", "Moderate", "Tall"), ordered = TRUE)
df_csv$Politics <- factor(df_csv$Politics,
                          levels = c("liberal", "moderate", "conservative"),
                          ordered = TRUE)
cat("\nidentical(df, df_csv):", identical(df, df_csv), "\n")

# ---- import 3: read_excel -> tibble ----
library(readxl)
df_xls <- read_excel("ws0a_class.xlsx", col_names = TRUE)
cat("\n===== str(df_xls): from read_excel (a tibble) =====\n")
str(df_xls)
cat("\nclass(df_xls):", paste(class(df_xls), collapse = ", "), "\n")
df_xls <- as.data.frame(df_xls)
cat("after as.data.frame, class(df_xls):", paste(class(df_xls), collapse = ", "), "\n")

# same txt-file values exported to xlsx arrive identically typed
cat("\nlevels of IsMale from the xlsx file:", paste(levels(factor(df_xls$IsMale)), collapse = " "), "\n")
