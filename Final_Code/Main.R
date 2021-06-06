#' Libraries used in the code
library(MASS)      #     To write data into a file
library(rpart)     #     To build a CART decision tree 
library(rpart.plot)#     To plot CART tree
library(rattle)
library (gmodels)  #     To compute CrossTable
library(pROC)      #     To plot the ROC 
library(C50)       #     To build C5.0 model
library(randomForest)#   To build RF model
library(ggplot2)   #     To plot graphs
library(e1071)     #     To build SVM model
library(caret) 
library(multiROC)  #     To find mutli-class AUC

#setwd("C:/Users/glejd/Desktop/ECG_code/Final_Code")
my_dir='./'
file_dir="../../arrhythmia/"

#' File storing the function to calculate and display the precision, recall and F-measure 
#' for each heartbeat class and the weighted precision, 
#' weighted recall and weighted F-measure
source(paste0(my_dir,'Precision_Recall_F.R'))

#' File storing the function to plot multi-class ROC curve
source(paste0(my_dir,'Plot_Roc.R'))

#' File storing the forward and inverse Dynamic Wavelet Transform
source(paste0(my_dir,'DWT_1.R'))

#' File storing the function to randomly select the specific number 
#' of beats for each heartbeat class
source(paste0(my_dir,'Beats_Selection_2.R'))

#' File storing the function that does the feature selection 
#' using DWT and Statitic indicies
source(paste0(my_dir,'Feature_Extraction_3.R'))

ret_val=read_train_test(file_dir) 

train_beats=ret_val[[1]]
test_beats=ret_val[[2]]

#' Feature Exctraction (DWT and Statistics)
#' Final input for the classifier
#' Train set - used for training of the classifier
df_train <- FeatureExtract(train_beats, file_dir)

#' Test Data - used for evaluation
df_test <- FeatureExtract(test_beats, file_dir)

write.csv(df_train, file = "inputTocalssifier")
write.csv(df_test, file = "validationSet")

#' Grow the best tree model of CART
source(paste0(my_dir,'Model_CART.R'))
#' 'Results_CART.R' file uses the following variables from 'Model_CART.R' file:
#'  - fit : the first built tree
#'  - pfit : the pruned tree
#'  - cm_tree : confusion matrix of the pruned tree
#'  - Prediction_rpart : prediciton on pruned tree
#'  - rpart.cv : the model after performing 10 fold corss-validation
#'  - rpart.best : the final tree model
#'  - best.conf : confusion matrix of final model
#'  - Bestprediction : prediction on final tree model
#'  - dt.pred.prob2 : predicted probabilities for each heartbeat class on the final tree model
#'  - rpart.imp : variable importance 
#'  
#' Examine the results of CART 
source(paste0(my_dir,'Results_CART.R'))

#' Grow the best tree model of C5.0
source(paste0(my_dir,'Model_C50.R'))
#' 'Results_C50.R' file uses the following variables from 'Model_C50.R' file:
#' - cm50 : confusion matrix of the model built
#' - f.conf_cfit
#' - cpredictions : predictions of the model
#' - c50.pred.prob : the predicted probabilities for each heartbeat class
#' - AUC_cfit : auc of the model
#' - f.conf_rule : confusion matrix of ruled model
#' - rpredictions : predictions of ruled model
#' - c50.pred.prob.rule : the predicted probabilities for each heartbeat class for the ruled model
#' 
#' Examine the results of C5.0
source(paste0(my_dir,'Results_C50.R'))

#' Grow the best model of Random Forest
source(paste0(my_dir,'Model_RF.R'))
#' 'Results_RF.R' file uses the following variables from 'Model_RF.R' file:
#' - cm.rf1 : confusion matrix on training dataset of first model 
#' - cm_rf : confusion matrix on test dataset of first model 
#' - predTest : prediction on test set of first model
#' - rf_mtry : the best mtry
#' - fit_rf : the final model
#' - prediction_rf : predictions of our final model
#' - auc.rf : auc for the final RF model
#' - rf.pred.prob : the predicted probabilities for each heartbeat class
#' - imp_rf : the variable importance
#' 
#' Examine the results of Random Forest 
source(paste0(my_dir,'Results_RF.R'))

#' Grow the best model of SVM
source(paste0(my_dir,'Model_SVM.R'))
#' 'Results_SVM.R' file uses the following variables from 'Model_SVM.R' file:
#' - cm_svm : confusion matrix of the trained linear model
#' - cm2 : confusion matrix of the polynomial kernel, degree=2
#' - cm3 : confusion matrix of the polynomial kernel, degree=3
#' - cm4 : confusion matrix of the radial basis kernel
#' - cm_best_SVM : confusion matrix of the best model after 10-fold cross validation
#' - prediction_best_SVM : predictions
#' - prob.svm : prediction probabilities
#' - AUC_cfit : AUC of SVM model
#' 
#' Examine the results of SVM
source(paste0(my_dir,'Results_SVM.R'))

