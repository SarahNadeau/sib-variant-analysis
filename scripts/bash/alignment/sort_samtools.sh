#!/usr/bin/env bash

DATA=~/workdir/data

for SAMPLE_PREFIX in father mother son; do
echo -e "\nSorting alignment for: $SAMPLE_PREFIX"
samtools sort \
$DATA/alignments/${SAMPLE_PREFIX}.sam \
> $DATA/alignments/${SAMPLE_PREFIX}_sorted.sam
done
