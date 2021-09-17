#!/opt/conda/bin/Rscript

# Calculate genotype likelihood.
# Where:
#     m : ploidy
#     g : number of alternative alleles
#     e : base error probability
#     ref : number of reference alleles counted
#     alt : number of alternative alleles counted
genotype_likelihood <- function(m,g,e,ref,alt){
  (((m-g)*e+g*(1-e))^alt * ((m-g)*(1-e)+g*e)^ref)/(m^(ref+alt))
}

# calculate the three genotype likelihoods (for g = 0, g = 1 and g = 2) 
# for a case where we count 22 reference alleles and 4 alternative alleles (so a coverage of 26)
# and base error probability of 0.01. 
# Calculate the PL values (-10*log10(likelihood)) for each genotype. 

genotype_likelihoods <- lapply(
    X = list(0, 1, 2),
    FUN = genotype_likelihood,
    m = 2,
    e = 0.01,
    ref = 22,
    alt = 4
)

print("Results for genotype values 0, 1, 2:")
for (l in genotype_likelihoods) {
    print(paste("Genotype likelihood:", l))
    pl <- -10 * log10(l)
    print(paste("Phred-scale genotype likelihood:", pl))
}

