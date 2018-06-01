


for Cell in "$@"

do

cut -f2- $Cell/TC_Cell_$Cell."bed" |sed 's/"//g' | sed '1d'>  $Cell/tmp
awk '{print $1"\t"$2"\t"$3"\t.\t"$7"\t"$4}' $Cell/tmp > $Cell/tmp1


echo "$Cell";
#calling promoter_featurre_calculator.sh
./promoter_feature_calculator.sh $Cell
./promoter_type.sh $Cell
./intersect.sh $Cell

intersectBed -a /home/sutripa/subhadeep/GENCODE_annotations/final/tmp_merged_d10_up10_down10 -b $Cell/tmp1 -wa -wb -s | awk '{print $4"\t"$2"\t"$3"\t.\t"$11"\t"$6}' > $Cell/tmp2
mergeBed -i $Cell/tmp2 -nms -s -scores mean > $Cell/$Cell"_trans_CAGE"



