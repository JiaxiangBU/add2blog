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
