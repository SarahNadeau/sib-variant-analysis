#!/usr/bin/env bash

DATA=~/workdir/data

for SAMPLE in mother father son; do
    # Generate recalibration table from the read data, ignoring known variable sites from 2 databases
    gatk BaseRecalibrator \
    --reference $DATA/reference/Homo_sapiens.GRCh38.dna.chromosome.20.fa \
    --input $DATA/alignments/${SAMPLE}_sorted_read_groups_marked_duplicates.bam \
    --known-sites $DATA/variants/GCF.38.filtered.renamed.vcf \
    --known-sites $DATA/variants/1000g_gold_standard.indels.filtered.vcf \
    --output $DATA/alignments/${SAMPLE}_recal_data.txt

    # Apply base quality score recalibration based on the generated table
    gatk ApplyBQSR \
    --bqsr-recal-file $DATA/alignments/${SAMPLE}_recal_data.txt \
    --input $DATA/alignments/${SAMPLE}_sorted_read_groups_marked_duplicates.bam \
    --output $DATA/alignments/${SAMPLE}_sorted_read_groups_marked_duplicates_bqsr.bam
    
    # Call haplotypes on the recalibrated alignment file, focusing on region chr20:10018000-10220000.
    gatk HaplotypeCaller \
    --input $DATA/alignments/${SAMPLE}_sorted_read_groups_marked_duplicates_bqsr.bam \
    --output $DATA/variants/${SAMPLE}.vcf.gz \
    --reference $DATA/reference/Homo_sapiens.GRCh38.dna.chromosome.20.fa \
    --intervals chr20:10018000-10220000 \
    --emit-ref-confidence GVCF \
    --bam-output $DATA/alignments/${SAMPLE}_sorted_read_groups_marked_duplicates_bqsr_phased.bam

    # Summarize variant calling results
    echo "Found this many variants for $SAMPLE:"
    zcat $DATA/variants/${SAMPLE}.vcf.gz | grep -v '^#' | wc -l

    # Get more statistics
    gatk VariantsToTable \
    --variant $DATA/variants/${SAMPLE}.vcf.gz \
    --fields CHROM -F POS -F TYPE -GF GT \
    --output $DATA/variants/${SAMPLE}_stats.txt

    echo "Found this many SNPs for $SAMPLE:"
    grep "SNP" $DATA/variants/${SAMPLE}_stats.txt | wc -l

    echo "Found this many INDELs for $SAMPLE:"
    grep "INDEL" $DATA/variants/${SAMPLE}_stats.txt | wc -l
done
