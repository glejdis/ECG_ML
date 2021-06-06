#' Random forest
#' Build the model
#'
model1 <- randomForest(df_train[,-c(1,2)], df_train[,2], importance = TRUE)
#' Predicting on train set
predTrain1 <- predict(model1, df_train, type = "class")
#' Checking classification accuracy on training dataset
cm.rf1 <- table(predTrain1, df_train[,2])
#' Predicting on test set
predTest <- predict(model1, data = df_test[,2], type = "class")
#' Checking classification accuracy on test dataset
cm_rf = table(predTest, df_test[,2])
#' Perform 10-fold cross validation
#' Define the control
trControl <- trainControl(method = "cv",
                          number = 10,
                          search = "grid")
set.seed(1234)

#' Run the model
rf_default <- train(df_train[,-c(1,2)], df_train[,2],
                    method = "rf",
                    metric = "Accuracy",
                    trControl = trControl)
#' Print the results
print(rf_default)

##   mtry  Accuracy   Kappa    
##    2    0.9155556  0.8606860
##   14    0.9155556  0.8616990
##   27    0.9050000  0.8451002

## Accuracy was used to select the optimal model using the largest value.
## The final value used for the model was mtry = 2.

#' Search best mtry
set.seed(1234)
tuneGrid <- expand.grid(.mtry = c(1: 20))
rf_mtry <- train(df_train[,-c(1,2)], df_train[,2],
                 method = "rf",
                 metric = "Accuracy",
                 tuneGrid = tuneGrid,
                 trControl = trControl,
                 importance = TRUE,
                 nodesize = 10,
                 ntree = 500)
print(rf_mtry)

##     mtry  Accuracy   Kappa    
##     1    0.8733333  0.7849975
##     2    0.8977778  0.8292275
##     3    0.9077778  0.8472829
##     4    0.9088889  0.8492510
##     5    0.9094444  0.8505438
##     6    0.9083333  0.8486430
##     7    0.9088889  0.8496242
##     8    0.9088889  0.8500147
##     9    0.9100000  0.8517920
##    10    0.9122222  0.8557002
##    11    0.9066667  0.8462123
##    12    0.9077778  0.8482181
##    13    0.9088889  0.8500285
##    14    0.9105556  0.8529023
##    15    0.9094444  0.8511783
##    16    0.9105556  0.8527357
##    17    0.9105556  0.8530189
##    18    0.9077778  0.8484735
##    19    0.9094444  0.8513404
##    20    0.9061111  0.8456415

## Accuracy was used to select the optimal model using the largest value.
## The final value used for the model was mtry = 10. 

#' The best value of mtry is stored in:
best_mtry <- rf_mtry$bestTune$mtry
max(rf_mtry$results$Accuracy)
## [1] 0.9122222

#' Search the best maxnodes
store_maxnode <- list()
tuneGrid <- expand.grid(.mtry = best_mtry)
for (maxnodes in c(5: 15)) {
  set.seed(1234)
  rf_maxnode <- train(df_train[,-c(1,2)], df_train[,2],
                      method = "rf",
                      metric = "Accuracy",
                      tuneGrid = tuneGrid,
                      trControl = trControl,
                      importance = TRUE,
                      nodesize = 10,
                      maxnodes = maxnodes,
                      ntree = 500)
  current_iteration <- toString(maxnodes)
  store_maxnode[[current_iteration]] <- rf_maxnode
}
results_mtry <- resamples(store_maxnode)
summary(results_mtry)

store_maxnode <- list()
tuneGrid <- expand.grid(.mtry = best_mtry)
for (maxnodes in c(20: 30)) {
  set.seed(1234)
  rf_maxnode <- train(df_train[,-c(1,2)], df_train[,2],
                      method = "rf",
                      metric = "Accuracy",
                      tuneGrid = tuneGrid,
                      trControl = trControl,
                      importance = TRUE,
                      nodesize = 10,
                      maxnodes = maxnodes,
                      ntree = 500)
  key <- toString(maxnodes)
  store_maxnode[[key]] <- rf_maxnode
}
results_node <- resamples(store_maxnode)
summary(results_node)

store_maxnode <- list()
tuneGrid <- expand.grid(.mtry = best_mtry)
for (maxnodes in c(35: 45)) {
  set.seed(1234)
  rf_maxnode <- train(df_train[,-c(1,2)], df_train[,2],
                      method = "rf",
                      metric = "Accuracy",
                      tuneGrid = tuneGrid,
                      trControl = trControl,
                      importance = TRUE,
                      nodesize = 10,
                      maxnodes = maxnodes,
                      ntree = 500)
  key <- toString(maxnodes)
  store_maxnode[[key]] <- rf_maxnode
}
results_node <- resamples(store_maxnode)
summary(results_node)

store_maxnode <- list()
tuneGrid <- expand.grid(.mtry = best_mtry)
for (maxnodes in c(46: 56)) {
  set.seed(1234)
  rf_maxnode <- train(df_train[,-c(1,2)], df_train[,2],
                      method = "rf",
                      metric = "Accuracy",
                      tuneGrid = tuneGrid,
                      trControl = trControl,
                      importance = TRUE,
                      nodesize = 10,
                      maxnodes = maxnodes,
                      ntree = 500)
  key <- toString(maxnodes)
  store_maxnode[[key]] <- rf_maxnode
}
results_node <- resamples(store_maxnode)
summary(results_node)

## The highest accuracy score is obtained with a value of maxnode equals to 56.
## 0.9166667 Max Accuracy

#' Search the best ntrees
store_maxtrees <- list()
for (ntree in c(250, 300, 350, 400, 450, 500, 550, 600, 800, 1000, 2000)) {
  set.seed(5678)
  rf_maxtrees <- train(df_train[,-c(1,2)], df_train[,2],
                       method = "rf",
                       metric = "Accuracy",
                       tuneGrid = tuneGrid,
                       trControl = trControl,
                       importance = TRUE,
                       nodesize = 10,
                       maxnodes = 56,
                       ntree = ntree)
  key <- toString(ntree)
  store_maxtrees[[key]] <- rf_maxtrees
}
results_tree <- resamples(store_maxtrees)
summary(results_tree)

#' Best ntree = 800
#' with max accuracy of 0.9277778 and max kappa = 0.8826479
#' 
#' We have our final model. We can train the random forest with the following parameters:
#'   ntree = 800: 800 trees will be trained
#'   mtry=10: 10 features is chosen for each iteration
#'   maxnodes = 56: Maximum 56 nodes in the terminal nodes (leaves)
#' 
fit_rf <- randomForest(df_train[,-c(1,2)], df_train[,2],
                method = "rf",
                metric = "Accuracy",
                tuneGrid = tuneGrid,
                trControl = trControl,
                importance = TRUE,
                nodesize = 10,
                ntree = 800,
                maxnodes = 56)
#' Make predictions
prediction_rf <-predict(fit_rf, df_test)
#' Predicted probabilities for each heartbeat class
rf.pred.prob  <- predict(fit_rf, df_test, type="prob")
#' Calulate AUC for the rf model
auc.rf <- multiclass.roc(df_test[,2], rf.pred.prob)
