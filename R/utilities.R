## 'pretty' printing

.ppath <- function(tag, filepath)
{
    wd <- getOption("width") - nchar(tag) - 6
    if (0L == length(filepath) || nchar(filepath) < wd)
        return(sprintf("%s: %s", tag, filepath))
    bname <- basename(filepath)
    wd1 <- wd - nchar(bname)
    dname <- substr(dirname(filepath), 1, wd1)
    sprintf("%s: %s...%s%s",
            tag, dname, .Platform$file.sep, bname)
}

.ptbls <- function(x) {
    len <- length(x)
    x <- paste0(head(sort(x), 10), collapse=", ")
    tag <- if (len > 10) {
        sprintf("tbls (%d total): %s, ...", len, x)
    } else sprintf("tbls: %s", x)
    paste0(strwrap(tag, exdent=2, width=getOption("width")), collapse="\n")
}
