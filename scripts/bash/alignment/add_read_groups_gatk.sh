#!/usr/bin/env bash

DATA=~/workdir/data

# for SAMPLE_PREFIX in father mother son; do
SAMPLE_PREFIX=mother
gatk AddOrReplaceReadGroups \
--INPUT $DATA/alignments/${SAMPLE_PREFIX}_sorted.bam \
--OUTPUT $DATA/alignments/${SAMPLE_PREFIX}_sorted_read_groups.bam \
--RGID H0164.2 \
--RGLB lib1 \
--RGPL ILLUMINA \
--RGPU H0164.2.ALXX140820 \
--RGSM $SAMPLE_PREFIX
# done