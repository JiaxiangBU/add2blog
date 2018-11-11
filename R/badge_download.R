badge_download <- function(
    your_github_name = 'JiaxiangBU'
    ,your_github_repo = 'add2prep'
    ,type = c('total')
){
    glue('  [![GitHub All Releases](https://img.shields.io/github/downloads/{your_github_name}/{your_github_repo}/{type}.svg)](https://github.com/JiaxiangBU/add2prep)') %>%
        print
    glue('<<<Copy it above nto your README.md>>>>')
}
