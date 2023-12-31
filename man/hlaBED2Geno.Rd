\name{hlaBED2Geno}
\alias{hlaBED2Geno}
\title{
    Convert from PLINK BED format
}
\description{
    To convert a PLINK BED file to an object of \code{\link{hlaSNPGenoClass}}.
}
\usage{
hlaBED2Geno(bed.fn, fam.fn, bim.fn, rm.invalid.allele=FALSE,
    import.chr="xMHC", assembly="auto", verbose=TRUE)
}
\arguments{
    \item{bed.fn}{binary file, genotype information}
    \item{fam.fn}{family, individual information, etc}
    \item{bim.fn}{extended MAP file: two extra cols = allele names}
    \item{rm.invalid.allele}{if TRUE, remove SNPs with non-standard alleles
        (except A,G,C,T)}
    \item{import.chr}{the chromosome, "1" .. "22", "X", "Y", "XY", "MT",
        "xMHC", or "", where "xMHC" implies the extended MHC on chromosome 6,
        and "" for all SNPs; "6" for all SNPs on chromosome 6 for HLA;
        "19" for all SNPs on chromosome 19 for KIR}
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
    \code{\link{hlaGeno2PED}}, \code{\link{hlaGDS2Geno}}
}

\examples{
# Import a PLINK BED file
bed.fn <- system.file("extdata", "HapMap_CEU.bed", package="HIBAG")
fam.fn <- system.file("extdata", "HapMap_CEU.fam", package="HIBAG")
bim.fn <- system.file("extdata", "HapMap_CEU.bim", package="HIBAG")

hapmap.ceu <- hlaBED2Geno(bed.fn, fam.fn, bim.fn, assembly="hg19")
summary(hapmap.ceu)

# Or

hapmap.ceu <- hlaBED2Geno(bed.fn, fam.fn, bim.fn, assembly="hg19",
    rm.invalid.allele=TRUE, import.chr="6")
summary(hapmap.ceu)
}

\keyword{SNP}
\keyword{genetics}
