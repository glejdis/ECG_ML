#' Examine the results of Random Forest
#'
#' Accuracy on train data
message("Accuracy = ", round(sum(diag(cm.rf1))/sum(cm.rf1), digits = 2))
## Accuracy = 1
#' Accuracy on test data
message("Accuracy = ", round(sum(diag(cm_rf))/sum(cm_rf), digits = 3))
## Accuracy = 0.713
#' Display the confusion matrix
CrossTable(predTest, df_test[,2],  prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE, dnn = c('true', 'predicted'))
#' Plot the result from the search for the best mtry
plot(rf_mtry)
#' Construct confusion matrix
confusionMatrix(as.factor(prediction_rf), as.factor(df_test[,2]))
## Accuracy : 0.8944
##           Reference
## Prediction   A   L   N   R   V
##          A  60   0   0   6   0
##          L   4 257   4   0   5
##          N  32  37 989  42  43
##          R   4   0   0 152   0
##          V   0   6   7   0 152

##                      Class: A Class: L Class: N Class: R Class: V
## Sensitivity           0.60000   0.8567   0.9890  0.76000  0.76000
## Specificity           0.99647   0.9913   0.8075  0.99750  0.99187
## Balanced Accuracy     0.79824   0.9240   0.8982  0.87875  0.87594

cm_rf <- as.matrix(table(prediction_rf, df_test[,2]))
#' Display the precision, recall and F-measure for each heartbeat class 
#' and the weighted precision, weighted recall and weighted F-measure
prec_rec_f(cm_rf)
## [1] "Precision, Recall and F-measure per heartbeat class"
##   precision    recall        f1
## A 0.6000000 0.9090909 0.7228916
## L 0.8566667 0.9518519 0.9017544
## N 0.9890000 0.8652668 0.9230051
## R 0.7600000 0.9743590 0.8539326
## V 0.7600000 0.9212121 0.8328767
## [1] "weightedPrecision: 0.894444444444444"
## [1] "weightedRecall: 0.900469837346478"
## [1] "weightedF1: 0.890656924848222"

#' Display AUC for the rf model
print(auc.rf)
## Multi-class area under the curve: 0.9727

#' Plot the ROC curve
plot_roc(rf.pred.prob, "Random Forest")

#' Display model variable importance
importance(fit_rf)
imp_rf <- importance(fit_rf, type=2)
plot(imp_rf)

#' Plot variable importance
varImpPlot(fit_rf, main="Variable Importance - Random Forest")