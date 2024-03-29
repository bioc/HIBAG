\name{hlaPredMerge}
\alias{hlaPredMerge}
\title{
    Merge prediction results from multiple HIBAG models
}
\description{
    Return an object of \code{\link{hlaAlleleClass}}, which contains predicted
HLA types.
}
\usage{
hlaPredMerge(..., weight=NULL, equivalence=NULL, use.matching=TRUE,
    ret.dosage=TRUE, ret.postprob=TRUE, max.resolution="", rm.suffix=FALSE)
}
\arguments{
    \item{...}{The object(s) of \code{\link{hlaAlleleClass}}, having a field
        of 'postprob', and returned by
        \code{hlaPredict(..., type="response+prob")}}
    \item{weight}{the weight used for each prediction; if \code{NULL},
        equal weights to be used; or set the weight vector to be the training
        sample sizes}
    \item{equivalence}{a \code{data.frame} with two columns, the first column
        for new equivalent alleles, and the second for the alleles possibly
        existed in the object(s) passed to this function}
    \item{use.matching}{if \code{TRUE}, use actual probabilities (i.e.,
        poster prob. * matching) for merging; otherwise, use poster prob.
        instead. \code{use.matching=TRUE} is recommended.}
    \item{ret.dosage}{if \code{TRUE}, return dosages}
    \item{ret.postprob}{if \code{TRUE}, return average posterior probabilities}
    \item{max.resolution}{"2-digit", "1-field", "4-digit", "2-field", "6-digit",
        "3-field", "8-digit", "4-field", "allele", "protein", "full", "none",
        or "": "allele" = "2-digit"; "protein" = "4-digit"; "full", "none" or
        "" for no limit on resolution}
    \item{rm.suffix}{whether remove the non-digit suffix in the last field,
        e.g., for "01:22N", "N" is a non-digit suffix}
}
\details{
    Calculate a new probability matrix for each pair of HLA alleles, by
averaging (posterior) probabilities from all models with specified weights.
If \code{equivalence} is specified, multiple alleles might be collapsed into
one class.
}
\value{
    Return a \code{\link{hlaAlleleClass}} object.
}
\author{Xiuwen Zheng}
\seealso{
    \code{\link{hlaAttrBagging}}, \code{\link{hlaAllele}},
    \code{\link{predict.hlaAttrBagClass}}
}

\examples{
# make a "hlaAlleleClass" object
hla.id <- "A"
hla <- hlaAllele(HLA_Type_Table$sample.id,
    H1 = HLA_Type_Table[, paste(hla.id, ".1", sep="")],
    H2 = HLA_Type_Table[, paste(hla.id, ".2", sep="")],
    locus=hla.id, assembly="hg19")

# divide HLA types randomly
set.seed(100)
hlatab <- hlaSplitAllele(hla, train.prop=0.5)
names(hlatab)
# "training"   "validation"
summary(hlatab$training)
summary(hlatab$validation)

# SNP predictors within the flanking region on each side
region <- 500   # kb
snpid <- hlaFlankingSNP(HapMap_CEU_Geno$snp.id, HapMap_CEU_Geno$snp.position,
    hla.id, region*1000, assembly="hg19")
length(snpid)  # 275

# training and validation genotypes
train.geno <- hlaGenoSubset(HapMap_CEU_Geno,
    snp.sel=match(snpid, HapMap_CEU_Geno$snp.id),
    samp.sel=match(hlatab$training$value$sample.id,
    HapMap_CEU_Geno$sample.id))
test.geno <- hlaGenoSubset(HapMap_CEU_Geno,
    samp.sel=match(hlatab$validation$value$sample.id,
    HapMap_CEU_Geno$sample.id))

# train HIBAG models
set.seed(100)

# please use "nclassifier=100" when you use HIBAG for real data
m1 <- hlaAttrBagging(hlatab$training, train.geno, nclassifier=2,
    verbose.detail=TRUE)
m2 <- hlaAttrBagging(hlatab$training, train.geno, nclassifier=2,
    verbose.detail=TRUE)


# validation
pd1 <- hlaPredict(m1, test.geno, type="response+prob")
pd2 <- hlaPredict(m2, test.geno, type="response+prob")

hlaCompareAllele(hlatab$validation, pd1)$overall
hlaCompareAllele(hlatab$validation, pd2)$overall

# merge predictions from multiple models, by voting from all classifiers
pd <- hlaPredMerge(pd1, pd2)
pd

hlaCompareAllele(hlatab$validation, pd)$overall

# collapse to 2-digit
pd <- hlaPredMerge(pd1, pd2, max.resolution="2-digit", ret.postprob=FALSE)
pd
}

\keyword{HLA}
\keyword{genetics}
