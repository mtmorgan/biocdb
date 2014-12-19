.native_get <- function(cls, pkg, nmspc, ...)
    UseMethod(".native_get")

.native_get.default <- function(cls, pkg, nmspc, ...)
    get(pkg, nmspc)

.native_get.RMySQL <-
    function(cls, pkg, nmspc, ..., dbname)
{
    drv <- RMySQL::MySQL(fetch.default.rec=100000L)
    RMySQL::dbConnect(drv, user="genome", host="genome-mysql.cse.ucsc.edu",
                      dbname=dbname)
}

