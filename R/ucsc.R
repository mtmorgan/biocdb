ucsc <- function(prefix, dplyr=TRUE, ...)
{
    if (dplyr)
        src_mysql(user="genome", host="genome-mysql.cse.ucsc.edu",
                  dbname=prefix)
    else
        stop("ucsc, dplyr=FALSE not yet implemented")
}
