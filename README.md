# FastqAnalysis Cut&Tag
# A project to analyze Cut&Tag data from SRA or FASTQ files
This repository will help users to extract important aspects from a DNA Sequence. There will be instructions from the initial steps of retrieving SRA files down to a snapshot of the usable data from the provided sequence. There will be a database with example datasets to be used in the pipeline. The provided datasets will be Cut&Tag data on human cells. 

You can access the associated paper at https://pmc.ncbi.nlm.nih.gov/articles/PMC6488672/ and the data in the study can be accessed via NCBI GEO https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE124557 (GSE124557). The database will provide users with the characteristics of each sample, an SRA accession number, and links to retrieve FASTQ files via wget.

# Abstract
   Cut&Tag is an epigenomic profiling assay that uses antibodies and the transposase Tn5 to target specific genomic regions, cleave, and tag them for downstream sequencing to characterize protein-chromatin interactions. This repository serves as a fundamental guide to efficiently process and analyze a snapshot of Cut&Tag data. The pipeline workflow removes adapters from DNA sequences via TrimGalore, extracts and merges sequences from trimmed paired-end FASTQ files and provides analysis from a user-selected sequence. The question answered by this project is “what the length is, GC content, transcript and translation for a selected DNA sequence obtained from Cut&Tag data?” The goal of this project is to output both the filename and file position of the input, DNA sequence, DNA sequence length, GC content (%), RNA transcript sequence, and protein translation sequence in one- or three-letter amino acid codes. The objective is to provide speedy Cut&Tag data analysis. This pipeline is novel in offering a quick and accessible method for preliminary analysis of a specific region of Cut&Tag data. This project is valuable to genomic profiling, because it provides a quick snapshot of data analysis and allows for faster interpretation. Detailed instructions on how to use the pipeline are provided in [howTo.txt](https://github.com/ibryant2/FastqAnalysis_Cut-Tag/blob/main/howTo.txt).


# Background
   Cut&Tag is a sequencing assay used to study protein-chromatin interactions, map chromatin structure, and characterize complex epigenomic relationships. Cut&Tag is rapidly gaining popularity due to its high sensitivity, timeliness, and cost-efficiency [(2)](https://www.nature.com/articles/s41596-020-0373-x). It is best suited for post-translational modifications (PTMs), such as histone modifications, due to minimized background signals, reduced artificial enrichment of expression, and low cellular input requirements [(3)](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-022-02707-w). Profiling of PTMs ais critical to understand the epigenetic changes in samples and provide specific gene expression information. These changes in expression can be linked to many traits, diseases, etc.
   
   While Cut&Tag is the leading method for profiling PTMs, it is less compatible with certain protein-chromatin interaction analyses, particularly those with low abundance [(4)](https://www.epicypher.com/resources/blog/cut-and-run-vs-cut-and-tag-which-one-is-right-for-you/). High salt washes in the method can disrupt protein interactions and may strip away loosely or transiently bound proteins, complicating preliminary library quality assessment. Although not the most optimal under these conditions, studies demonstrate that high mapping NGS signals persist [(5)](https://www.cellsignal.com/learn-and-support/frequently-asked-questions/cut-and-tag-faqs). Selecting the appropriate sequencing protocol depends on experimental samples and analytical goals; however, many resources are publicly available to guide the decision-making process [(4)](https://www.epicypher.com/resources/blog/cut-and-run-vs-cut-and-tag-which-one-is-right-for-you/).
   
   The advantages and limitations of Cut&Tag are tied to the methods it employs. Cells or isolated nuclei are first washed and bound to Concanavalin A Beads. Once samples are bead-bound, they are treated with a primary antibody followed by treatment with a secondary antibody. The antibody-treated samples then undergo a series of washes with digitonin-based buffers, which allow for sample permeabilization. Tn5 uses the antibody targets as a guide to bind the sample. A tagmentation buffer is subsequently used to activate Tn5 through specific ionic and thermal conditions. Finally, Tn5 cleaves the targeted region, and the DNA is purified for analysis. Below, there is an illustration of these methods [(6)](https://www.cellsignal.com/applications/cut-tag-overview).
   

![image](https://github.com/user-attachments/assets/5a77511e-a423-4280-ad3a-fc54b46147fb)

**Photo Credit:** Cell Signaling Technology. CUT&Tag Overview: Profile Chromatin Faster [Internet]. Cell Signaling Technology. 2025 [cited 2025 May 10]. Available from: https://www.cellsignal.com/applications/cut-tag-overview

   After the completion of Cut&Tag, PCR is used to bind adapters and amplify the tagmented regions. These adapters are short oligonucleotides that enable sample recognition by sequencing instruments. Once PCR is complete, library quality is preliminarily assessed, and sequencing is typically performed by a third-party service. Post-sequencing, samples require downstream analysis to interpret the data. This repository serves as a practical guide to quickly analyze specific DNA regions from Cut&Tag data. A step-by-step guide (howTo.txt) is included to walk users through setup and execution of the pipeline. Please read the guide in its entirety before use.
   
   The initial steps in this pipeline include setting up the MySQL database and extracting the information for sample retrieval. There are two tools available for retrieving data: Prefetch and Wget. Prefetch uses a unique accession number associated with a sample to download the Sequence Read Archive (SRA) file. SRA files are raw binary files that include sequencing reads along with per-base quality scores [(7)](https://www.ncbi.nlm.nih.gov/sra/docs/submitformats/). The fasterq-dump tool is then used to convert the SRA file into two separate FASTQ files: one containing the forward strand (5′→3′) and the other the reverse strand (3′→5′) sequences with their respective quality scores. Wget works differently in that it allows users to download sequencing data directly from a URL. The URL provided in the MySQL table is to the FASTQ file itself, so there is no need to transform or split the data after retrieval.
   
   Once all data for the desired sample has been downloaded, a bash script trims adapters from the FASTQ files. This script employs the TrimGalore tool to identify adapters. After trimming, the file undergoes a validation process and is saved with "val" incorporated into the trimmed file name. The Cutadapt tool is used within TrimGalore to remove the adapters from the sequences [(8)](https://github.com/FelixKrueger/TrimGalore/issues/60). The input and output file names for these tools are defined by the user through script editing. In addition to trimmed and validated files, TrimGalore generates a trimming report that provides specific details about the process. The line-by-line format of the trimmed output includes a header with sequence length information, the DNA sequence (nucleotides), a separator, and the quality score for each base. Another bash script, using the Awk tool, enables users to extract the DNA sequences and merge both forward and reverse files.
   
   Finally, Python is used for the final analysis of the desired sequences. The provided Python script utilizes the sys.argv tool to facilitate command-line and program interaction. The user can specify the Python tool, script, DNA sequence file, the desired amino acid sequence code (one- or three-letter), and the line for analysis. The script includes several parameters to ensure that the input is in the correct format and returns an error code if it is not. Once the input is validated, the script opens the input file and uses the readline() function to read the selected line. Basic Python assignment and print functions are used for most of the analysis, while Python dictionaries are employed for sequence translation. The final output includes the filename and file position of the input, the DNA sequence, DNA sequence length, GC content (%), RNA transcript sequence, and protein translation sequence in either one- or three-letter amino acid codes.

# Workflow
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

# Users:
- Laboratory/genomics staff (technicians, lab managers, etc)
- Graduate students who want to analyze the signal of a certain target in translated proteins after treatments
- Faculty and principal investigators (PIs) who want a quick glance at their results
- Anyone who is interested in cut and tag or bioinformatics analysis

 The pipeline can also be used to compare different sequencing methods.

# Implementation Constraints
- Only optimal for smaller datasets
- Difficult to determine which sequences to analyze
- Requires at least 1 GB of space (depending on data size)
- Does not provide full analysis, only snapshot
- No visualization provided, only analysis


# Privacy
Publicly accesible data:
https://pmc.ncbi.nlm.nih.gov/articles/PMC6488672/
https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE124557 (GSE124557)

# Resources:
If your server does not have a tool that is used in the repository, you can create an individual conda environment to use that tool. Below is the link to conda environment that provides details of use.

https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html

# Vancouver-Style Bibliography
1.	Kaya-Okur HS, Wu SJ, Codomo CA, Pledger ES, Bryson TD, Henikoff JG, et al. CUT&Tag for efficient epigenomic profiling of small samples and single cells. Nature Communications. 2019 Apr 29;10(1). Available from: https://pmc.ncbi.nlm.nih.gov/articles/PMC6488672/
2.	Kaya-Okur HS, Janssens DH, Henikoff JG, Ahmad K, Henikoff S. Efficient low-cost chromatin profiling with CUT&Tag. Nature Protocols. 2020 Sep 10;15(10):3264–83. Available from: https://www.nature.com/articles/s41596-020-0373-x
3.	Yashar WM, Kong G, VanCampen J, Curtiss BM, Coleman DJ, Carbone L, et al. GoPeaks: histone modification peak calling for CUT&Tag. Genome biology. 2022 Jul 4;23(1). Available from: https://genomebiology.biomedcentral.com/articles/10.1186/s13059-022-02707-w
4.	Epicypher. CUT&RUN vs. CUT&Tag : Which One is Right for You? [Internet]. EpiCypher. 2024. Available from: https://www.epicypher.com/resources/blog/cut-and-run-vs-cut-and-tag-which-one-is-right-for-you/
5.	Cell Signaling Technology. CUT&Tag Frequently Asked Questions [Internet]. Cell Signaling Technology. 2025 [cited 2025 May 10]. Available from: https://www.cellsignal.com/learn-and-support/frequently-asked-questions/cut-and-tag-faqs
6.	Cell Signaling Technology. CUT&Tag Overview: Profile Chromatin Faster [Internet]. Cell Signaling Technology. 2025 [cited 2025 May 10]. Available from: https://www.cellsignal.com/applications/cut-tag-overview
7.	NCBI. File Format Guide [Internet]. www.ncbi.nlm.nih.gov. Available from: https://www.ncbi.nlm.nih.gov/sra/docs/submitformats/
8.	FelixKrueger. What do these output files mean? · Issue #60 · FelixKrueger/TrimGalore [Internet]. GitHub. 2021 [cited 2025 May 10]. Available from: https://github.com/FelixKrueger/TrimGalore/issues/60
