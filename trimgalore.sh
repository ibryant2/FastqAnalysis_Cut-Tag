#!/bin/bash

# Define an array with the sample identifiers (e.g., ut, e6, e6_aux, aux)
samples=("esc_k27me3")

# Loop through each sample
for sample in "${samples[@]}"; do
    # Define input files based on the sample
    input1="${sample}_1.fastq"
    input2="${sample}_2.fastq"

    # Define output SAM file and log file based on the sample
    base="${sample}"
    log_output="tg.${sample}.out"

    # Run the bowtie2 command for each sample

    trim_galore --paired "$input1" "$input2" --basename "$base" --cores 6 2>> "$log_output"

done

