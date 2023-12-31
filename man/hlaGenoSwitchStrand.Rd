\name{hlaGenoSwitchStrand}
\alias{hlaGenoSwitchStrand}
\title{
    Allele flipping if needed
}
\description{
    Determine the ordered pair of A and B alleles, using the allele information
provided by \code{template}.
}
\usage{
hlaGenoSwitchStrand(target, template,
    match.type=c("Position", "Pos+Allele", "RefSNP+Position", "RefSNP"),
    same.strand=FALSE, verbose=TRUE)
}
\arguments{
    \item{target}{an object of \code{\link{hlaSNPGenoClass}}}
    \item{template}{a genotypic object of \code{\link{hlaSNPGenoClass}},
        a model object of \code{\link{hlaAttrBagClass}} or
        a model object of \code{\link{hlaAttrBagObj}}}
    \item{match.type}{\code{"RefSNP+Position"} (by default) -- using both of
        RefSNP IDs and positions; \code{"RefSNP"} -- using RefSNP IDs only;
        \code{"Position"} -- using positions only}
    \item{same.strand}{\code{TRUE} assuming alleles are on the same strand
        (e.g., forward strand); otherwise, \code{FALSE} not assuming whether
        on the same strand or not}
    \item{verbose}{show information, if TRUE}
}
\details{
    The A/B pairs of \code{target} are determined using the information from
\code{template}.
}
\value{
    Return a \code{\link{hlaSNPGenoClass}} object consisting of the SNP
intersect between \code{target} and \code{template}.
}
\author{Xiuwen Zheng}
\seealso{
    \code{\link{hlaMakeSNPGeno}}, \code{\link{hlaGenoSubset}}
}

\examples{
summary(HapMap_CEU_Geno)
# A/C A/G C/T G/T 
# 136 655 632 141 

# import a PLINK BED file
bed.fn <- system.file("extdata", "HapMap_CEU.bed", package="HIBAG")
fam.fn <- system.file("extdata", "HapMap_CEU.fam", package="HIBAG")
bim.fn <- system.file("extdata", "HapMap_CEU.bim", package="HIBAG")
hapmap.ceu <- hlaBED2Geno(bed.fn, fam.fn, bim.fn, assembly="hg19")
summary(hapmap.ceu)
# A/C  A/G  A/T  C/G  C/T  G/T
# 332 1567   64  111 1510  348

# combine two datasets together
geno <- hlaGenoSwitchStrand(HapMap_CEU_Geno, hapmap.ceu)
summary(geno)
# There are 1564 SNPs in common.
# The allele pairs of 763 SNPs need to be switched.
# A/C A/G C/T G/T
# 104 505 496 109
}

\keyword{SNP}
\keyword{genetics}
