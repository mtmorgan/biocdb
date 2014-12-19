## .db_packages

.BIOCDB_RE <- "(org\\.|TxDb\\.|FDb\\.|BSgenome\\.|SNPlocs\\.)"

.db_packages <-
    function(prefix)
{
    tidy <- function(x, prefix)
        grep(prefix, rownames(x), ignore.case=TRUE, value=TRUE)
    prefix <- sprintf("^%s", prefix)
    installed <- tidy(installed.packages(), prefix)
    contrib <- contrib.url(biocinstallRepos()[["BioCann"]])
    available <- tidy(available.packages(contriburl=contrib), prefix)
    pkgs <- list(installed=intersect(installed, available),
                 available=setdiff(available, installed))
    class(pkgs) <- "db_packages"
    pkgs
}

.db_packages_exact_match <- function(pkgs, pkg) {
    ## one pkg
    tst <- sum(vapply(pkgs, length, integer(1))) == 1L
    ## or one exact match
    tst || sum(vapply(pkgs, function(elts, pkg) {
        sum(match(elts, pkg, 0))
    }, integer(1), pkg) == 1L)
}

.db_packages_filter <- function(pkgs, pkg) {
    ## single package...
    if (sum(vapply(pkgs, length, integer(1))) != 1L)
        ## ... or filter to include only exact match
        pkgs <- lapply(pkgs, function(elts) elts[elts %in% pkg])
    pkgs
}

print.db_packages <-
    function(x, ...)
{
    .printgrp <- function(x, key, n) {
        cat(key, "\n")
        for (i in seq_along(x[[key]])) {
            if ((i != 1L) && (i %% n == 0)) cat("\n")
            cat(x[[key]][[i]])
        }
        cat("\n")
    }
    wd <- max(nchar(unlist(x)))
    n <- floor(getOption("width") / (wd + 4L))
    fmt <- paste0("    %-", wd, "s")
    x <- lapply(x, sprintf, fmt=fmt)
    key <- "installed"
    .printgrp(x, "available", n)
    .printgrp(x, "installed", n)
}
