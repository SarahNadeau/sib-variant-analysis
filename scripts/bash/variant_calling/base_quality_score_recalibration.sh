#!/usr/bin/env bash

DATA=~/workdir/data

for SAMPLE_PREFIX in father mother son; do
echo -e "\nRecalibrating base scores for: $SAMPLE_PREFIX"

# Generate recalibration table from the read data, ignoring known variable sites from 2 databases
gatk BaseRecalibrator \
--reference $DATA/reference/Homo_sapiens.GRCh38.dna.chromosome.20.fa \
--input $DATA/alignments/${SAMPLE_PREFIX}_sorted_read_groups_marked_duplicates.bam \
--known-sites $DATA/variants/GCF.38.filtered.renamed.vcf \
--known-sites $DATA/variants/1000g_gold_standard.indels.filtered.vcf \
--output $DATA/alignments/${SAMPLE_PREFIX}_recal_data.txt

# Apply base quality score recalibration based on the generated table
gatk ApplyBQSR \
--bqsr-recal-file $DATA/alignments/${SAMPLE_PREFIX}_recal_data.txt \
--input $DATA/alignments/${SAMPLE_PREFIX}_sorted_read_groups_marked_duplicates.bam \
--output $DATA/alignments/${SAMPLE_PREFIX}_sorted_read_groups_marked_duplicates_bqsr.bam
done
