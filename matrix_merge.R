library(data.table)
library(dplyr)


rowname_vector<-c()
for (i in 1:6){
  assign(paste0('s',i),read.table(paste0("/home/junwoojo/sample",i,"_matrix"),header = T))
  zzz<-get(paste0('s',i))
  colnames(zzz)<-gsub("\\.","-",colnames(get(paste0('s',i))))
  colnames(zzz)<-paste0("sample",i,"_",colnames(zzz))
  rowname_vector<-append(rowname_vector,zzz%>%colnames())
  assign(paste0('s',i),zzz)
  assign(paste0("s",i,"_t"),t(zzz)%>%as.data.frame())
}
singlecell_microbiome_matrix_sample<-rbindlist(lapply(paste0("s",1:6,"_t"),get),fill = T)%>%as.data.frame()
rownames(singlecell_microbiome_matrix_sample)<-rowname_vector

#######################KUL####################################################################
rowname_vector<-c()

for (i in c("01","19","21","30","28")){
  for (l in c("N","B","T")){
  assign(paste0('K',i,l),read.table(paste0("/home/junwoojo/KUL",i,"_",l,"_matrix"),header = T))
  zzz<-get(paste0('K',i,l))
  colnames(zzz)<-gsub("\\.","-",colnames(get(paste0('K',i,l))))
  colnames(zzz)<-paste0("KUL",i,"_",l,"_",colnames(zzz))
  rowname_vector<-append(rowname_vector,zzz%>%colnames())
  assign(paste0('K',i,l),zzz)
  assign(paste0('K',i,l,"_t"),t(zzz)%>%as.data.frame())
}
}
vector_KUL_file=c()
for (i in c("01","19","21","30","28")){
  for (l in c("N","B","T")){
    vector_KUL_file<-append(vector_KUL_file,paste0("K",i,l))
}
}
vector_KUL_file

singlecell_microbiome_matrix_KUL<-rbindlist(lapply(paste0(vector_KUL_file,"_t"),get),fill = T)%>%as.data.frame()
rownames(singlecell_microbiome_matrix_KUL)<-rowname_vector
#########################################################
singlecell_microbiome_matrix<-rbindlist(list(singlecell_microbiome_matrix_sample,singlecell_microbiome_matrix_KUL),fill = T)%>%as.data.frame()
r1<-singlecell_microbiome_matrix_sample%>%rownames()
r2<-singlecell_microbiome_matrix_KUL%>%rownames()

rownames(singlecell_microbiome_matrix)<-c(r1,r2)
singlecell_microbiome_matrix%>%dim()
