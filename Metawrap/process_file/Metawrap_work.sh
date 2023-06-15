#merge fastq
cat */*_1.fastq > merged_1.fastq 
cat */*_2.fastq > merged_2.fastq 

# assembly
megahit -t 11 -1 merged_1.fastq -2 merged_2.fastq -o megahit_out

# binning
metawrap binning -a output_megahit/final.contigs.fa -o metawrap_out -t 9 -m 100 --metabat2 --maxbin2 --concoct */*fastq

# refinement
metawrap bin_refinement -o output_refinement -t 9 -m 80 -A concoct_bins/ -B maxbin2_bins/ -C metabat2_bins/

#calssify (GTDBTK)
metawrap  classify_bins -b refined.bin.dir -o metawrap_classify
gtdbtk classify_wf --genome_dir <my_genomes> --out_dir <output_dir>


#metawrap quant
metawrap quant_bins -b outut_metarwrap/output_refinement/metawrap_70_10_bins/ -a  output_megahit/final.contigs.fa -o quant_output   -t 9 *TCGA*/*fastq


