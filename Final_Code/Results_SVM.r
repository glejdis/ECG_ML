#' Evaluate the SVM models
#'
#' Accuracy of the linear model
message("Accuracy = ", round(sum(diag(cm_svm))/sum(cm_svm), digits = 3))
## Accuracy = 0.864
#' Accuracy of the polynomial kernel, degree=2
message("Accuracy = ", round(sum(diag(cm2))/sum(cm2), digits = 3))
## Accuracy = 0.694
#' Accuracy of the polynomial kernel, degree=3
message("Accuracy = ", round(sum(diag(cm3))/sum(cm3), digits = 3))
## Accuracy = 0.713
#' Accuracy of the radial basis kernel
message("Accuracy = ", round(sum(diag(cm4))/sum(cm4), digits = 3))
## Accuracy = 0.716

#' Display the confusion matrix of the best model after 10-fold cross validation
print(cm_best_SVM)
## prediction_best_SVM   A   L   N   R   V
##                   A  67   0   5   3   2
##                   L   1 275   7   0   5
##                   N  24  19 974   6  12
##                   R   7   0   6 191   0
##                   V   1   6   8   0 181
#' Display the confusion matrix, 
#' and sensitivity, specificity and accuarcy for each heartbeat class
Prediction_best_SVM <- as.factor(prediction_best_SVM)
conf_best_SVM <- table(Prediction_best_SVM, df_test[,2])
f.conf_best_SVM <- confusionMatrix(conf_best_SVM)
print(f.conf_best_SVM)
##                      Class: A Class: L Class: N Class: R Class: V
## Sensitivity           0.67000   0.9167   0.9740   0.9550   0.9050
## Specificity           0.99412   0.9913   0.9237   0.9919   0.9906
## Balanced Accuracy     0.83206   0.9540   0.9489   0.9734   0.9478

#' Accuracy of the best model
message("Accuracy = ", round(sum(diag(cm_best_SVM))/sum(cm_best_SVM), digits = 4))
## Accuracy = 0.9378

cm_best_SVM <- as.matrix(table(prediction_best_SVM, df_test[,2]))
#' Display the precision, recall and F-measure for each heartbeat class 
#' and the weighted precision, weighted recall and weighted F-measure
prec_rec_f(cm_best_SVM)
## [1] "Precision, Recall and F-measure per heartbeat class"
##   precision    recall        f1
## A 0.6700000 0.8701299 0.7570621
## L 0.9166667 0.9548611 0.9353741
## N 0.9740000 0.9410628 0.9572482
## R 0.9550000 0.9362745 0.9455446
## V 0.9050000 0.9234694 0.9141414
## [1] "weightedPrecision: 0.937777777777778"
## [1] "weightedRecall: 0.936934945439162"
## [1] "weightedF1: 0.936391005863752"

#' AUC
print(AUC_cfit)
## Multi-class area under the curve: 0.9759
par(mai=c(1,1,1,1))
#' Plot the ROC curves
plot_roc(prob.svm, "SVM")