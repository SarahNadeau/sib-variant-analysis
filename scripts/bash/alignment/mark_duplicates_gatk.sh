#!/usr/bin/env bash

DATA=~/workdir/data

# for SAMPLE_PREFIX in father mother son; do
SAMPLE_PREFIX=mother
gatk MarkDuplicates \
--INPUT $DATA/alignments/${SAMPLE_PREFIX}_sorted_read_groups.bam \
--METRICS_FILE $DATA/alignments/${SAMPLE_PREFIX}_duplicate_metrics.txt \
--OUTPUT $DATA/alignments/${SAMPLE_PREFIX}_sorted_read_groups_marked_duplicates.bam \
# done