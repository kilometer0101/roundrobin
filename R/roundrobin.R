#' Transform a data.frame or tibble into a wide form of a round-robin combination of a particular key column.
#' @importFrom dplyr rename
#' @importFrom dplyr group_nest
#' @importFrom dplyr left_join
#' @importFrom rlang ":="
#' @importFrom tibble as_tibble
#' @param df target data.frame or tibble
#' @param combination whether to make them a unique pair or not
#' @export
roundrobin <- function(df, key, combination = FALSE){
  df_nest <-
    mynest(df, {{ key }})

  grid <-
    mygrid(df_nest, combination = combination)

  df_rr <-
    grid %>%
    dplyr::left_join(
      df_nest %>% dplyr::rename(Var1 = key),
      by = "Var1"
    ) %>%
    dplyr::rename(data_Var1 = data) %>%
    dplyr::left_join(
      df_nest %>% dplyr::rename(Var2 = key),
      by = "Var2"
    ) %>%
    dplyr::rename(data_Var2 = data)

  return(df_rr)
}

#' Nest with NSE
#' @importFrom dplyr rename
#' @importFrom dplyr group_nest
#' @importFrom rlang ":="
#' @param df target data.frame or tibble
#' @param key target key for combination calculation
mynest <- function(df, key){
  df %>%
    dplyr::rename(key := {{ key }}) %>%
    dplyr::group_nest(key)
}

#' make grid for rr
#' @importFrom tibble as_tibble
#' @param df target data.frame or tibble
#' @param combination whether to make them a unique pair or not
mygrid <- function(df_nest, combination = FALSE){
  grid <-
    base::expand.grid(Var1 = df_nest$key, Var2 = df_nest$key)

  if(combination == TRUE){
    grid <-
      grid %>%
      base::subset(base::unclass(Var1) < base::unclass(Var2))
  }

  grid %>%
    tibble::as_tibble() %>%
    return()
}


