# This script is called by Cell_wise_file_parser.sh

#it calculates the length of tag clusters, and checks whether the "nr_ctss" (col 5) falls inside 
#the 1st (col 8) and third quartile (col 9)of the TSS distribution 


perl -ne '
        @a=split("\t",$_);chomp(@a);{
                $promoter_len = $a[2]-$a[1];
                $fifty_percent_len = $a[10];
                if($a[5] >= $a[8] && $a[5] <= $a[9]){
                        $position = 1;
                }
                else{
                        $position =2;
                }
                print "$a[0]\t$a[1]\t$a[2]\t$promoter_len\t$fifty_percent_len\t$position\n"

        }' $1/tmp > $1/$1"_promoter_feature.txt"
