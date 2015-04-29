.db_get <-
    function(pkgs, dplyr, ..., dbname, verbose=TRUE)
{
    if (length(pkgs$available) == 1L) {
        pkg <- pkgs$available
        biocLite(pkg, ...)
    } else pkg <- pkgs$installed

    nmspc <- suppressPackageStartupMessages(tryCatch({
        loadNamespace(pkg)
    }, error=function(err) {
        ## FIXME: this is here because Homo.sapiens & friends are not
        ## able to loadNamespace()
        require(pkg, character.only=TRUE)
        getNamespace(pkg)
    }))

    cls <- c(sub("([^.]+).*", "\\1", pkg), "biocdb")
    cls <- sub("^(Homo|Mus|Rattus)", "Organism", cls)
    db <- NULL
    if (dplyr)
        db <- tryCatch({
            if (verbose)
                message("'dplyr' representation...")
            obj <- structure(list(), class=paste0("src_", cls))
            .dplyr_get(obj, pkg, nmspc, ..., dbname=dbname)
        }, error=function(e) {
            if (verbose)
                message("... failed: ", conditionMessage(e))
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
