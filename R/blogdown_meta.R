#' Get Metadata from all your blogs built by blogdown
#'
#' This function is inspired by function `count_yaml` in the package `blogdown`.
#'
#' When you post a lot for your blog site built by `blogdown`, you may want to merge, edit metadata of some of them.
#' The function `blogdown_meta` go deeper in the `yaml` contents of each `.Rmd` and
#' build a friendly readable `data.frame` to analyze.
#'
#' @param dir Character. The directory contains all posts you want to analyze.

#' @return data.frame
#' @author Jiaxiang Li
#'
#' @import tidyverse
#' @import blogdown
#' @import data.table
#'
#' @export
#'
#' @examples
#' blogdown_meta(dir = '.')

blogdown_meta <- function(dir = '.'){
    files <- list.files(dir, "[.][Rr]?(md|markdown)$", recursive = TRUE, full.names = TRUE)
    blogdown:::scan_yaml(dir) %>%
        # idea from blogdown count_yaml
        transpose() %>%
        as.data.table() %>%
        mutate(dir = files) %>%
        gather(key,value,-dir) %>%
        # mutate(type = map(value,typeof)) %>%
        # unnest(type) %>%
        filter(map(value,typeof) == 'character') %>%
        # remove null
        unnest(value) %>%
        group_by(dir,key) %>%
        summarise(content = str_flatten(value,collapse = ',')) %>%
        spread(key,content)
}
