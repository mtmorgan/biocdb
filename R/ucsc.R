ucsc <- function(prefix="hg19", dplyr=TRUE, ...)
{
    pkgs <- list(available=character(), installed=character())
    idx <- ifelse(nzchar(system.file(package="RMySQL")),
                  "installed", "available")
    pkgs[[idx]] <- "RMySQL"
    .db_get(pkgs, dplyr, ..., dbname=prefix)
}
