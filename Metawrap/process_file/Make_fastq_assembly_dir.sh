for i in $(ls|grep TCGA)
do mkdir bonelgu/${i}
mv  ${i}/f_last.fq bonelgu/${i}/
mv  ${i}/r_last.fq bonelgu/${i}/
mv  ${i}/megahit_out bonelgu/${i}/
done
