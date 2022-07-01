# roundrobin package
by kilometer


## Install

from github


```r
devtools::install_github("kilometer0101/roundrobin")
```

## Useage

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


```r
roundrobin::roundrobin(InsectSprays, key = "spray")
```

```
## # A tibble: 36 × 4
##    Var1  Var2              data.x             data.y
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
## # … with 26 more rows
```
