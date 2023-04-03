#cellranger 
for i in $(ls|grep KUL|grep  KUL30_N|grep -v pisin)
#for i in $(ls|grep KUL19_N)
do
cd $i
sample_name=$(ls|grep scr|grep gz|cut -d "_" -f 1-2|sort|uniq)
cd ../
~/cellranger-7.0.1/cellranger count --id=${sample_name}_cellranger --sample=${sample_name} --fastqs=${i}  --transcriptome=/home/junwoojo/refdata-gex-GRCh38-2020-A/ --localcores=10
done







#process cellranger_output
for i in $(ls|grep KUL30_N|grep cellranger)
do cd ${i}/outs
samtools view -h -f 4 possorted_genome_bam.bam > human.unmapped.sam
samtools fastq -T CB,UB human.unmapped.sam > unmapped.fastq
bowtie2 -x ~/Project_Darkmatter/Reference/gene_catalogue/fasta/gene_catalogue_dnaspace_index -p 10 --sam-append-comment  -U  unmapped.fastq -S unmapped.sam
cd ../../
done
