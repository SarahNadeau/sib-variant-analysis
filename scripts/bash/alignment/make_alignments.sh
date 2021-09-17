#!/usr/bin/env bash

# This script generates an alignment to reference and alignment stats from FASTQ files.

DATA=~/workdir/data
READ_GROUPS=$DATA/read_groups.txt

cat $READ_GROUPS | while read SM LB PU ID; do
    bwa mem $DATA/reference/Homo_sapiens.GRCh38.dna.chromosome.20.fa \
    $DATA/fastq/"$SM"_R1.fastq.gz \
    $DATA/fastq/"$SM"_R2.fastq.gz \
    | samtools sort \
    | samtools view -bh > $DATA/alignments/${SM}_sorted.bam

    gatk AddOrReplaceReadGroups \
    --INPUT $DATA/alignments/${SM}_sorted.bam \
    --OUTPUT $DATA/alignments/${SM}_sorted_read_groups.bam \
    --RGLB $LB \
    --RGPU $PU \
    --RGPL ILLUMINA \
    --RGSM $SM \
    --RGID $ID

    gatk MarkDuplicates \
    --INPUT $DATA/alignments/${SM}_sorted_read_groups.bam \
    --OUTPUT $DATA/alignments/${SM}_sorted_read_groups_marked_duplicates.bam \
    --METRICS_FILE $DATA/alignments/${SM}_duplicate_metrics.txt

    samtools index $DATA/alignments/${SM}_sorted.bam

    samtools flagstat $DATA/alignments/${SM}_sorted_read_groups_marked_duplicates.bam \
    > $DATA/alignments/${SM}_stats.txt
done 