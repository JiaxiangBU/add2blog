#' Convert pictures to gif
#'
#' Convert screenshots or other pictures into a gif.
#'
#' @param path Character. The directory contains the pictures to convert.
#' @param input_like Character. The file names of the pictures like
#' @param output_name Character. The output file name
#' @param size Character. n x n.
#' @param transfer_time Integer. n seconds.
#'
#' @return gif
#' @author Jiaxiang Li
#'
#' @import stringr
#' @import data.table
#' @import purrr
#' @import magick
#' @import dplyr
#'
#' @export
#'
#' @examples
#' png2gif(
#' path = file.path('../','inst')
#' ,input_like = 'reprex'
#' ,output_name = 'reprex201811061210.gif'
#' )


png2gif <- function(path='.',input_like='.png',output_name='tmp.gif',size="1000x1000"
                    ,transfer_time = 1){
    path %>%
        list.files(full.names = T) %>%
        stringr::str_subset(input_like) %>%
        stringr::str_subset('.gif$') %>%
        # avoid git
        data.table::data.table(x=.) %>%
        dplyr::mutate(x = purrr::map(x,magick::image_read)) %>%
        dplyr::mutate(x = purrr::map(x,~magick::image_scale(.,size))) %>%
        # resize to fit better
        .$x %>%
        magick::image_join %>%
        magick::image_animate(fps=transfer_time) %>%
        magick::image_write(
            file.path(
                path
                ,output_name
            )
        )
}
