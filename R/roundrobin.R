#' Transform a data.frame or tibble into a wide form of a round-robin combination of a particular key column.
#' @importFrom dplyr rename
#' @importFrom dplyr group_nest
#' @importFrom dplyr left_join
#' @importFrom tibble as_tibble
#' @param data target data.frame or tibble
#' @param key target key for combination calcuration
#' @export
roundrobin <- function(data, key){
  data_nest <-
    data %>%
    dplyr::rename(key = key) %>%
    dplyr::group_nest(key)

  base::expand.grid(data_nest$key, data_nest$key) %>%
    tibble::as_tibble() %>%
    dplyr::left_join(data_nest %>% dplyr::rename(Var1 = key),
                     by = "Var1")%>%
    dplyr::left_join(data_nest %>% dplyr::rename(Var2 = key),
                     by = "Var2")
}
