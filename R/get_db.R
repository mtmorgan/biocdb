## .get_native

.get_native <- function(cls, pkg, nmspc)
    UseMethod(".get_native")

.get_native.default <- function(cls, pkg, nmspc)
    get(pkg, nmspc)

## .get_dplyr

.get_dplyr <- function(cls, pkg, nmspc)
    UseMethod(".get_dplyr")

.get_dplyr.src_biocdb <-
    function(cls, pkg, nmspc)
{
    db <- get(pkg, nmspc)
    con <- src_sqlite(db$conn@dbname)
    structure(con, class=c(class(cls), class(con)))
}

.get_dplyr.src_org <-
    function(cls, pkg, nmspc)
{
    fun <- sub(".db$", "_dbfile", pkg)
    fname <- do.call(fun, list(), envir=nmspc)
    con <- src_sqlite(fname)
    structure(con, class=c(class(cls), class(con)))
}

## .get_db

.get_db <-
    function(pkgs, dplyr, ..., verbose=TRUE)
{
    if (length(pkgs$available) == 1L) {
        pkg <- pkgs$available
        biocLite(pkg, ...)
    } else pkg <- pkgs$installed

    suppressPackageStartupMessages({
        nmspc <- loadNamespace(pkg)
    })

    cls <- c(sub("([^.]+).*", "\\1", pkg), "biocdb")
    db <- NULL
    if (dplyr)
        db <- tryCatch({
            if (verbose)
                message("trying 'dplyr' representation")
            obj <- structure(list(), class=paste0("src_", cls))
            .get_dplyr(obj, pkg, nmspc)
        }, error=function(e) NULL)
    if (is.null(db))
        db <- tryCatch({
            if (verbose)
                message("trying 'native' representation")
            obj <- structure(list(), class=cls)
            .get_native(obj, pkg, nmspc)
        }, error=function(e) NULL)
    if (is.null(db) && verbose)
        message("representation failed")
    db
}
