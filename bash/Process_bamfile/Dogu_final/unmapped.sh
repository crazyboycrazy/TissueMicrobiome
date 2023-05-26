echo "cd complete"
TCGA=$(ls|grep TCGA)

if [ ! -s flagstat.txt ]
then
echo "$i flagstat  processsing"
samtools  flagstat --threads 4 ${TCGA} > flagstat.txt &
else
echo "$i flagstat already done"
fi

if [ ! -s unmapped.sam ]
then
echo "$i samtool unmmaped processing"
samtools view --threads 8 -h -f 4 ${TCGA} > unmapped.sam
else
echo "$i unmapping already done"
fi

if [ ! -s unmapped.fastq ]
then
echo "$i samtools fastq processing"
samtools fastq --threads 8  unmapped.sam > unmapped.fastq
else
echo "$i samtools fastq already done"
fi

if [ ! -s singleton.fq ]
then
echo "$i repair.sh prossesing"
repair.sh -eoom -Xmx80g ignorebadquality  in=unmapped.fastq  out=forward.fq out2=reverse.fq outs=singleton.fq
else
echo "repair.sh already done"
fi

wait
echo "${i} complete"
