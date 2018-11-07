matrix_name <-
  function(x,n=10) {
    set.seed(123)
    x %>%
    str_to_upper() %>%
    str_split('') %>%
    .[[1]] %>%
    sample(size=n*n,replace=T) %>%
    matrix(
        nrow = 10
        ,byrow = T
    )
  }
