# FastqAnalysis Cut&Tag
This repository will help users to extract important aspects from a DNA Sequence. There will be instructions from the initial steps of retrieving SRA files down to a snapshot of the usable data from the provided sequence. There will be a database with example datasets to be used in the pipeline. The provided datasets will be Cut&Tag data on human cells in the study GSE124557 (which can be accessed via GEO). The database will provide users with the accession number, links to retrieve FASTQ files via wget, and characteristics about each sample.

Before using, make sure all bash commands have proper permissions and are executable with chmod +x <script.sh>

The order of this pipeline will be as follows:

1. [howTo.txt](https://github.com/ibryant2/FastqAnalysis_Cut-Tag/blob/main/howTo.txt)
   This file will provide users with pre-processing bash commands and additional details about each script.
   This file will also provide users with optional commands to make the data more usable.

2. ctagData.sql
   This sql database will create the table (ctag_data) and provide the user with a few useful queries.
   The database can be used to isolate specific samples and help the user decide which samples to analyze.
   Usage is provided in the howTo.txt file.

4. TrimGalore.sh
   This bash script will trim adapters from the FASTQ files after initial processing is complete.
   Users will need to define the samples within the script before execution.
   There is an example of how to do this in the comment.
   Currently, the example sample (esc_k27me3) is in the sample position, but it can be changed.
   You can add multiple samples for the script to dynamically loop through.

5. sequenceExtraction.sh
   This bash script will extract the DNA Sequences from both forward and reverse strands of each sample.
   The DNA sequences from both forward and reverse strands will be combined into a single .txt file.
   If the user would like to only use one strand, they can remove the second input option from the script.
   Multiple samples can be input and looped dynamically.

6. analysis.py
   This python script will analyze a DNA Sequence (1 line from the .txt file) of the user's choice.
   The information will print to the screen unless directed otherwise (instructions in howTo.txt).
