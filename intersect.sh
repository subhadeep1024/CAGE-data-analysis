

intersectBed -a /home/sutripa/subhadeep/GENCODE_annotations/final/tmp_merged_d10_up10_down10 -b $1/$1"_w_promoter_class.bed" -wa -wb -s | awk '{print $4"\t"$2"\t"$3"\t"$15"\t"$20"\t"$6}' > $1/x1

mergeBed -i $1/x1 -s -nms -scores collapse > $1/$1"_promoter_class.bed"
