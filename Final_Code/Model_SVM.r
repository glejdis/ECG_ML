#'  SVM
#'  
#' Train linear model
classifier <- svm(formula = df_train[,2]  ~ ., 
                 data = df_train[,-c(1,2)], 
                 type = 'C-classification', 
                 kernel = 'linear')
classifier$SV
#' Do prediction
y_pred <- predict(classifier, df_test, type="class")
mean(y_pred==df_test[,2])
# Making the Confusion Matrix 
cm_svm <- table(y_pred, df_test[,2])

#' Train polynomial kernel, degree=2
model2 <- svm(formula = df_train[,2]  ~ ., 
              data = df_train[,-c(1,2)],
              type = 'C-classification',
              kernel = "polynomial",
              degree = 2,
              cost = 1)
#' Do prediction
prediction2 <- predict(model2, data=df_test, type="class")
mean(prediction2==df_test[,2])

# Making the Confusion Matrix 
cm2 <- table(prediction2, df_test[,2])

#' train polynomial kernel, degree=3
model3 <- svm(formula = df_train[,2]  ~ ., 
              data = df_train[,-c(1,2)],
              type = 'C-classification',
              kernel = "polynomial",
              degree = 3,
              cost = 1)
#' Do prediction
prediction3 <- predict(model3, data=df_test, type="class")
mean(prediction3==df_test[,2])

#' Making the Confusion Matrix 
cm3 <- table(prediction3, df_test[,2])

#' Train radial basis kernel
model4 <- svm(formula = df_train[,2]  ~ ., 
              data = df_train[,-c(1,2)],
              type = 'C-classification',
              kernel = "radial")
#' Do prediction
prediction4 <- predict(model4, data=df_test, type="class")
mean(prediction4==df_test[,2])

#' Making the Confusion Matrix 
cm4 <- table(prediction4, df_test[,2]) 

#' Train the best model using cross validation
model.tune <- tune.svm(df_train[,-c(1,2)], as.factor(df_train[,2]),
                       type = 'C-classification',
                       kernel = "radial",
                       gamma = c(0.001, 0.005, 0.01, 0.015, 0.02, 0.025, 0.03, 0.035, 0.04),
                       cost = c(0.5, 1, 5,  10))

summary(model.tune)
## - sampling method: 10-fold cross validation 
## - best parameters:
##   gamma cost
##   0.035   10
## - best performance: 0.07611111
#' Run 10-fold cross-validation with the best cost and gamma
model.best <- svm(formula = df_train[,2]  ~ ., 
                  data = df_train[,-c(1,2)], 
                  type = 'C-classification',
                  kernel = "radial",
                  gamma = 0.035,
                  cost = 10,
                  cross = 10,
                  probability = TRUE)
#' Accuracy 
print(model.best$tot.accuracy)
## [1] 91.72222
# Do prediction
prediction_best_SVM <- predict(model.best, df_test, type="class")
mean(prediction_best_SVM == df_test[,2])
#' Making the Confusion Matrix 
cm_best_SVM <- table(prediction_best_SVM, df_test[,2]) 
#' Calculate prediction probabilities
svm.pred.prob  <- predict(model.best, df_test, probability = TRUE)
prob.svm <- attr(svm.pred.prob, "probabilities")[,]
#' Compute AUC
AUC_cfit <- multiclass.roc(df_test[,2], prob.svm)
