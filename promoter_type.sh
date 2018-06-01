# This script is called by Cell_wise_file_parser.sh
# it caluculates wheter the tag cluster is a broad peak, narrow peak or wide peak.

perl -ne '@a=split("\t",$_);chomp(@a);
        if($a[2]-$a[1] <= 25){
                if($a[10] <= 5){
                        if($a[5] >= $a[8] && $a[5] <= $a[9]){
                                print join("\t",@a)."\tNP\n"
                        }
                        else{
                                print join("\t",@a)."\tNP_bm\n"
                        }
                }
                else{
                        print join("\t",@a)."\tBP1\n"
                }
        }

        elsif($a[2]-$a[1] >= 43){
                if($a[10] <=5){
                        print join("\t",@a)."\tBP3\n"
                }
                elsif($a[10] <= 18){
                        print join("\t",@a)."\tBP5\n"
                }
                else{
                        if($a[10] <= 30){
                                print join("\t",@a)."\tWP1\n"
                        }
                        else{
                                print join("\t",@a)."\tWP2\n"
                        }
                }
        }
        else{
                if($a[10] <= 5){
                        print join("\t",@a)."\tBP2\n"
                }
                else{
                        print join("\t",@a)."\tBP4\n"
                }
        }' $1/tmp | sed 's/\t/\tdemo\tdemo\t/3' > $1/$1"_w_promoter_class.bed"
