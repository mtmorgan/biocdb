format.src_biocdb <-
    function(x, ...)
{
    paste0("class: ", class(x)[1], "\n",
           .ppath("path", x$path), "\n",
           dplyr:::wrap("tbls: ", paste0(sort(src_tbls(x)), collapse = ", ")))
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
        pkgs <- .get_db(pkgs, dplyr, ...)
    }
    pkgs
}
