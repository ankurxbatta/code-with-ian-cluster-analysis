# CA-2 Assignment — Variable Types & Data Import

Try all six problems before looking at the solutions. One honest attempt beats a copied answer. You will need R (4.0 or newer) and the `readxl` package for the import problems.

## Problem 1 — Classify the worksheet table

Four people were recorded with six variables:

| Age | Race | Height | Income | IsMale | Politics |
|-----|------|--------|--------|--------|----------|
| 22 | 1 | Tall | 0.39 | TRUE | moderate |
| 33 | 3 | Short | 0.34 | TRUE | liberal |
| 52 | 1 | Moderate | 0.51 | FALSE | moderate |
| 46 | 6 | Tall | 0.63 | TRUE | conservative |

For **each** of the six variables, state whether it is **quantitative** or **categorical**. If it is categorical, say whether it is **nominal** (or binary) or **ordinal**. Give a one-sentence reason for each classification.

## Problem 2 — New variables, same skill

A survey collects these variables about each respondent: `ZipCode` (e.g. 12345), `Education` (HighSchool < Bachelor < Master < PhD), `FavoriteColor` (red, blue, green), `NumPets` (0, 1, 2, …), `Smoker` (yes/no), `Satisfaction` (low < medium < high).

Classify each one (quantitative / categorical → nominal / ordinal), with a one-sentence reason. Watch out: one of them *looks* numeric but isn't.

## Problem 3 — Build it in R

Using the four-person table from Problem 1, write R code that:

(a) creates each column as a vector with the **correct type** — numeric for quantitative, `factor()` for categorical, and `factor(..., levels = ..., ordered = TRUE)` for ordinal;
(b) combines the six vectors into a data frame called `df`;
(c) runs `str(df)` and checks that every column has the type you intended.

(Your `str()` output should show 4 observations of 6 variables, with Age and Income numeric, Race and IsMale factors, and Height and Politics ordered factors.)

## Problem 4 — The import trap

You type the four-person table into a text file and read it with `read.table("data.txt", header = TRUE, sep = ",")`. The `str()` of the result shows:

```
 $ Age     : int  22 33 52 46
 $ Race    : int  1 3 1 6
 $ Height  : chr  "Tall" "Short" "Moderate" "Tall"
 $ Income  : num  0.39 0.34 0.51 0.63
 $ IsMale  : logi  TRUE TRUE FALSE TRUE
 $ Politics: chr  "moderate" "liberal" "moderate" "conservative"
```

(a) Which columns arrived with the **wrong type**, and what did they arrive as?
(b) Write the R lines that convert every column to its correct type (use your answer to Problem 1).

## Problem 5 — Tibble vs data frame

(a) You read an Excel version of the same table with `read_excel("data.xlsx", col_names = TRUE)` from the `readxl` package. What kind of object do you get back — a data frame, or something else? How do you turn it into a plain data frame?
(b) After converting all column types, you run `identical(df, df_imported)` and R answers `TRUE`. In plain words, what has R just certified?

## Problem 6 — Bonus: the picky check

`identical()` compares objects **completely** — values, types, and order. Suppose your hand-built data frame stores Age as `num` (decimals allowed) but the imported Age arrives as `int` (whole numbers only).

(a) Will `identical()` return `TRUE` or `FALSE`? Why?
(b) What single R line fixes it?
