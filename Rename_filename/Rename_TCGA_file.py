import pandas as pd
import os
list_a=[]
list_b=[]
df = pd.read_json('./metadata.cart.2023-05-26.json')
filename=df['file_name']
for i in range(df.shape[0]):
    list_a.append(df['associated_entities'][i][0]['entity_submitter_id'])
    list_b.append(df['file_name'][i])
aaa=pd.DataFrame({'filename':list_a,'submitter':list_b})
aaa.to_csv("./metadata",index=False,header=None,sep="\t")



dict_a={}


list_file=os.listdir()
with open('metadata') as file:
    for line in file:
        submitter=line.split("\t")[0].strip()
        filename=line.split("\t")[1].strip()
        dict_a[filename]=submitter

        
for i in list_file:
    if i in dict_a:
        os.rename(i,f'{dict_a[i]}.bam')
