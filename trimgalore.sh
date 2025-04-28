#!/bin/bash

# Define an array with the sample identifiers [e.g. ("esc_k27me3" "esc_igg")].
samples=("esc_k27me3")

# Loop through each sample.
for sample in "${samples[@]}"; do
    # Define input files based on the sample.
    input1="${sample}_1.fastq"
    input2="${sample}_2.fastq"

    # Define output basename and log file for your trimmed output samples.
    base="${sample}"
    log_output="tg.${sample}.out"

    # Run the bowtie2 command for each sample.

    trim_galore --paired "$input1" "$input2" --basename "$base" --cores 6 2>> "$log_output"

done

