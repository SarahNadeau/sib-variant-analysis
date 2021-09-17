#!/usr/bin/env bash

DATA=~/workdir/data

# Create index for the reference genome reference/Homo_sapiens.GRCh38.dna.chromosome.20.fa
samtools faidx $DATA/reference/Homo_sapiens.GRCh38.dna.chromosome.20.fa
gatk CreateSequenceDictionary --REFERENCE $DATA/reference/Homo_sapiens.GRCh38.dna.chromosome.20.fa

# Create index for a part of the dbsnp database: variants/GCF.38.filtered.renamed.vcf
gatk IndexFeatureFile --input $DATA/variants/GCF.38.filtered.renamed.vcf

# Create index for a part of the 1000 genomes indel golden standard: variants/1000g_gold_standard.indels.filtered.vcf
gatk IndexFeatureFile --input $DATA/variants/1000g_gold_standard.indels.filtered.vcf