#!/bin/bash
## Name: Iesha Bryant
# EMAIL: ibryant@unmc.edu
# Class: BMI 8540, Spring 2025
# Assignment #: final
#
# Honor Pledge: On my honor as a student of the University of Nebraska at
# Omaha, I have neither given nor received unauthorized help on
# this programming assignment.
#
# Partners: NONE
#
# Sources: NONE
#

# Define an array with the sample identifiers ("esc_k27me3" "esc_igg")
samples=("esc_k27me3")

# Loop through each sample
for sample in "${samples[@]}"; do
    # Define input files based on the sample
    input1="${sample}_1.fastq"
    input2="${sample}_2.fastq"

    # Define basename and log file based on the sample
    base="${sample}"
    log_output="tg.${sample}.log"

    # Run the trim_galore command for each sample

    trim_galore --paired "$input1" "$input2" --basename "$base" --cores 6 2>> "$log_output"

done
