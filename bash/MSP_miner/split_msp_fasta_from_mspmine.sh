if [ $# -lt 2 ];then
echo -e "gene_catalogue msp_miner.out needed \n EXIT"
exit
fi
#############################################################
gene_catalogue=$1
msp_miner_out=$2
#############################################################
msp_array=()
associate_msp_array=()
for i in $(cat ${msp_miner_out}|grep -v name|cut -f 1)
do
msp_array+=(${i})
done
final=($(echo ${msp_array[@]}|tr ' ' '\n'|sort|uniq))

for i in  ${final[@]}
do 
cat ${msp_miner_out}|grep ${i}|cut -f 4 > ${i}_GENESET
done

mkdir msp_fasta.dir

for i in ${final[@]}
do seqkit grep -f ${i}_GENESET ${gene_catalogue} > msp_fasta.dir/${i}.fa
done
rm *GENESET
