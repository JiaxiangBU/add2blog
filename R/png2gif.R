png2gif <- function(path='.',input_like='.png',output_name='tmp.gif',size="1000x1000"
                    ,transfer_time = 1){
    library(magick)
    path %>%
        list.files(full.names = T) %>%
        str_subset(input_like) %>%
        data.table(x=.) %>%
        mutate(x = map(x,image_read)) %>%
        mutate(x = map(x,~image_scale(.,size))) %>%
        # resize to fit better
        .$x %>%
        image_join %>%
        image_animate(fps=transfer_time) %>%
        image_write(
            file.path(
                path
                ,output_name
            )
        )
}
