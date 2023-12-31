\name{hlaFlankingSNP}
\alias{hlaFlankingSNP}
\alias{hlaGenoSubsetFlank}
\title{
    SNP IDs or SNP genotypes in Flanking Region
}
\description{
    To get SNPs in the flanking region of a specified HLA/KIR locus.
}
\usage{
hlaFlankingSNP(snp.id, position, locus, flank.bp=500000L, assembly="auto",
    pos.mid=NA_integer_)
hlaGenoSubsetFlank(genoobj, locus="any", flank.bp=500000L, assembly="auto",
    pos.mid=NA_integer_)
}
\arguments{
    \item{snp.id}{a vector of SNP IDs}
    \item{genoobj}{a genotype object of \code{\link{hlaSNPGenoClass}}}
    \item{position}{a vector of positions}
    \item{locus}{the name of HLA locus, or "any" for other genes and using \code{pos.mid}}
    \item{flank.bp}{the size of flanking region on each side in basepair}
    \item{assembly}{the human genome reference: "hg18", "hg19" (default),
        "hg38"; "auto" refers to "hg19"; "auto-silent" refers to "hg19" without
        any warning}
    \item{pos.mid}{the middle position of the flanking region}
}
\details{
    \code{hla.id} is "A", "B", "C", "DRB1", "DRB5", "DQA1", "DQB1", "DPB1" or
        "any".
}
\value{
    Return selected SNP IDs from \code{snp.id}.
}
\author{Xiuwen Zheng}
\seealso{
    \code{\link{hlaGenoSubset}}, \code{\link{hlaLociInfo}}
}

\examples{
# make a "hlaAlleleClass" object
hla.id <- "A"
hla <- hlaAllele(HLA_Type_Table$sample.id,
    H1 = HLA_Type_Table[, paste(hla.id, ".1", sep="")],
    H2 = HLA_Type_Table[, paste(hla.id, ".2", sep="")],
    locus=hla.id, assembly="hg19")

# training genotypes
region <- 500   # kb
snpid <- hlaFlankingSNP(HapMap_CEU_Geno$snp.id, HapMap_CEU_Geno$snp.position,
    hla.id, region*1000, assembly="hg19")
train.geno <- hlaGenoSubset(HapMap_CEU_Geno,
    snp.sel  = match(snpid, HapMap_CEU_Geno$snp.id))
summary(train.geno)


# or using hlaGenoSubsetFlank
train.geno <- hlaGenoSubsetFlank(HapMap_CEU_Geno, hla.id, region*1000)
summary(train.geno)


## customize positions
snpid <- hlaFlankingSNP(HapMap_CEU_Geno$snp.id, HapMap_CEU_Geno$snp.position,
    "any", 500*1000, pos.mid=29954010)
}

\keyword{SNP}
\keyword{genetics}
