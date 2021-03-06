#' Build a digit plot
#'
#' Convert a photo into a a digit plot
#'
#' @param digit_raw Character. The list of digits you want to add in the digit plot.
#' @param img_path Character. The photo you want to convert.
#' @param resize Double.
#' @param bin Double.
#' @param digit_size Double. Digit font size in the plot.
#' @param digit_size Double. Digit font size in the plot.
#' @param alpha Double. ggplot2's alpha.
#'
#' @return ggplot
#' @author Jiaxiang Li
#'
#' @import stringr
#' @import graphics
#' @import imager
#' @import purrr
#' @import dplyr
#' @import ggplot2
#' @import glue
#' @import tibble
#' @import magrittr
#' @importFrom magrittr %>%
#'
#' @export

digit_plot <-
    function(
        digit_raw='lijiaxiang'
        ,img_path
        ,resize = 0.15
        ,bin = 0.5
        ,digit_size = 4
        ,alpha = 0.8
    ){
        digit_uplow <-
            stringr::str_c(
                digit_raw %>%
                    stringr::str_to_lower(.)
                ,digit_raw %>%
                    stringr::str_to_upper(.)
            )

        greyvalue <-
            function(chr,height=50,width = 50) {
                imager::implot(imager::imfill(height,width,val=1),graphics::text(25,25,chr,cex=5)) %>%
                    # create a blank image and type digit on it!
                    imager::grayscale() %>%
                    mean
            }

        digit_gray_rank <-
            digit_uplow %>%
            stringr::str_split('') %>%
            dplyr::first() %>%
            stringr::str_squish() %>%
            # remove space in a smart way
            unique %>%
            # Each gray level just has only one digit
            tibble::as_tibble() %>%
            dplyr::mutate(gray = purrr::map_dbl(value,greyvalue)) %>%
            # each digit has a specific gray degree
            dplyr::arrange(gray) %>%
            dplyr::transmute(
                digit = value
                ,gray_lv = row_number()
            )
        plot_pos_rank <-
            # 错误: C stack usage  7969824 is too close to the limit
            # 未解决
            imager::load.image(img_path) %>%
            # Image. Width: 570 pix Height: 329 pix Depth: 1 Colour channels: 3
            # str
            # 'cimg' num [1:570, 1:329, 1, 1:3]
            # str display the interpret of cols.
            .[,,1:3] %>%
            # dim
            # each point col desc
            imager::as.cimg() %>%
            imager::grayscale() %>%
            imager::imresize(resize) %>%
            # resize the image
            as.data.frame %>%
            dplyr::filter(value < bin) %>%
            # too dark
            dplyr::transmute(
                x,y
                ,gray_lv = ggplot2::cut_number(value
                                      ,nrow(digit_gray_rank)
                ) %>%
                    as.integer
            )

        p <-
            plot_pos_rank %>%
            dplyr::left_join(
                digit_gray_rank
                ,by='gray_lv'
            ) %>%
            ggplot2::ggplot(ggplot2::aes(x,y,label = digit)) +
            ggplot2::geom_text(size = digit_size,alpha=alpha) +
            ggplot2::coord_fixed() +
            # fix size ratio
            ggplot2::scale_y_reverse() +
            ggplot2::theme_void()
        cat(
            glue::glue('If you find the digit size is too small to recogize, increase `digit_size`'
                 ,'If you find your image is too big to fit your demand, decrease `resize`'
                 ,'If you find your image is too dark to fit a goo view, decrease `bin`'
            )
        )
        return(p)
    }
