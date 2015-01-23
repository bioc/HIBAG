\name{hlaClose}
\alias{hlaClose}
\title{
    Dispose a model object
}
\description{
    Release all resources stored in the \code{\link{hlaAttrBagClass}} object.
The HIBAG package allows up to 256 \code{\link{hlaAttrBagClass}} objects
stored in memory.
}
\usage{
hlaClose(model)
}
\arguments{
    \item{model}{an object of \code{\link{hlaAttrBagClass}}}
}
\value{
    None.
}
\author{Xiuwen Zheng}
\seealso{
    \code{\link{hlaAttrBagging}}, \code{\link{summary.hlaAttrBagClass}}
}

\examples{
# make a "hlaAlleleClass" object
hla.id <- "DQB1"
hla <- hlaAllele(HLA_Type_Table$sample.id,
    H1 = HLA_Type_Table[, paste(hla.id, ".1", sep="")],
    H2 = HLA_Type_Table[, paste(hla.id, ".2", sep="")],
    locus=hla.id, assembly="hg19")

# training genotypes
region <- 100   # kb
snpid <- hlaFlankingSNP(HapMap_CEU_Geno$snp.id, HapMap_CEU_Geno$snp.position,
    hla.id, region*1000, assembly="hg19")
train.geno <- hlaGenoSubset(HapMap_CEU_Geno,
    snp.sel = match(snpid, HapMap_CEU_Geno$snp.id))

# train a HIBAG model
set.seed(1000)
model <- hlaAttrBagging(hla, train.geno, nclassifier=2)
print(model)

# close the HIBAG model explicitly
hlaClose(model)
}

\keyword{HLA}
\keyword{genetics}
