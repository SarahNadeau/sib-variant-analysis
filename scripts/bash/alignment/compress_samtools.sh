#!/usr/bin/env bash

DATA=~/workdir/data

for SAMPLE_PREFIX in father mother son; do
echo -e "\nCompressing alignment for: $SAMPLE_PREFIX"
samtools view -bh \
$DATA/alignments/${SAMPLE_PREFIX}_sorted.sam \
> $DATA/alignments/${SAMPLE_PREFIX}_sorted.bam
done
