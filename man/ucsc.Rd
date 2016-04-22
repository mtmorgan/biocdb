\name{ucsc}
\alias{ucsc}
\title{UCSC MySQL-based annotation resources}
\description{

  Use this function to discover, load, and use UCSC MySQL annotation
  resources. The \code{ucsc} function requires the RMySQL package
  (typically requring installation of a MySQL client and requiring
  advanced understanding on Windows, as described in the RMySQL package
  INSTALL file).

}

\usage{
ucsc(prefix, dplyr=TRUE, ...)
}

\arguments{

  \item{prefix}{(Optional) character(1) List or retrieve annotation
    resources from the UCSC data base whose name exactly matches
    prefix. The default data base is \code{hg19}.}

  \item{dplyr}{(Optional) logical(1) Create a dplyr native
  (\code{RMySQLConnection}) representation of the UCSC SQL data base.}

  \item{...}{Additional arguments, not currently implemented.}

}

\value{

  A \code{dplyr} or \sQuote{native} (\code{RMySQLConnection})
  representation of the data base.

  A side effect is installation or attachment of the RMySQL package to
  the current R session.

}

\seealso{

  The UCSC genome browser MySQL database description page,
  \url{http://genome.ucsc.edu/goldenPath/help/mysql.html}.

}

\author{Martin Morgan \url{mailto:mtmorgan@fredhutch.org}}

\examples{
ucsc("hg38")
}