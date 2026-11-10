## Code for working with NAs in R
## Zampieri
## Updated 11/10/2026

library(dplyr)
library(tidyr)

### FILTER / DROP NAs ------------------------------------------

df %>% filter(!is.na(col))                 # drop rows where col is NA
df %>% filter(!is.na(col_a), !is.na(col_b))        # drop if a OR b is NA
df %>% drop_na()                           # drop rows with any NA
df %>% drop_na(col_a, col_b)                       # drop rows with NA in a or b
df %>% filter(if_all(c(col_a, col_b), ~ !is.na(.)))  # same, across many cols

df[complete.cases(df), ]                   # base R: any NA
df[complete.cases(df[, c("col_a","col_b")]), ]  # base R: specific cols
na.omit(df)                                # base R: any NA
df[!is.na(df$col), ]                       # base R: one col


### REPLACE NAs WITH 0 --------------------------------------------
df[is.na(df)] <- 0                                         # whole df (base)
df$col[is.na(df$col)] <- 0                                 # one col (base)

df %>% mutate(col = replace_na(col, 0))                    # one col
df %>% mutate(across(c(col_a, col_b), ~ replace_na(., 0)))    # multiple cols
df %>% mutate(across(where(is.numeric), ~ replace_na(., 0)))  # all numeric cols
df %>% mutate(across(everything(), ~ replace_na(., 0)))    # all cols
df %>% replace_na(list(col_a = 0, col_b = 0))                 # multiple cols in tidyr


### CHECKING --------------------------------------------------------
colSums(is.na(df))                         # NA count per column
sum(is.na(df))                             # total NAs