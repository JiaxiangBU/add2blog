#' Print the current time friendly
#'
#' @return Character for print
#' @import lubridate
#' @export
#' @examples
#' pn()

pn <- function(){
    lubridate::now() %>%
        as.character() %>%
        cat
}
