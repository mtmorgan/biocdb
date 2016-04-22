## anno

anno <-
    function(prefix, dplyr=FALSE, ...)
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
