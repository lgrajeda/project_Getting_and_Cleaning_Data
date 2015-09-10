#Project Course
#Getting and cleaning data

##Codebook

###Project description:
The idea behind this project is to show the student´s ability to clean a real world data set using R tools. The product is a new data set that is ready to use for analysis. 


###Data source:
The original data comes from The Human Activity Recognition Using Smartphones Dataset. The authors are: Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. Smartlab - Non Linear Complex Systems Laboratory. DITEN - Università degli Studi di Genova. Via Opera Pia 11A, I-16145, Genoa, Italy. activityrecognition@smartlab.ws www.smartlab.ws. The objective was to evaluate if it was possible to predict the activity performed by the subjetec given the data collected by the smartphone.



###Study design and background:
This is data on 30 subjects (age range: 19 to 48 years) who perform 6 different activities (walking, walking usptairs, walking downstairs, sitting, standing and laying) while using an accelerometer and gyroscope. At each observation the study team collected: triaxial acceleratio from the accelerometer with the estimated body acceleration and a triaxial angular velocity from the gyroscope.

A full description of the data can be found: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

###Raw data:
Raw data was separte into two folders contaning train (7352 records, 70%) or test (2947 records, 30%) data sets. Within each folder, the raw data was conformed by different tables for: subject ID (codedd as 1-30), accelerometer and gyroscope data (), performed activity (coded as 1 to 6). Separate text files contains the labels for the different neasurements.

Raw data can be dowloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

###Tyding process:
1. Merge train and test data sets (10299 records)
2. Add variable names to accelerometer and gyroscope data.
3. Extract the measuremente on the mean and standard deviation for each measurement using DPLYR
4. Add activity labels
5. Confirm that activity names are descriptive
6. label the variables for the mean and standard deviation measurements in order to be descriptive
7. Create a second data set with the average of each varaible for each activity and each subject using DPLYE

###Processed data:
The processed data has 180 observations and 88 varaibles. The 180 observations como from 6 activities measured in 30 participants. The processed data has a varaible for subject ID (coded as 1 to 30), a variable for activity (coded as factor: walking, walking usptairs, walking downstairs, sitting, standing and laying) and the mean and standard deviation for each accelerometer and gyroscope measurmente in the three dimensions.
