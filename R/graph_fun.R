#' Build a wallpaper from your name
#'
#' Input a matrix and build a wallpaper.
#' This is a input for function `graph_fun` to create a wallpaper.
#'
#' @param matrix input
#' @param fontsize font size
#' @import tidyr
#' @import ggplot2
#' @return ggplot
#' @export
#' @examples
#' matrix_me <-
#'   add2blog::matrix_name('jiaxiangli',n = 10)
#' add2blog::graph_fun(matrix_me,fontsize=3)



graph_fun <- function(matrix,fontsize=2.5){
  matrix %>%
    as.data.frame %>%
    rownames_to_column('y') %>%
    gather(x,text,-y) %>%
    mutate(x = str_remove_all(x,'V')) %>%
    mutate_at(vars(x,y),as.integer) %>%
    ggplot(aes(x=x, y=y, color=factor(text))) +
    geom_text(aes(label=text, color=factor(text)), family="Helvetica", size=fontsize) +
    scale_y_reverse() +
    theme_void() +
    scale_color_viridis_d(option="magma", begin=0.2, guide="none") +
    scale_fill_viridis_d(option="magma", begin=0.2, guide="none") +
    theme(panel.background = element_rect(fill="#000000"))
}
