#' Transform a data.frame or tibble into a wide form of a round-robin combination of a particular key column.
#' @importFrom dplyr rename
#' @importFrom dplyr group_nest
#' @importFrom dplyr left_join
#' @importFrom tibble as_tibble
#' @param data target data.frame or tibble
#' @param key target key for combination calcuration
#' @param unclass whether to make them a unique pair or not
#' @export
roundrobin <- function(data, key, unclass = FALSE, rename = TRUE){
  data_nest <-
    data %>%
    dplyr::rename(key = key) %>%
    dplyr::group_nest(key)

  grid <-
    base::expand.grid(Var1 = data_nest$key, Var2 = data_nest$key)

  if(unclass == TRUE){
    grid <-
      grid %>%
      base::subset(base::unclass(Var1) < base::unclass(Var2))
  }


  result <-
    grid %>%
    tibble::as_tibble() %>%
    dplyr::left_join(data_nest %>% dplyr::rename(Var1 = key),
                     by = "Var1") %>%
    dplyr::left_join(data_nest %>% dplyr::rename(Var2 = key),
                     by = "Var2")


  if(rename == TRUE){
    tag_x <- str_c(key, ".x")
    tag_y <- str_c(key, ".y")

    result <-
      result %>%
      rename(!!tag_x := Var1) %>%
      rename(!!tag_y := Var2)
  }

  return(result)
}
