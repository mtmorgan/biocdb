.db_packages <-
    function(pattern)
{
    tidy <- function(x, pattern)
        grep(pattern, rownames(x), value=TRUE)
    installed <- tidy(installed.packages(), pattern)
    contrib <- contrib.url(biocinstallRepos()[["BioCann"]])
    available <- tidy(available.packages(contriburl=contrib), pattern)
    pkgs <- list(installed=installed,
                 available=setdiff(available, installed))
    class(pkgs) <- "db_packages"
    pkgs
}

print.db_packages <-
    function(x, ...)
{
    .printgrp <- function(x, key, n) {
        cat(key, "\n")
        for (i in seq_along(x[[key]])) {
            cat(x[[key]][[i]])
            if (i %% n == 0) cat("\n")
        }
    }
    n <- floor(getOption("width") / (max(nchar(unlist(x))) + 2L))
    x <- lapply(x, sprintf, fmt="  %s")
    key <- "installed"
    .printgrp(x, "installed", n)
    .printgrp(x, "available", n)
}

format.src_txdb <-
    function(x, ...)
{
    paste0("class: ", class(x)[1], "\n",
           .ppath("path", t$path), "\n",
           dplyr:::wrap("tbls: ", paste0(sort(src_tbls(x)), collapse = ", ")))
}

.get_db <-
    function(pkg, cls, dplyr)
{
    nmspc <- loadNamespace(pkg)
    db <- get(pkg, envir=nmspc)
    if (dplyr) {
        db <- src_sqlite(db$conn@dbname)
        class(db) <- c(cls, class(db))
    }
    db
}

txdb <-
    function(pkg, dplyr=TRUE)
{
    if (missing(pkg))
        .db_packages("TxDb")
    else
        .get_db(pkg, "src_txdb", dplyr)
}

