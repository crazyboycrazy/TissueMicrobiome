# parallel 패키지 로드
library(parallel)

# 클러스터 설정 (여기서는 8개의 코어를 사용)
cl <- makeCluster(13)

# FindMarkers 함수를 병렬로 실행하는 함수 정의
my_function <- function(i, l) {
    cluster.markers <- FindMarkers(colon_harmony, ident.1 = i, ident.2 = l, min.pct = 0.25, logfc.threshold = 0.25)
    if (sum((cluster.markers$p_val_adj < 0.01) & ((cluster.markers$avg_log2FC >= 1) | (cluster.markers$avg_log2FC <= -1))) < 10) {
      return(TRUE)
    } else {
      return(FALSE)
    }
  }




# 입력 인덱스 벡터 생성
input_vector <- combn(1:40, 2)
apply(input_vector, 2, sort)
input_vector <- unique(input_vector)
input_vector<-input_vector%>%as.data.frame()%>%as.list()
name_vector<-apply(input_vector%>%as.data.frame(),2,function(x){
  print(paste0(x[1],",",x[2]))
})
names(input_vector)<-name_vector




results <- mclapply( input_vector,  function(x){
  my_function(x[1],x[2])
  },mc.cores = 13
  )




stopCluster(cl)


