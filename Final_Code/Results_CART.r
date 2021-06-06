#' Examine the results of CART 
#'
#' Plot the results of first built tree: fit
fancyRpartPlot(fit, caption = 'rpart tree', cex=0.5)
#' Display the cp table
printcp(fit) 
#' Plot cross-validation results
plotcp(fit)
#' Plot approximate R-squared and relative error for different splits 
rsq.rpart(fit)
#' Print results
print(fit)
#' A detailed summary of splits
summary(fit) 

round(fit$cptable[which.min(fit$cptable[,"xerror"]),"CP"], 4)

gc()

#' Plot the results of the pruned tree
fancyRpartPlot(pfit, caption = 'Pruned rpart tree', cex=0.5)
#' Accuracy of pruned tree
message("Accuracy = ", round(sum(diag(cm_tree))/sum(cm_tree), digits = 3))
## Accuracy = 0.645
cm_rpart <- as.matrix(table(Prediction_rpart, df_test[,2]))
#' Display the precision, recall and F-measure for each heartbeat class 
#' and the weighted precision, weighted recall and weighted F-measure
prec_rec_f(cm_rpart)
#' Print the confusion matrix for the pruned tree
CrossTable(df_test[,2], Prediction_rpart, prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE, dnn = c('true', 'predicted'))
#' Display sensitivity, specificity and accuracy for each heartbeat class
conf_rpart <- table(as.factor(Prediction_rpart), as.factor(df_test[,2]))
f.conf_rpart <- confusionMatrix(conf_rpart)
print(f.conf_rpart)
#' Multi-class area under the curve for the pruned tree
multiclass.roc(df_test[,2],dt.pred.prob)
## 0.728

#' Plot the model after performin 10-fold cross validation
plot(rpart.cv)
## Accuracy was used to select the optimal model using the largest value.
## The final value used for the model was cp = 0.001001684.
#' What is the standard deviation?
cat(paste("\nCross validation standard deviation:", sd(rpart.cv$resample$Accuracy), "\n", sep = " "))
## Cross validation standard deviation:  0.0305302415292835

par(mai=c(1,1,1,1))
#' Plot the results of the best tree model
fancyRpartPlot(rpart.best, sub = 'CART tree - 10-fold cross-validation with 67.1% accuracy', cex=0.5)
#' Display confusion matrix and Sensitivity, specificity and accuracy
#' for each heartbeat class

#' Display the confusion matrix of the best tree model
print(best.conf)
## Bestprediction   A   L   N   R   V
##              A  36   3  20  12   3
##              L  16 235  26   6  14
##              N  34  32 787  81 116
##              R   5  20  57  94  12
##              V   9  10 110   7  55

## Accuracy = 0.6706
##                      Class: A Class: L Class: N Class: R Class: V
## Sensitivity           0.36000   0.7833   0.7870  0.47000  0.27500
## Specificity           0.97765   0.9587   0.6713  0.94125  0.91500
## Balanced Accuracy     0.66882   0.8710   0.7291  0.70562  0.59500

cm_best <- as.matrix(table(Bestprediction, df_test[,2]))
#' Display the precision, recall and F-measure for each heartbeat class 
#' and the weighted precision, weighted recall and weighted F-measure
prec_rec_f(cm_best)
## [1] "Precision, Recall and F-measure per heartbeat class"
##   precision    recall        f1
## A 0.3600000 0.4864865 0.4137931
## L 0.7833333 0.7912458 0.7872697
## N 0.7870000 0.7495238 0.7678049
## R 0.4700000 0.5000000 0.4845361
## V 0.2750000 0.2879581 0.2813299
## [1] "weightedPrecision: 0.670555555555556"
## [1] "weightedRecall: 0.662854343657136"
## [1] "weightedF1: 0.665854607814332"

#' Multi-class area under the curve for the best tree model
par(mai=c(1,1,1,1))
print(multiclass.roc(df_test[,2],dt.pred.prob2))
## Multi-class area under the curve: 0.766

#' Plot the ROC curve
plot_roc(dt.pred.prob2, "CART")
#' Plot varaiable importnace in decreasing order
par(mai=c(4,1,1,1))
barplot(rpart.imp,las = 2, main="Variable Importance - CART", col='#005534', cex.names=0.6)

       