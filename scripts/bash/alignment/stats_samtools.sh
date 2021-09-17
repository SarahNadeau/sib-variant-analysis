#!/usr/bin/env bash

DATA=~/workdir/data

for SAMPLE_PREFIX in father mother son; do
echo -e "\nCalculating alignment statistics for: $SAMPLE_PREFIX"
samtools flagstat \
$DATA/alignments/${SAMPLE_PREFIX}_sorted_read_groups_marked_duplicates.bam \
> $DATA/alignments/${SAMPLE_PREFIX}_stats.txt
done
