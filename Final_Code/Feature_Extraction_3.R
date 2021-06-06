  #' Feature extraction using DWT and Statitics 
  #'
  #' @param beats_set
  #' The training or testing beats data set
  #' @return A df_retrix with features (DWT + Statistics)
  #' 
  
  FeatureExtract <- function(beats_set, file_dir) {
    rbind(1:23, table(beats_set$annot)) #annotation names to numbers
    r = 1
    nr=1800
    df_ret <- data.frame(ID = numeric(nr), annot = character(nr), 
                         stringsAsFactors = FALSE)
    for (i in 3:29)
      df_ret[i]=df_ret$ID
    for(fid in levels(beats_set$FILE)){
      my_data=read.csv(paste0(file_dir,fid,".csv"),header=F,na.strings="?")
      selected=beats_set$FILE==fid
      from_this=beats_set[selected,]
      for(beat_id in from_this[,'ID']){
        input_to_fwt = my_data[,1][(beat_id-100):(beat_id+219)] 
        output_fwt = fwt(input_to_fwt, 6)
        d1 = output_fwt[161:320]
        d2 = output_fwt[81:160]
        d3 = output_fwt[41:80]
        d4 = output_fwt[21:40]
        d5 = output_fwt[11:20]
        d6 = output_fwt[6:10]
        a6 = output_fwt[1:5]

        df_ret[r,1] = beat_id
        df_ret[r,2] = paste0(from_this[from_this$ID==beat_id,'annot'])
        abs_d1 = abs(d1)
        df_ret[r,3] = mean(abs_d1)	
        df_ret[r,4] = mean(d1)
        df_ret[r,5] = sd(d1)
        abs_d2 = abs(d2)
        df_ret[r,6] = mean(abs_d2)
        df_ret[r,7] = mean(d2)
        df_ret[r,8] = sd(d2)
        df_ret[r,9] = (mean(abs_d2)) / (mean(abs_d1))
        abs_d3 = abs(d3)
        df_ret[r,10] = mean(abs_d3)
        df_ret[r,11] = mean(d3)
        df_ret[r,12] = sd(d3)
        df_ret[r,13] = (mean(abs_d3)) / (mean(abs_d2))
        abs_d4 = abs(d4)
        df_ret[r,14] = mean(abs_d4)
        df_ret[r,15] = mean(d4)
        df_ret[r,16] = sd(d4)
        df_ret[r,17] = (mean(abs_d4)) / (mean(abs_d3))
        abs_d5 = abs(d5)
        df_ret[r,18] = mean(abs_d5)
        df_ret[r,19] = mean(d5)
        df_ret[r,20] = sd(d5)
        df_ret[r,21] = (mean(abs_d5)) / (mean(abs_d4))
        abs_d6 = abs(d6)
        df_ret[r,22] = mean(abs_d6)
        df_ret[r,23] = mean(d6)
        df_ret[r,24] = sd(d6)
        df_ret[r,25] = (mean(abs_d6)) / (mean(abs_d5))
        abs_a6 = abs(a6)
        df_ret[r,26] = mean(abs_a6)
        df_ret[r,27] = mean(a6)
        df_ret[r,28] = sd(a6)
        df_ret[r, 29] = (mean(abs_a6)) / (mean(abs_d6))
        
        r=r+1
        
      }
    }
    df_ret[,2] <- as.factor(df_ret[,2])
    #' Assign names to columns
    my_names=c("ID","annot","mean(abs_DWT1)","mean(DWT1)","sd(DWT1)",
               "mean(abs_DWT2)","mean(DWT2)","sd(DWT2)","(mean(abs_DWT2)) / (mean(abs_DWT1))","mean(abs_DWT3)",
               "mean(DWT3)","sd(DWT3)","(mean(abs_DWT3)) / (mean(abs_DWT2))","mean(abs_DWT4)","mean(DWT4)",
               "sd(DWT4)","(mean(abs_DWT4)) / (mean(abs_DWT3))","mean(abs_DWT5)","mean(DWT5)","sd(DWT5)",
               "(mean(abs_DWT5)) / (mean(abs_DWT4))","mean(abs_DWT6)","mean(DWT6)","sd(DWT6)",
               "(mean(abs_DWT6)) / (mean(abs_DWT5))","mean(abs_A6)","mean(A6)","sd(A6)","(mean(abs_A6)) / (mean(abs_DWT6))" ) 
    names(df_ret)=my_names
    return(df_ret)
  }
