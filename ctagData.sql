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

# Create the ctag_data table with parameters for each component. This table
# will contain humen Cut&Tag data for two different cell types of and three
# different targets. You can can compare the data between these samples by
# cell types and/or targets.

# The varchar is for variable characters and will allow both numbers
# and letters within the set length. For limits I set a larger range
# than I expect the values to be just in case.

# The accession number will be the unique identifier with a 20 character
# limit and will be the primary key to ID samples. This number can be used
# with SRA prefetch tool as mentioned in the howTo.txt file.

# The recommended name will be in text format. You can change this
# to just name and provide your own unique names for samples.

# The target will have a 50 character limit. The samples provided uses
# histone modifications (K27me3 and K4me1), pol2-ser2/ser5, and IgG.
# The data obtained from these targets can provide lots of information
# on genetic expression and general genetic activity.

# The cell_type will have a 200 character limit.

# The fastq links will be entered as text. These links can be used to
# retrieve data via wget. The data provided is paired end, so there are
# adapters on both the 3' and 5' end of samples. You will need to retrieve
# each fragment. fastq_1 is the forward strand and fastq_2 is the reverse.

CREATE TABLE ctag_data (
    accession_number VARCHAR(20) PRIMARY KEY,
    recommended_name TEXT,
    target VARCHAR(50),
    cell_type VARCHAR(200),
    fastq_1 TEXT,
    fastq_2 TEXT
);

# The data from the GSE124557 study for the previously mentioned
# antibodies (targets) will be entered into the table.
INSERT INTO ctag_data (
    accession_number, recommended_name, target, cell_type, fastq_1, fastq_2
) VALUES
("SRR8383482", "esc_k27me3", "K27me3", "Embryonic Stem Cells",
    CONCAT("ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR838/002/SRR8383482/",
        "SRR8383482_1.fastq.gz"),
    CONCAT("ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR838/002/SRR8383482/",
        "SRR8383482_2.fastq.gz")),
("SRR8383484", "esc_k4me1", "K4me1", "Embryonic Stem Cells",
    CONCAT("ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR838/004/SRR8383484/",
        "SRR8383484_1.fastq.gz"),
    CONCAT("ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR838/004/SRR8383484/",
        "SRR8383484_2.fastq.gz")),
("SRR8383490", "esc_pol2", "Pol2-Ser2/Ser5", "Embryonic Stem Cells",
    CONCAT("ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR838/000/SRR8383490/",
        "SRR8383490_1.fastq.gz"),
    CONCAT("ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR838/000/SRR8383490/",
        "SRR8383490_2.fastq.gz")),
("SRR8383500", "iml_k27me3", "K27me3", "Immortalized Mylogenous Leukemia",
    CONCAT("ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR838/000/SRR8383500/",
        "SRR8383500_1.fastq.gz"),
    CONCAT("ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR838/000/SRR8383500/",
        "SRR8383500_2.fastq.gz")),
("SRR8383512", "iml_k4me1", "K4me1", "Immortalized Mylogenous Leukemia",
    CONCAT("ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR838/002/SRR8383512/",
        "SRR8383512_1.fastq.gz"),
    CONCAT("ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR838/002/SRR8383512/",
        "SRR8383512_2.fastq.gz")),
("SRR8383520", "iml_pol2", "Pol2-Ser2/Ser5",
    "Immortalized Mylogenous Leukemia",
    CONCAT("ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR838/000/",
        "SRR8383520/SRR8383520_1.fastq.gz"),
    CONCAT("ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR838/000/",
        "SRR8383520/SRR8383520_2.fastq.gz")),
("SRR8435037", "esc_igg", "IgG", "Embryonic Stem Cells",
    CONCAT("ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR843/007/SRR8435037/",
        "SRR8435037_1.fastq.gz"),
    CONCAT("ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR843/007/SRR8435037/",
        "SRR8435037_2.fastq.gz")),
("SRR8435051", "iml_igg", "IgG", "Immortalized Mylogenous Leukemia",
    CONCAT("ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR843/001/SRR8435051/",
        "SRR8435051_1.fastq.gz"),
    CONCAT("ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR843/001/SRR8435051/",
        "SRR8435051_2.fastq.gz"));

# Here are a few queries you could try to retrieve specifc datasets to
# analyze and compare.

# Query 1: Retrieve all data.
SELECT * FROM ctag_data;

# Query 2: Retrieve data for a specific target.
SELECT * FROM ctag_data WHERE target = 'K27me3';

# Query 3: Retrieve data for a specific cell type.
SELECT * FROM ctag_data WHERE cell_type = 'Immortalized Mylogenous Leukemia';

# Query 4: Count the number of samples for each target.
SELECT target, COUNT(*) AS sample_count FROM ctag_data GROUP BY target;

# Query 5: Retrieve all samples that have the listed histone markers.
SELECT * FROM ctag_data WHERE target LIKE '%k%';

# Query 6: Retrieve all samples that can be used as a control to measure
# nonspecific binding of the antibodies. IgG is the control target to
# determine this.
SELECT * FROM ctag_data WHERE target = 'IgG';

# Query 7: Retrieve all samples that are Embryonic Stem Cells AND
# have the K27me3 histone modification.
# I will perform the example with this sample.
SELECT * FROM ctag_data
WHERE cell_type = 'Embryonic Stem Cells' AND target = 'K27me3';
