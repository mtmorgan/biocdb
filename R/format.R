format.src_biocdb <-
    function(x, ...)
{
    paste0("class: ", paste0(class(x), collapse=" "), "\n",
           .ppath("path", x$path), "\n",
           .ptbls(src_tbls(x)))
}

format.src_Organism <-
    function(x, ...)
{
    paste0(lapply(x, format), collapse="\n\n")
}
