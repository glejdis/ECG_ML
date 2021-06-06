# Heart Arrhythmia Classification 

We run different Machine Learning algorithms such as CART, C5.0, Random Forest and SVM for the classification of five classes of ECG heartbeats using Discrete Wavelet Transform (DWT) features. 

# Installation

Extract the zip file. Then the whole code can be run directly through the Main.R file. 

# Dataset

Dataset is publicly available at: 
``` link
https://www.physionet.org/content/mitdb/1.0.0/
```

and we used the attached Python script to save it in comma separated file "ecg.py". 
You need to run the Python script in order to transfer the data into csv format.

1. Download the zip file from:  
``` link
https://www.physionet.org/content/mitdb/1.0.0/
```
2. Extract it into the parent directory of the ECG_code directory
3. Create a directory 'arrhythmia' at the same level (parent ECG_code)
4. From the Final_Code directory, run the python "ecg.py" file 

In the "arrhytmia" file should appear the data ready to be used by the R scripts.

## Usage

Open and run the Main.R file. It provides references to all other files. 

## Prerequisites

In order to run the code, you need to have R Studio installed in your computer, as the code is implemented in R. 

The following two changes are necessary to be perform in the Main.R file before running the code:

1. All scripts should be contained in the working directory. You can change the working directory in the line below:

```R
#setwd("C:/Users/glejd/Desktop/ECG_code/Final_Code")
```

2. Please update the following line to set the correct directory where you have stored the data files of heartbeats:

```R
file_dir="../../arrhythmia/"
```

## Train/Test datasets

The train and test dataset is done automatically. 

The train data set and the test data set will be automatically downloaded as csv files in the same directory under the file names: "inputTocalssifier" and "validationSet" respectively. 

We saved out selected dataset, but unfortunately, we are not allowed to publish it.

## Evaluation

Each type of classifier has two files: one for building the model and one for showing the results. Therefore, in order to specifically check the results and how the evaluation is performed, you could separately run the file of each ML algorithm separately (only after you have already run the code from Main.R file), like:

```R
source(paste0(my_dir,'Results_CART.R')) ## for the CART model
source(paste0(my_dir,'Results_C50.R')) ## for the C5.0 model
source(paste0(my_dir,'Results_RF.R')) ## for the Random Forest model
source(paste0(my_dir,'Results_SVM.R')) ## for the SVM model
```

# Development 

For a detailed description of the procedures and how they run, look at the comments in the model files of each ML classifier. 

## Contact

Author: Glejdis Shkëmbi 

Contact: glejdisshkembi@gmail.com