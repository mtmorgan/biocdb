.db_get <-
    function(pkgs, dplyr, ..., dbname, verbose=TRUE)
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
                message("'dplyr' representation...")
            obj <- structure(list(), class=paste0("src_", cls))
            .dplyr_get(obj, pkg, nmspc, ..., dbname=dbname)
        }, error=function(e) {
            if (verbose)
                message("...failed: ", conditionMessage(e))
            NULL
        })
    if (is.null(db))
        db <- tryCatch({
            if (verbose)
                message("'native' representation...")
            obj <- structure(list(), class=cls)
            .native_get(obj, pkg, nmspc, ..., dbname=dbname)
        }, error=function(e) {
            if (verbose)
                message("...failed: ", conditionMessage(e))
            NULL
        })
    if (is.null(db) && verbose)
        message("representation failed")
    db
}
