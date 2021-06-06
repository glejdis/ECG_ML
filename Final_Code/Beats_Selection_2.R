#' Random Beats Selection
#' 
#' Function to read all the files storing the heartbeats and randomly select
#' a specific number of heartbeats from each class, in this way also splitting the data
#' into training data and testing data
#' 
#' @param file_dir the directory where all the files containing heartbeats are located
#' @return list(train_beats, test_beats)
#' 
set.seed(123)
#' Read all the files containing the heart beats and store the data from
#' not annotated files into one variable and the data from the
#' annotated files into another variable named my_data_a. 
#' 

read_train_test=function(file_dir){
  files=dir(file_dir,pattern="([[:digit:]]+).csv")
  dataString=substr(files[1],0,3)
  anot=read.csv(paste0(file_dir,dataString,"a.csv"),header=F,na.strings="?")
  anot[3]=dataString
  summary(anot)
  my_data_a=anot
  for(file in 2:length(files)){
    dataString=substr(files[file],0,3)
    print(dataString)
    anot=read.csv(paste0(file_dir,dataString,"a.csv"),header=F,na.strings="?")
    anot[3]=dataString
    anot=anot[1:(nrow(anot)-2),]
    my_data_a=rbind(my_data_a,anot)
    print(dim(my_data_a))
  } 
  
  
  #' Spliting the dataset into the test and train dataset
  #' 
  #' Normal beats: we select 2000 beats from which 1000 will be in the 
  #' training set and 1000 in the testing data set. 
  #' 
  normal_beats = my_data_a[my_data_a[,2]=='N',]
  random_train_test = normal_beats[sample(nrow(normal_beats), 1000*2),]
  train=sample(nrow(random_train_test), 1000)
  random_train_test['TRAIN']=0
  random_train_test[train,'TRAIN']=1
  #' 
  #' The train data set for the Normal beats
  #' Size: 1000 Normal beats
  #' 
  random_N = random_train_test[random_train_test['TRAIN']==1,]
  random_N_df = data.frame("ID"=random_N[,1],'FILE'=random_N[,3],"annot"=random_N[,2])
  #' 
  #' The test data set for the Normal beats 
  #' Size: 1000 Normal beats
  #' 
  test_N=random_train_test[random_train_test['TRAIN']==0,]
  test_N_df = data.frame("ID"=test_N[,1],'FILE'=test_N[,3],"annot"=test_N[,2])
  
  #' 
  #' RBBB beats: we select 400 beats form which 200 will be in the
  #' training data set and 200 in the testing data set
  #' 
  RBBB_beats = my_data_a[my_data_a[,2]=='R',]
  random_train_test = RBBB_beats[sample(nrow(RBBB_beats), 200*2),]
  train=sample(nrow(random_train_test), 200)
  random_train_test['TRAIN']=0
  random_train_test[train,'TRAIN']=1
  #' 
  #' The train data set for RBBB beats
  #' Size: 200 RBBB beats
  #' 
  random_RBBB = random_train_test[random_train_test['TRAIN']==1,]
  random_RBBB_df = data.frame("ID"=random_RBBB[,1],'FILE'=random_RBBB[,3],"annot"=random_RBBB[,2])
  #' 
  #' The test data set for RBBB beats
  #' Size: 200 RBBB beats
  #' 
  test_RBBB=random_train_test[random_train_test['TRAIN']==0,]
  test_RBBB_df = data.frame("ID"=test_RBBB[,1],'FILE'=test_RBBB[,3],"annot"=test_RBBB[,2])
  
  
  #' 
  #' APC beats: we select 200 beats form which 100 will be in the
  #' training data set and 100 in the testing data set
  #' 
  APC_beats = my_data_a[my_data_a[,2]=='A',]
  random_train_test = APC_beats[sample(nrow(APC_beats), 100*2),]
  train=sample(nrow(random_train_test), 100)
  random_train_test['TRAIN']=0
  random_train_test[train,'TRAIN']=1
  #' 
  #' The train data set for APC beats
  #' Size: 100 APC beats
  #' 
  random_APC = random_train_test[random_train_test['TRAIN']==1,]
  random_APC_df = data.frame("ID"=random_APC[,1],'FILE'=random_APC[,3],"annot"=random_APC[,2])
  #' 
  #' The Test data set for APC beats
  #' Size: 100 APC beats
  #'
  test_APC=random_train_test[random_train_test['TRAIN']==0,]
  test_APC_df = data.frame("ID"=test_APC[,1],'FILE'=test_APC[,3],"annot"=test_APC[,2])
  
  #' 
  #' LBBB beats: we select 600 beats form which 300 will be in the
  #' training data set and 300 in the testing data set
  #' 
  LBBB_beats = my_data_a[my_data_a[,2]=='L',]
  random_train_test = LBBB_beats[sample(nrow(LBBB_beats), 300*2),]
  train=sample(nrow(random_train_test), 300)
  random_train_test['TRAIN']=0
  random_train_test[train,'TRAIN']=1
  #' 
  #' The train data set for LBBB beats
  #' Size: 300 LBBB beats
  #'
  random_LBBB = random_train_test[random_train_test['TRAIN']==1,]
  random_LBBB_df = data.frame("ID"=random_LBBB[,1],'FILE'=random_LBBB[,3],"annot"=random_LBBB[,2])
  #' 
  #' The test data set for LBBB beats
  #' Size: 300 LBBB beats
  #'
  test_LBBB=random_train_test[random_train_test['TRAIN']==0,]
  test_LBBB_df = data.frame("ID"=test_LBBB[,1],'FILE'=test_LBBB[,3],"annot"=test_LBBB[,2])
  
  
  #' 
  #' PVC beats: we select 400 beats form which 200 will be in the
  #' training data set and 200 in the testing data set
  #' 
  PVC_beats = my_data_a[my_data_a[,2]=='V',]
  random_train_test = PVC_beats[sample(nrow(PVC_beats), 200*2),]
  train=sample(nrow(random_train_test), 200)
  random_train_test['TRAIN']=0
  random_train_test[train,'TRAIN']=1
  #' 
  #' The train data set for PVC beats
  #' Size: 200 PVC beats
  #'
  random_PVC = random_train_test[random_train_test['TRAIN']==1,]
  random_PVC_df = data.frame("ID"=random_PVC[,1],'FILE'=random_PVC[,3],"annot"=random_PVC[,2])
  #' 
  #' The test data set for PVC beats
  #' Size: 200 PVC beats
  #'
  test_PVC=random_train_test[random_train_test['TRAIN']==0,]
  test_PVC_df = data.frame("ID"=test_PVC[,1],'FILE'=test_PVC[,3],"annot"=test_PVC[,2])
  
  
  #' Split data into Train and Test set
  #' Train data set
  train_beats = rbind(random_N_df, random_APC_df, random_LBBB_df, random_RBBB_df, random_PVC_df)
  train_beats = train_beats[order(train_beats$FILE),]
  summary(train_beats)
  
  #' Test data set
  test_beats = rbind(test_N_df, test_APC_df, test_LBBB_df, test_RBBB_df, test_PVC_df)
  test_beats = test_beats[order(test_beats$FILE),]
  summary(test_beats)
  
  write.csv(train_beats, "My Random selected beats - train set")
  
  write.csv(test_beats, "My Random selected beats - test set")
  
  return(list(train_beats, test_beats))
}