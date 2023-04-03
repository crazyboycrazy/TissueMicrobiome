list_gene=[]
my_dict=collections.defaultdict(list)
n=1
with open("/home/junwoojo/singlecell/KUL30_B_cellranger/outs/unmapped.sam") as file:
    for line in file:
        if line.startswith('@SQ'):
#            list_gene.append(line.split("\t")[1])
            continue
        try:
            if (not line.startswith("@")) and (line.split("\t")[2]!='*'):
                gene=line.split("\t")[2]
                cell_barcode=line.split("CB:Z:")[1].split('UB:Z')[0].strip()
                umi_barcode=line.split("UB:Z:")[1].strip()
                my_dict[gene]+=[[cell_barcode,umi_barcode]]
                list_gene.append(gene.strip())

        except:
            pass

            
#print(len(list_gene))
list_gene=np.unique(list_gene)
list_barcode=[]
barcode_dict={}
gene_dict={}
with gzip.open("/home/junwoojo/singlecell/KUL30_B_cellranger/outs/filtered_feature_bc_matrix/barcodes.tsv.gz") as file:
    for line in file:
        list_barcode.append(line.strip().decode("utf-8"))
n=0
for i in list_barcode:
    barcode_dict[i]=n
    n+=1
    
n=0
for i in list_gene:
    gene_dict[i]=n
    n+=1
    
matrix=np.zeros([len(list_gene),len(list_barcode)],"int")


def from_samcount_to_matrix(input_gene_name):
    aaa=collections.defaultdict(list)
    gene_name=input_gene_name
    for i in my_dict[input_gene_name]:
        aaa[i[0]]+=[i[1]]
    for i,l in aaa.items():
        if i not in barcode_dict.keys():
            continue
        matrix[gene_dict[gene_name],barcode_dict[i]]+=len(np.unique(l))
for i in my_dict.keys():
    from_samcount_to_matrix(i)

    
import pandas as pd
zxc=pd.DataFrame(matrix,columns=list_barcode,index=list_gene)
zxc.to_csv('/home/junwoojo/KUL30_B_matrix',header=True,index=True,sep="\t")
