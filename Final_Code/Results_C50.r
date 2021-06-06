#' Examine the results of C5.0
#'
#' Display the accuracy of C5.0 model
message("Accuracy = ", round(sum(diag(cm50))/sum(cm50), digits = 4))
## Accuracy = 0.8583

#' Display the confusion matrix, 
#' and sensitivity, specificity and accuarcy for each heartbeat class
print(f.conf_cfit)
##       A   L   N   R   V
##   A  61   3  15   2   4
##   L   6 262  20   1  22
##   N  29  19 922  27  37
##   R   4   2  16 165   2
##   V   0  14  27   5 135

##                      Class: A Class: L Class: N Class: R Class: V
## Sensitivity           0.61000   0.8733   0.9220  0.82500   0.6750
## Specificity           0.98588   0.9673   0.8600  0.98500   0.9712
## Balanced Accuracy     0.79794   0.9203   0.8910  0.90500   0.8231

cm_cfit <- as.matrix(table(cpredictions, df_test[,2]))
#' Display the precision, recall and F-measure for each heartbeat class 
#' and the weighted precision, weighted recall and weighted F-measure
prec_rec_f(cm_cfit)
## [1] "Precision, Recall and F-measure per heartbeat class"
##     precision    recall        f1
## A     0.6100000 0.7176471 0.6594595
## L 0.8733333 0.8424437 0.8576105
## N 0.9220000 0.8916828 0.9065880
## R 0.8250000 0.8730159 0.8483290
## V 0.6750000 0.7458564 0.7086614
## [1] "weightedPrecision: 0.858333333333333"
## [1] "weightedRecall: 0.855530586374793"
## [1] "weightedF1: 0.856230658612118"

#' AUC of the model
print(AUC_cfit)
## Multi-class area under the curve: 0.9215
par(mai=c(1,1,1,1))
#' Plot the ROC curves
plot_roc(c50.pred.prob, "C5.0")

#' Evaluation for ruleModel
#' Display the confusion matrix of the ruled model, 
#' and sensitivity, specificity and accuarcy for each heartbeat class
f.conf_rule
cm_rule <- as.matrix(table(rpredictions, df_test[,2]))
#' Display the precision, recall and F-measure for each heartbeat class 
#' and the weighted precision, weighted recall and weighted F-measure
prec_rec_f(cm_rule)
#' Print AUC
print(multiclass.roc(df_test[,2], c50.pred.prob.rule))
## Multi-class area under the curve: 0.8774

            