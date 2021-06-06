#' Decision tree with rpart
#' 
#' Grow tree
fit <- rpart(formula=df_train[,2] ~ .,data=df_train[,-c(1,2)], method="class")
#' Prune the tree
pfit <- prune(fit, cp=fit$cptable[which.min(fit$cptable[,"xerror"]),"CP"])
#' Prediction on the pruned tree
Prediction_rpart<-predict(pfit,data=df_test,type="class")
#' Build the confusion matrix of the pruned tree
cm_tree <- table(Prediction_rpart, df_test[,2])
#' Calculate the predicted probabilities for each heartbeat class
dt.pred.prob  <- predict(pfit, data=df_test, type="prob")

#' Perform 10 fold cross validation 
#' 
#' Set up caret to perform 10-fold cross validation repeated 10 times
caret.control <- trainControl(method = "repeatedcv",
                            number = 10,
                            repeats = 10)

#' The tuneLength parameter tells the algorithm to try different default values for the main parameter cp
#' we take tuneLength = 100
rpart.cv <- train(df_train[,-c(1,2)],df_train[,2],
                method = "rpart",
                trControl = caret.control, tuneLength = 100)

rpart.cv 
## Accuracy was used to select the optimal model using the largest value.
## The final value used for the model was cp = 0.001001684.
## with accuracy = 0.8105000 and kappa= 0.6954274

#' Pull out the the trained model using the best parameters on all the data
rpart.best <- rpart.cv$finalModel
#' Check the predictions of the model
Bestprediction <- predict(rpart.best,data=df_test,type="class")
Best_tree_cm = table(Bestprediction, df_test[,2])
#' Build the confusion matrix of the best tree model 
best.conf <- confusionMatrix(Best_tree_cm)
#' Calculate the predicted probabilities for each heartbeat class
dt.pred.prob2  <- predict(rpart.best, data=df_test, type="prob")

#' Report variable importance
rpart.imp <- sort(rpart.best$variable.importance,decreasing=TRUE)

