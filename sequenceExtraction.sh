#!/bin/bash
# Name: Iesha Bryant
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

# Define sample names if using multiple ex: samples=("esc_k27me3" "esc_igg")
samples=("esc_k27me3")

# Process each sample
for sample in "${samples[@]}"; do
    # Define input files
    input1="${sample}_val_1.fq"
    input2="${sample}_val_2.fq"

    # Define output file
    output="dna_${sample}.txt"
    > "$output"

    # Extract sequences skipping header, separator and quality lines
    # and combine into output.
    awk 'NR % 4 == 2 && !/N/' "$input1" >> "$output"
    awk 'NR % 4 == 2 && !/N/' "$input2" >> "$output"
done
