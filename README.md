# CAGE-data-analysis

The head script to start the analysis is Cell_wise_file_parser.sh . All the other scripts are called from inside this script.

This script calculates several features of the tag clusters derived by CAGEr package in R and assigns those features to GENCODE TSSs. GENCODE TSSs are the first nucleotide of GENCODE defined transcripts. GENCODE defined transcripts falling in the neighborhood of 10 bp are merged together (by mergeBed script in BEDTools software suit.) and extended 10 bp at both sides. This merged and extended TSSs are saved in the file tmp_merged_d10_up10_down10 (in the directory)

All the input files and directories should be proper,y named and placed in order to the head and child scripts to function properly.
