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
# Sources: https://www.geeksforgeeks.org/dna-protein-python-3/
# https://www.biostars.org/p/165478/ (used to get the codons written
# out in python format to avoid mistakes)

#!/usr/bin/python3.7

# Import sys
import sys

# Usage: python finalProject.py <filename> <1|3> <line_number>
# The first integer allows the user to choose between
# a single-letter or three-letter amino acid (AA) sequence.
# The second integer allows the user to choose a line for analysis.

# Ensure the correct number of arguments is provided.
if len(sys.argv) < 4:
    print("Usage: python finalProject.py <DNAsequence_filename>"
          "<1|3> <line_number>")
    sys.exit(1)

# Assign filename.
filename = sys.argv[1]

# Validate mode (1 or 3).
try:
    mode = int(sys.argv[2])
except ValueError:
    print("Error: Second argument must be an integer (1 or 3).")
    sys.exit(1)

if mode not in [1, 3]:
    print("Error: Invalid option."
          "Please provide 1 or 3 as the second argument.")
    sys.exit(1)

# Count the number of lines (sequences) in the file.
try:
    with open(filename, 'r') as file:
        lines = file.readlines()
        line_count = len(lines)
except FileNotFoundError:
    print(f"Error: File '{filename}' not found.")
    sys.exit(1)

# Validate line number input.
try:
    seq_line = int(sys.argv[3])
except ValueError:
    print(f"Error: Third argument must be an integer <= {line_count}.")
    sys.exit(1)

# Ensure the line number is within range.
if not (1 <= seq_line <= line_count):
    print(f"Error: Invalid line number. Must be between 1 and {line_count}.")
    sys.exit(1)

# Begin reading the desired line of the input file.
sequence = ""

with open(filename, "r") as file:
    lines = file.readlines()
    sequence = lines[seq_line - 1].strip().upper()

# Transcribe the DNA sequence from the input file to RNA.
rna_sequence = sequence.replace("T", "U")

# Determine and define the DNA sequence length.
dna_length = len(sequence)

# Use the DNA sequence to calculate the GC content.
GC = ((sequence.count("G") + sequence.count("C")) /
      (sequence.count("G") + sequence.count("C") +
       sequence.count("A") + sequence.count("T"))) * 100

# Round the GC content by 2 decimal points.
GC_rounded = round(GC, 2)


# Define 3 character codons from the RNA sequence
# for translation to single letter amino acids (AAs).
codon1 = {
    'AUA': 'I', 'AUC': 'I', 'AUU': 'I', 'AUG': 'M',
    'ACA': 'T', 'ACC': 'T', 'ACG': 'T', 'ACU': 'T',
    'AAC': 'N', 'AAU': 'N', 'AAA': 'K', 'AAG': 'K',
    'AGC': 'S', 'AGU': 'S', 'AGA': 'R', 'AGG': 'R',
    'CUA': 'L', 'CUC': 'L', 'CUG': 'L', 'CUU': 'L',
    'CCA': 'P', 'CCC': 'P', 'CCG': 'P', 'CCU': 'P',
    'CAC': 'H', 'CAU': 'H', 'CAA': 'Q', 'CAG': 'Q',
    'CGA': 'R', 'CGC': 'R', 'CGG': 'R', 'CGU': 'R',
    'GUA': 'V', 'GUC': 'V', 'GUG': 'V', 'GUU': 'V',
    'GCA': 'A', 'GCC': 'A', 'GCG': 'A', 'GCU': 'A',
    'GAC': 'D', 'GAU': 'D', 'GAA': 'E', 'GAG': 'E',
    'GGA': 'G', 'GGC': 'G', 'GGG': 'G', 'GGU': 'G',
    'UCA': 'S', 'UCC': 'S', 'UCG': 'S', 'UCU': 'S',
    'UUC': 'F', 'UUU': 'F', 'UUA': 'L', 'UUG': 'L',
    'UAC': 'Y', 'UAU': 'Y', 'UAA': '*', 'UAG': '*',
    'UGC': 'C', 'UGU': 'C', 'UGA': '*', 'UGG': 'W'
}

# Define 3 character codons from the rna sequence
# for translation to three letter amino acids.
codon3 = {
    'UUU': 'Phe', 'UUC': 'Phe', 'UUA': 'Leu', 'UUG': 'Leu',
    'CUU': 'Leu', 'CUC': 'Leu', 'CUA': 'Leu', 'CUG': 'Leu',
    'AUU': 'Ile', 'AUC': 'Ile', 'AUA': 'Ile', 'AUG': 'Met',
    'GUU': 'Val', 'GUC': 'Val', 'GUA': 'Val', 'GUG': 'Val',
    'UCU': 'Ser', 'UCC': 'Ser', 'UCA': 'Ser', 'UCG': 'Ser',
    'CCU': 'Pro', 'CCC': 'Pro', 'CCA': 'Pro', 'CCG': 'Pro',
    'ACU': 'Thr', 'ACC': 'Thr', 'ACA': 'Thr', 'ACG': 'Thr',
    'GCU': 'Ala', 'GCC': 'Ala', 'GCA': 'Ala', 'GCG': 'Ala',
    'UAU': 'Tyr', 'UAC': 'Tyr', 'UAA': '***', 'UAG': '***',
    'CAU': 'His', 'CAC': 'His', 'CAA': 'Gln', 'CAG': 'Gln',
    'AAU': 'Asn', 'AAC': 'Asn', 'AAA': 'Lys', 'AAG': 'Lys',
    'GAU': 'Asp', 'GAC': 'Asp', 'GAA': 'Glu', 'GAG': 'Glu',
    'UGU': 'Cys', 'UGC': 'Cys', 'UGA': '***', 'UGG': 'Trp',
    'CGU': 'Arg', 'CGC': 'Arg', 'CGA': 'Arg', 'CGG': 'Arg',
    'AGU': 'Ser', 'AGC': 'Ser', 'AGA': 'Arg', 'AGG': 'Arg',
    'GGU': 'Gly', 'GGC': 'Gly', 'GGA': 'Gly', 'GGG': 'Gly'
}

# Compile amino acids from the translation to build a protein.
# The format of amino acids is based on if the user choose 1 or 3 letter AAs.
protein = []
for i in range(0, len(rna_sequence) - 2, 3):
    codon = rna_sequence[i:i + 3]
    if len(codon) != 3:
        continue
    if mode == 1:
        AA = codon1.get(codon, '')
        protein.append(AA)
    elif mode == 3:
        AA = codon3.get(codon, '')
        protein.append(AA)

# Print the DNA analysis features.
# Print the DNA analysis features.
print(f"\nFile: {filename} \nLine: {seq_line}")
print("\nAnalysis: \nDNA Sequence (input): " + sequence +
      "\nDNA Sequence Length (nt): " + str(dna_length) +
      "\nGC Content: " + str(GC_rounded) +
      "\nRNA Sequence: " + rna_sequence)

# Print the protein in proper length with a dash (-) between each AA.
if mode == 1:
    print("\n1-letter Protein Translation:")
    protein_str = '-'.join(protein)
    print(protein_str + "\n\n")

elif mode == 3:
    print("\n3-letter Protein Translation:")
    protein_str = '-'.join(protein)
    print(protein_str + "\n\n")
