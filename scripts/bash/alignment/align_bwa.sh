#!/usr/bin/env bash

DATA=~/workdir/data

for SAMPLE_PREFIX in father mother son; do
echo -e "\nAligning reads for: $SAMPLE_PREFIX"
bwa mem \
$DATA/reference/Homo_sapiens.GRCh38.dna.chromosome.20.fa \
$DATA/fastq/${SAMPLE_PREFIX}_R1.fastq.gz \
$DATA/fastq/${SAMPLE_PREFIX}_R2.fastq.gz \
> $DATA/alignments/${SAMPLE_PREFIX}.sam
done
