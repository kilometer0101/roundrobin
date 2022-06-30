
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
