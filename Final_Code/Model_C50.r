#'Boosted C5.0 
#'
#' Grow tree
#' Fit model
cfit <- C5.0(df_train[,2] ~ ., data = df_train[,-c(1,2)])
#' Summarize the fit
print(cfit) 
#' Make predictions
cpredictions <- predict(cfit, df_test, type="class") 
#' Construct confusion matrix
cm50 <- table(cpredictions, df_test[,2])
#' Check the predictions of the model
conf_cfit <- table(as.factor(cpredictions), df_test[,2])
#' Build the confusion matrix of the model
f.conf_cfit <- confusionMatrix(conf_cfit)
#' Calculate the predicted probabilities for each heartbeat class
c50.pred.prob  <- predict(cfit, df_test, type="prob")
#' Compute AUC
AUC_cfit <- multiclass.roc(df_test[,2], c50.pred.prob)

#' Fit ruled model
ruleModel <- C5.0 (df_train[,2] ~ ., data = df_train[,-c(1,2)], rules=TRUE)
#' Make predictions
rpredictions <- predict(ruleModel, df_test, type="class") 
#' Construct confusion matrix
Prediction_rule <- as.factor(rpredictions)
conf_rule <- table(Prediction_rule, df_test[,2])
f.conf_rule <- confusionMatrix(conf_rule)
#' Calculate the predicted probabilities for each heartbeat class
c50.pred.prob.rule  <- predict(ruleModel, df_test, type="prob")

