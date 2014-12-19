format.src_biocdb <-
    function(x, ...)
{
    paste0("class: ", paste0(class(x), collapse=" "), "\n",
           .ppath("path", x$path), "\n",
           .ptbls(src_tbls(x)))
}

## anno

anno <-
    function(prefix, dplyr=TRUE, ...)
{
    if (missing(prefix))
        prefix <- .BIOCDB_RE
    pkgs <- .db_packages(prefix)
    if (.db_packages_exact_match(pkgs, prefix)) {
        pkgs <- .db_packages_filter(pkgs, prefix)
        pkgs <- .db_get(pkgs, dplyr, ...)
    }
    pkgs
}
