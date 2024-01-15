---
title: "roundrobin package"
author: by kilometer
output: 
  html_document:
    keep_md: TRUE
---




```
## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
## ✔ dplyr     1.1.4     ✔ readr     2.1.4
## ✔ forcats   1.0.0     ✔ stringr   1.5.1
## ✔ ggplot2   3.4.4     ✔ tibble    3.2.1
## ✔ lubridate 1.9.3     ✔ tidyr     1.3.0
## ✔ purrr     1.0.2     
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```

## Install

from github


```r
devtools::install_github("kilometer0101/roundrobin")
```

## Useage


```r
library(roundrobin)
```

### Sample data


```r
str(InsectSprays)
```

```
## 'data.frame':	72 obs. of  2 variables:
##  $ count: num  10 7 20 14 14 12 10 23 17 20 ...
##  $ spray: Factor w/ 6 levels "A","B","C","D",..: 1 1 1 1 1 1 1 1 1 1 ...
```

```r
dplyr::group_nest(InsectSprays, spray)
```

```
## # A tibble: 6 × 2
##   spray               data
##   <fct> <list<tibble[,1]>>
## 1 A               [12 × 1]
## 2 B               [12 × 1]
## 3 C               [12 × 1]
## 4 D               [12 × 1]
## 5 E               [12 × 1]
## 6 F               [12 × 1]
```

### Use roundrobin function

- roundrobin


```r
roundrobin(InsectSprays, key = spray)
```

```
## # A tibble: 36 × 4
##    Var1  Var2           data_Var1          data_Var2
##    <fct> <fct> <list<tibble[,1]>> <list<tibble[,1]>>
##  1 A     A               [12 × 1]           [12 × 1]
##  2 B     A               [12 × 1]           [12 × 1]
##  3 C     A               [12 × 1]           [12 × 1]
##  4 D     A               [12 × 1]           [12 × 1]
##  5 E     A               [12 × 1]           [12 × 1]
##  6 F     A               [12 × 1]           [12 × 1]
##  7 A     B               [12 × 1]           [12 × 1]
##  8 B     B               [12 × 1]           [12 × 1]
##  9 C     B               [12 × 1]           [12 × 1]
## 10 D     B               [12 × 1]           [12 × 1]
## # ℹ 26 more rows
```

- combination


```r
roundrobin(
  InsectSprays, key = spray, combination = TRUE
  )
```

```
## # A tibble: 15 × 4
##    Var1  Var2           data_Var1          data_Var2
##    <fct> <fct> <list<tibble[,1]>> <list<tibble[,1]>>
##  1 A     B               [12 × 1]           [12 × 1]
##  2 A     C               [12 × 1]           [12 × 1]
##  3 B     C               [12 × 1]           [12 × 1]
##  4 A     D               [12 × 1]           [12 × 1]
##  5 B     D               [12 × 1]           [12 × 1]
##  6 C     D               [12 × 1]           [12 × 1]
##  7 A     E               [12 × 1]           [12 × 1]
##  8 B     E               [12 × 1]           [12 × 1]
##  9 C     E               [12 × 1]           [12 × 1]
## 10 D     E               [12 × 1]           [12 × 1]
## 11 A     F               [12 × 1]           [12 × 1]
## 12 B     F               [12 × 1]           [12 × 1]
## 13 C     F               [12 × 1]           [12 × 1]
## 14 D     F               [12 × 1]           [12 × 1]
## 15 E     F               [12 × 1]           [12 × 1]
```
