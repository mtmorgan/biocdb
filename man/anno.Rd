\name{anno}
\alias{anno}
\title{Bioconductor annotation resources}
\description{

  Use this function to discover, load, and use Bioconductor annotation
  resources.

}

\usage{
anno(prefix, dplyr=FALSE, ...)
}

\arguments{

  \item{prefix}{(Optional) character(1) List or retrieve annotation
    resources whose package name begins with prefix. If the prefix
    matches a package name exactly, or if the prefix matches only a
    single package, then the package is installed (if necessary) and
    attached to the current session.}

  \item{dplyr}{(Optional) logical(1) Attempt to create a dplyr
    representation of the annotation resource. Not all Bioconductor
    annotation resources are data bases, so this attempt may often
    fail. The return value will then be a 'native' representation e.g.,
    a \code{BSgenome} object) or, if no single native representation can
    be discovered, \code{NULL}.}

  \item{...}{Additional arguments, not currently implemented.}

}

\details{

  When \code{prefix} is missing, this function queries the Bioconductor
  annotation package repository for available packages that are commonly
  used for annotation of sequence and other high-throughput genomic
  data, and compares these with packages installed in the current R
  session.

  A prefix serves as a filter on installed and available packages, e.g.,
  \code{prefix="TxDb"} restricts the listing of packages to those
  whose names begin with \code{TxDb}.

  When the prefix is sufficiently specific that a single available or
  installed package is matched (e.g., \code{org.Hs.e}), or the prefix
  matches a package exactly (e.g., \code{TxDb.Dmelanogaster.UCSC.hg19}),
  then the package is installed (if necessary) and attached to the
  current R session. Many Bioconductor annotation packages are data
  bases, or have a single object that is used to access the content of
  the package. \code{anno()} attempts to return a \code{dplyr}
  representation of data bases (unless \code{dplyr=FALSE}) or the
  single-object representation.

}

\value{

  When more than a single package is selected by \code{prefix}, a list
  of \code{available} and \code{installed} packages.

  When a single package is selected by \code{prefix}, a \code{dplyr} or
  \sQuote{native} representation of the object, or if no representation
  is available NULL. Regardless of the return value, a side effect of a
  match is that the selected package is loaded in the current R session.

}

\seealso{

  Bioconductor \sQuote{Annotation} biocViews,
  \url{http://bioconductor.org/packages/release/BiocViews.html#___AnnotationData}.

}

\author{Martin Morgan \url{mailto:mtmorgan@fredhutch.org}}

\examples{
anno()              # commonly used annotation packages
anno("")            # all annotation packages
anno("TxDb")        # 'Transcript Db' (gene model) annotation packages

\dontrun{
## unique match to TxDb.Dmelanogaster.UCSC.dm3.ensGene,
## package attached and interface returned
d = anno("TxDb.Dmel")              # classic API
d = anno("TxDb.Dmel", dplyr=TRUE)  # dplyr API
}
}