# This is a in house script written for the purpose of data filtering and formatting. It uses the file "tmp_merged_d10_up10_down10 " often,
# and the input files should be their places in order to this script to properly run.

# This script calculates promoter features from CAGE tag cluster files (.bed).

# Inputs: directory names according to the name of cell lines. the directories shoulb be in the same folder as the script.
# All input folders should contain files with the prefix "TC_Cell" followed by the name of the cell lines, separated by "_"
# e.g. TC_Cell_Gm12878, These files will be the input files.






for Cell in "$@"

do

# removing spaces and deleting the first line of the input files
cut -f2- $Cell/TC_Cell_$Cell."bed" |sed 's/"//g' | sed '1d'>  $Cell/tmp

# selecting specific columns and saving to bed format
awk '{print $1"\t"$2"\t"$3"\t.\t"$7"\t"$4}' $Cell/tmp > $Cell/tmp1


echo "$Cell";

#####################################calling shell scripts for various analysis#####################################################

# it calculates the length of tag clusters, and checks whether the "nr_ctss" (col 5) falls inside 
#the 1st (col 8) and third quartile (col 9)of the TSS distribution 
./promoter_feature_calculator.sh $Cell

# it caluculates wheter the tag cluster is a broad peak, narrow peak or wide peak.
./promoter_type.sh $Cell

# it takes the output of "promoter_type.sh" as input and overlaps it with GENCODE annotated TSSs (modified and saved in "tmp_merged_d10_up10_down10")
./intersect.sh $Cell
####################################################################################################################################

# overlapping GENCODE TSSs with Tagclusters
intersectBed -a /home/sutripa/subhadeep/GENCODE_annotations/final/tmp_merged_d10_up10_down10 -b $Cell/tmp1 -wa -wb -s | awk '{print $4"\t"$2"\t"$3"\t.\t"$11"\t"$6}' > $Cell/tmp2

# merging all the promoter type of a tag cluster together.
mergeBed -i $Cell/tmp2 -nms -s -scores mean > $Cell/$Cell"_trans_CAGE"

done

