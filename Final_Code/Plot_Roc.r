#' Plot a multi-class ROC curve by ploting the curve 
#' for each heartbeat class independently.
#'
#' @param probs The predicted probabilities for each heartbeat class
#' @param model_name The name of the classifier
#' 

plot_roc=function(probs,model_name){
            
        c_names=sapply(colnames(probs),FUN=function(x){paste0(substr(x,1,1),'_pred_',model_name)})
        colnames(probs)<-c_names
        
        N_true=df_test[,2]=='N'
        A_true=df_test[,2]=='A'
        V_true=df_test[,2]=='V'
        R_true=df_test[,2]=='R'
        L_true=df_test[,2]=='L'
        m_r=data.frame(probs, N_true,A_true,V_true,R_true,L_true)
        roc_res <- multi_roc(m_r) 
        roc_res_df <- plot_roc_data(roc_res)
        
        plot(1-roc_res_df$Specificity[roc_res_df$Group=='N'],
            roc_res_df$Sensitivity[roc_res_df$Group=='N'], xlab="1-Specificity", ylab="Sensitivity", type = "l", lwd = 3, main = paste0("Comparative between ROC's - ",model_name))
        
        lines(1-roc_res_df$Specificity[roc_res_df$Group=='A'],
                roc_res_df$Sensitivity[roc_res_df$Group=='A'],col = "blue", type = "l", lwd = 3)
        
        lines(1-roc_res_df$Specificity[roc_res_df$Group=='L'],
                roc_res_df$Sensitivity[roc_res_df$Group=='L'],col = "red", type = "l", lwd = 3)
        
        lines(1-roc_res_df$Specificity[roc_res_df$Group=='V'],
                roc_res_df$Sensitivity[roc_res_df$Group=='V'],col = "green", type = "l", lwd = 3)
        
        lines(1-roc_res_df$Specificity[roc_res_df$Group=='R'],
                roc_res_df$Sensitivity[roc_res_df$Group=='R'],col = "orange", type = "l", lwd = 3)
        
        legend(0.65, 0.4, legend = c("APC beat", "LBBB beat", "Normal beat", "RBBB beat", "PVC beat"), 
                lty = c(1,1,1), lwd = 3, col = c("blue", "red", "black", "orange", "green"))

}