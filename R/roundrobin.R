#' Transform a data.frame or tibble into a wide form of a round-robin combination of a particular key column.
#' @importFrom dplyr rename
#' @importFrom dplyr group_nest
#' @importFrom dplyr left_join
#' @importFrom rlang "!!"
#' @importFrom rlang ":="
#' @importFrom tibble as_tibble
#' @importFrom stringr str_c
#' @param data target data.frame or tibble
#' @param key target key for combination calcuration
#' @param combination whether to make them a unique pair or not
#' @param rename whether to rename Var columns
#' @export
roundrobin <-
  function(data, key,
           combination = FALSE,
           rename = TRUE){
  data_nest <-
    data %>%
    dplyr::rename(key = key) %>%
    dplyr::group_nest(key)

  grid <-
    base::expand.grid(Var1 = data_nest$key, Var2 = data_nest$key)

  if(combination == TRUE){
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
    tag_x <- stringr::str_c(key, ".x")
    tag_y <- stringr::str_c(key, ".y")

    result <-
      result %>%
      dplyr::rename(!!tag_x := "Var1") %>%
      dplyr::rename(!!tag_y := "Var2")
  }

  return(result)
}
