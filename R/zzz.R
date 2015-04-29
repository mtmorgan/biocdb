.onLoad <-
    function(libname, pkgname)
{
    .mapper_add("biomart", structure(list(
        description="biomart.org web service",
        url="http://biomart.org:80/biomart/martservice",
        resource=sprintf("?type=registry_archive&requestid=%s", pkgname)),
        class=c("biomart", "mapper")))
}
