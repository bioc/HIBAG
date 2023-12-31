\name{hlaGDS2Geno}
\alias{hlaGDS2Geno}
\title{
    Import genotypes from a GDS file
}
\description{
    To convert a SNPRelate or SeqArray GDS file to an object of \code{hlaSNPGenoClass}.
}
\usage{
hlaGDS2Geno(gds.fn, rm.invalid.allele=FALSE, import.chr="xMHC", assembly="auto",
    verbose=TRUE)
}
\arguments{
    \item{gds.fn}{a file name for the GDS file defined in the SNPRelate or SeqArray
        package}
    \item{rm.invalid.allele}{if TRUE, remove SNPs with non-standard alleles
        (except A,G,C,T)}
    \item{import.chr}{the chromosome, "1" .. "22", "X", "Y", "XY", "MT",
        "xMHC", or "", where "xMHC" implies the extended MHC on chromosome 6,
        and "" for all SNPs}
    \item{assembly}{the human genome reference: "hg18", "hg19" (default),
        "hg38"; "auto" refers to "hg19"; "auto-silent" refers to "hg19" without
        any warning}
    \item{verbose}{if TRUE, show information}
}
\value{
    Return an object of \code{\link{hlaSNPGenoClass}}.
}
\author{Xiuwen Zheng}
\seealso{
    \code{\link{hlaGeno2PED}}, \code{\link{hlaBED2Geno}}
}

\examples{
# Import a SNP GDS file
fn <- system.file("extdata", "HapMap_CEU_Chr6.gds", package="HIBAG")

geno <- hlaGDS2Geno(fn, assembly="hg18", rm.invalid.allele=TRUE)

summary(geno)
}

\keyword{SNP}
\keyword{genetics}
