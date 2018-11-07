# add2blog

`add2blog` is R package to create some materials for a blog website.

Friendly install `add2blog` by 

```
devtools::install_github('JiaxiangBU/add2blog')
```

After successfully installation of `add2blog`, just library it!

```
library(add2blog)
```

## Build a wallpaper from your name

Inspired by Swanson (2015) and Chisato (2018), I create functions `matrix_name` and `graph_fun`.

```
library(tidyverse)
library(data.table)
library(add2blog)
matrix_me <- 
    add2blog::matrix_name('jiaxiangli',n = 10)
add2blog::graph_fun(matrix_me,fontsize=3)
```

![](https://github.com/JiaxiangBU/picbackup/blob/master/add2blog_sample_wallpaper.png?raw=true)

# Reference

Swanson, Ana. 2015. “10 Stunning Images Show the Beauty Hidden in Pi.” 2015. https://www.washingtonpost.com/news/wonk/wp/2015/03/14/10-stunning-images-show-the-beauty-hidden-in-pi/?noredirect=on&utm_term=.614dbc50c9aa.

Chisato. 2018. “VISUAL Art with Pi Using Ggplot2 & Circlize.” 2018. https://chichacha.netlify.com/2018/10/13/visual-art-with-pi-using-ggplot2-circlize/.









