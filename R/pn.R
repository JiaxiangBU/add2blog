#' Print the current time friendly
#'
#' @return Character for print
#' @import lubridate
#' @import clipr
#' @import glue
#' @import cli
#' @export
#' @examples
#' pn()

pn <- function(){
    text <- lubridate::now() %>%
        as.character()
    text %>%
        cat
    clipr::write_clip(text)
    cat('\n\n')
    glue::glue('This text is on your system clipboard') %>%
        cli::rule(center = ., col = "red")
}
