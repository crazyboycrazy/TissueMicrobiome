for i in $(cat outputfile |awk '$13>50 && $14 <5{print}'|awk '{print $1}')
	do echo $i
run_antismash all_msp/${i}.fa output/${i} --genefinding-tool prodigal
done
