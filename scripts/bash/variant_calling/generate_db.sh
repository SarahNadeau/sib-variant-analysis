#!/usr/bin/env bash

DATA=~/workdir/data

# Generate DB
gatk GenomicsDBImport \
--variant $DATA/variants/mother.vcf.gz \
--variant $DATA/variants/father.vcf.gz \
--variant $DATA/variants/son.vcf.gz \
--intervals chr20:10018000-10220000 \
--genomicsdb-workspace-path ~/workdir/genomicsdb

# Get combined VCF from DB
gatk GenotypeGVCFs \
--reference $DATA/reference/Homo_sapiens.GRCh38.dna.chromosome.20.fa \
--variant gendb://genomicsdb \
--intervals chr20:10018000-10220000 \
--output $DATA/variants/trio.vcf