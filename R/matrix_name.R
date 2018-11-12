#' Randomize your name in a matrix
#'
#' Capitalize each letter of your name and randomly put in a matrix. This is a input for function `graph_fun` to create a wallpaper.
#'
#' @param x Character. Your name
#' @param n Integer. Size n by n.
#'
#' @return Martix. n by n.
#' @author Jiaxiang Li
#'
#' @import tidyverse
#'
#' @export
#'
#' @examples
#' matrix_me <-
#'   add2blog::matrix_name('jiaxiangli',n = 10)


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
