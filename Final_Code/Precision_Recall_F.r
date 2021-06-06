#' Calculate and display the precision, recall and F-measure 
#' for each heartbeat class and the weighted precision, 
#' weighted recall and weighted F-measure
#' 
#' @param cm The confusion matrix
#' 
prec_rec_f=function(cm){
    cn=colnames(cm)
    if(!(cn[1]=='A' && cn[2]=='L' && cn[3]=='N' && cn[4]=='R' && cn[5]=='V' ))
        {
        print('Wrong sequence of labels')
        return()
        }

    n = sum(cm) # number of instances
    nc = nrow(cm) # number of classes
    rowsums = apply(cm, 1, sum) # number of instances per class
    colsums = apply(cm, 2, sum) # number of predictions per class
    diag = diag(cm)  # number of correctly classified instances per class 
    
    precision = diag / colsums 
    recall = diag / rowsums 
    f1 = 2 * precision * recall / (precision + recall) 

    #' Display the result
    print("Precision, Recall and F-measure per heartbeat class")
    print(data.frame(precision, recall, f1))

    mv=c(100,300,1000,200,200)

    #' Calculate weightedPrecision, weightedRecall and weightedF1
    weightedPrecision = (precision%*%mv)/sum(mv)
    
    weightedRecall = (recall%*%mv)/sum(mv)
    
    weightedF1 = (f1%*%mv)/sum(mv)

    #' Display the result
    print(paste0('weightedPrecision: ',weightedPrecision))
    print(paste0('weightedRecall: ',weightedRecall))
    print(paste0('weightedF1: ',weightedF1))
    message("Accuracy = ", round(sum(diag(cm))/sum(cm), digits = 4))
  
}