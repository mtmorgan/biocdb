.dplyr_get <- function(cls, pkg, nmspc, ...)
    UseMethod(".dplyr_get")

.dplyr_get.src_biocdb <-
    function(cls, pkg, nmspc, ...)
{
    db <- get(pkg, nmspc)
    con <- src_sqlite(db$conn@dbname)
    structure(con, class=c(class(cls), class(con)))
}

.dplyr_get.src_org <-
    function(cls, pkg, nmspc, ...)
{
    fname <- AnnotationDbi::dbfile(nmspc[[pkg]])
    con <- src_sqlite(fname)
    structure(con, class=c(class(cls), class(con)))
}

.dplyr_get.src_Organism <-
    function(cls, pkg, nmspc, ...)
{
    fnames <- AnnotationDbi::dbfile(nmspc[[pkg]])
    con <- lapply(fnames, src_sqlite)
    structure(con, class=c(class(cls), class(con[[1]])))
}

.dplyr_get.src_RMySQL <-
    function(cls, pkg, nmspc, ..., dbname)
{
    ## more circuitiuitous to allow specifcation of download chunks
    con <- .native_get.RMySQL(cls, pkg, nmspc, ..., dbname=dbname)
    info <- RMySQL::dbGetInfo(con)
    db <- src_sql("mysql", con, info = info,
                  disco = dplyr:::db_disconnector(con, "mysql"))
    db$path <- sprintf("%s@%s/%s", info$user, info$host, info$dbname)
    class(db) <- c(class(cls), class(db))
    db
}
