scan_yaml <-
function (dir = "content")
{
    if (missing(dir))
        dir = switch(generator(), hugo = "content", jekyll = ".",
            hexo = "source")
    files = list.files(dir, "[.][Rr]?(md|markdown)$", recursive = TRUE, full.names = TRUE)
    if (length(files) == 0)
        return(list())
    res = lapply(files, function(f) {
        yaml = fetch_yaml(f)
        if (length(yaml) == 0)
            return()
        yaml = yaml[-c(1, length(yaml))]
        if (length(yaml) == 0)
            return()
        tryCatch(yaml::yaml.load(paste(yaml, collapse = "\n")),
            error = function(e) {
                warning("Cannot parse the YAML metadata in '",
                    f, "'")
                NULL
            })
    })
    setNames(res, files)
}
