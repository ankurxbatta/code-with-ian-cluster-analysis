# CA-2 Solutions — Variable Types & Data Import

Worked solutions. If you haven't attempted the problems yet, go back and try — these will still be here.

## Problem 1 — Classify the worksheet table

- **Age** (22, 33, 52, 46): **quantitative**. Counts of years — you can average and subtract them.
- **Race** (1, 3, 1, 6): **categorical, nominal**. The numbers are just group codes; code 6 is not "twice" code 3, and there is no order.
- **Height** (Tall, Short, Moderate, Tall): **categorical, ordinal**. Short < Moderate < Tall is a real order.
- **Income** (0.39, 0.34, 0.51, 0.63): **quantitative**. Money-like decimals — measurable and subtractable.
- **IsMale** (TRUE/FALSE): **categorical, nominal (binary)**. A yes-no answer with two unordered categories.
- **Politics** (moderate, liberal, conservative): **categorical, ordinal**. Liberal < moderate < conservative is a real order.

## Problem 2 — New variables, same skill

- **ZipCode**: categorical, nominal. It *looks* numeric, but 90210 is not "bigger" than 10001 — zip codes are labels, and averaging them is nonsense.
- **Education**: categorical, ordinal. HighSchool < Bachelor < Master < PhD is a real order.
- **FavoriteColor**: categorical, nominal. Colors have no natural order.
- **NumPets**: quantitative. Counts — you can average "2.5 pets per household" and it means something.
- **Smoker**: categorical, nominal (binary). Yes/no, two unordered categories.
- **Satisfaction**: categorical, ordinal. Low < medium < high is a real order.

## Problem 3 — Build it in R

```r
Age <- c(22, 33, 52, 46)                                   # quantitative -> numeric
Income <- c(0.39, 0.34, 0.51, 0.63)                        # quantitative -> numeric
Race <- factor(c(1, 3, 1, 6))                               # nominal
IsMale <- factor(c(TRUE, TRUE, FALSE, TRUE))                # binary nominal
Height <- factor(c("Tall", "Short", "Moderate", "Tall"),    # ordinal
                 levels = c("Short", "Moderate", "Tall"), ordered = TRUE)
Politics <- factor(c("moderate", "liberal", "moderate", "conservative"),
                   levels = c("liberal", "moderate", "conservative"),  # ordinal
                   ordered = TRUE)
df <- data.frame(Age, Race, Height, Income, IsMale, Politics)
str(df)
```

Real output:

```
'data.frame':	4 obs. of  6 variables:
 $ Age     : num  22 33 52 46
 $ Race    : Factor w/ 3 levels "1","3","6": 1 2 1 3
 $ Height  : Ord.factor w/ 3 levels "Short"<"Moderate"<..: 3 1 2 3
 $ Income  : num  0.39 0.34 0.51 0.63
 $ IsMale  : Factor w/ 2 levels "FALSE","TRUE": 2 2 1 2
 $ Politics: Ord.factor w/ 3 levels "liberal"<"moderate"<..: 2 1 2 3
```

`str()` ("structure") prints one line per column: the type, then the values. `Factor w/ 3 levels` means a nominal factor with three categories; `Ord.factor` means an ordered factor, and `"Short"<"Moderate"<..` shows the level order.

## Problem 4 — The import trap

(a) **Race** arrived as `int` (should be a nominal factor), **Height** arrived as `chr` (should be an ordered factor), **IsMale** arrived as `logi` (should be a binary factor), **Politics** arrived as `chr` (should be an ordered factor). Age and Income are fine. This is exactly the trap: categoricals arrive as character, integer, or logical — never as factors.

(b)

```r
d <- read.table("data.txt", header = TRUE, sep = ",")
d$Age <- as.numeric(d$Age)          # import guessed int; ours is num
d$Race <- factor(d$Race)            # nominal
d$IsMale <- factor(d$IsMale)        # binary nominal
d$Height <- factor(d$Height,
                   levels = c("Short", "Moderate", "Tall"), ordered = TRUE)
d$Politics <- factor(d$Politics,
                     levels = c("liberal", "moderate", "conservative"),
                     ordered = TRUE)
```

Rule of thumb: nominal gets plain `factor()`; ordinal gets `factor()` with `levels` in the real order and `ordered = TRUE`.

## Problem 5 — Tibble vs data frame

(a) `read_excel()` returns a **tibble**, not a data frame. A tibble is R's modern, stricter table — it behaves like a data frame for most things, but some older functions expect a true data frame. Convert with one line:

```r
d <- as.data.frame(read_excel("data.xlsx", col_names = TRUE))
```

(b) `TRUE` from `identical()` certifies that the two tables agree **completely** — same values, same column types, same level orders, same column order. It is your receipt that the import was converted correctly. Any wrong type or mis-ordered levels would give `FALSE`.

## Problem 6 — Bonus: the picky check

(a) `FALSE`. `identical()` is strict: `int` (integer, whole numbers) and `num` (numeric/double, decimals allowed) are different storage types in R, so the two Age columns are not identical even though the values look the same.

(b)

```r
d$Age <- as.numeric(d$Age)
```

One `as.numeric()` call aligns the types, and `identical()` then returns `TRUE`.

---

The full demo script used in the episode is in [`demo_imports.R`](demo_imports.R) — it writes the data files, runs all three imports (`read.table`, `read.csv`, `read_excel`), converts the types, and confirms both `identical()` checks return `TRUE`. Run it with `Rscript demo_imports.R` (needs the `readxl` package).
