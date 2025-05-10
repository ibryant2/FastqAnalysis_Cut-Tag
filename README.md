# FastqAnalysis Cut&Tag
# A project to analyze Cut&Tag data from SRA or FASTQ format.
This repository will help users to extract important aspects from a DNA Sequence. There will be instructions from the initial steps of retrieving SRA files down to a snapshot of the usable data from the provided sequence. There will be a database with example datasets to be used in the pipeline. The provided datasets will be Cut&Tag data on human cells. 

You can access the associated paper at https://pmc.ncbi.nlm.nih.gov/articles/PMC6488672/ and the data in the study can be accessed via NCBI GEO https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE124557 (GSE124557). The database will provide users with the characteristics of each sample, an SRA accession number, and links to retrieve FASTQ files via wget.

Before using, make sure all bash commands have proper permissions and are executable with chmod +x <script.sh>

The order of this pipeline will be as follows:

**A step-by-step guide**

1. [howTo.txt](https://github.com/ibryant2/FastqAnalysis_Cut-Tag/blob/main/howTo.txt)
   This file will provide users with pre-processing bash commands and additional details about each script.
   This file will also provide users with optional commands to make the data more usable.

**A working database implementation**

2. [ctagData.sql](https://github.com/ibryant2/FastqAnalysis_Cut-Tag/blob/main/ctagData.sql)
   This sql database will create the table (ctag_data) and provide the user with a few useful queries.
   The database can be used to isolate specific samples and help the user decide which samples to analyze.
   Usage is provided in the howTo.txt file.
   
**Two reproducible bash shell scripts (1/2)**

3. [TrimGalore.sh](https://github.com/ibryant2/FastqAnalysis_Cut-Tag/blob/main/trimGalore.sh)
   This bash script will trim adapters from the FASTQ files after initial processing is complete.
   Users will need to define the samples within the script before execution.
   There is an example of how to do this in the comment.
   Currently, the example sample (esc_k27me3) is in the sample position, but it can be changed.
   You can add multiple samples for the script to dynamically loop through.

**Two reproducible bash shell scripts (2/2)**

4. [sequenceExtraction.sh](https://github.com/ibryant2/FastqAnalysis_Cut-Tag/blob/main/sequenceExtraction.sh)
   This bash script will extract the DNA Sequences from both forward and reverse strands of each sample.
   The DNA sequences from both forward and reverse strands will be combined into a single .txt file.
   If the user would like to only use one strand, they can remove the second input option from the script.
   Multiple samples can be input and looped dynamically.

**A Python script for data analysis**

5. [analysis.py](https://github.com/ibryant2/FastqAnalysis_Cut-Tag/blob/main/analysis.py)
   This python script will analyze a DNA Sequence (1 line from the .txt file) of the user's choice.
   The information will print to the screen unless directed otherwise (instructions in howTo.txt).


# Resources:
If your server does not have a tool that is used in the repository, you can create an individual conda environment to use that tool. Below is the link to conda environment that provides details of use.

https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html
