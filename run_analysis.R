## Getting and Cleaning Data Course Project
##
## Student: Javier Chang
##
## This function creates a tidy data set with the average of each variable 
## for each activity and each subject and saves it into a file called as 
## indicated in the parameter 'filename'
##
## This script does the following:
##    1. Merges the training and the test sets to create one data set.
##    2. Extracts only the measurements on the mean and standard deviation for each measurement.
##    3. Uses descriptive activity names to name the activities in the data set
##    4. Appropriately labels the data set with descriptive variable names.
##    5. From the data set in step 4, creates a second, independent tidy data 
##       set with the average of each variable for each activity and each subject.

run_analysis <- function(filename="TidyAvgSummary.txt") {

  ## ----------------------------------------------------------------------------------------------
  ## STEP 1 LOAD PREREQUISITES

    ## Load libraries
  if (!require("dplyr")) {
    install.packages("dplyr")
    library(dplyr)
  }
  if (!require("tidyr")) {
    install.packages("tidyr")
    library(tidyr)
  }
  
  ## ----------------------------------------------------------------------------------------------
  ## STEP 2 DOWNLOAD DATA FROM SOURCE AND UPZIP IT

  ## Download source data
  zipfile <- "getdata_projectfiles_UCI HAR Dataset.zip"
  unzipdirectory <- "UCI HAR Dataset"
  
  if(!file.exists(zipfile)){
    datalocation <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"    
    download.file(url = datalocation, destfile = zipfile, method = "curl")
  }
  
  # Unzip the file
  if(!file.exists(unzipdirectory)){
    unzip(zipfile)
  }
  
  ## ----------------------------------------------------------------------------------------------
  ## STEP 3 READ THE RAW DATA
  ##        Read features and activity labels
  ##        Read train and test data
  ##        Assign descriptive activity names to name the activities in the data set
  ##        Labels appropriately the data set with descriptive variable names
  
  ## Read "features" and remove special characters
  features <- read.table(".\\UCI HAR Dataset\\features.txt",
                         col.names = c("featurecode", "featurename"))
  features$featurename %<>%
       gsub(",", "-", .) %>%
       gsub("-", ".", .) %>%
       gsub("()", "", .) %>%
       gsub("\\(", "", .) %>%
       gsub("\\)", "", .)
  
  ## Read "activitiy labels"
  activitylabels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt",
                         col.names = c("activitycode", "activitylabel"))
  
  ## Read train data and merge into the data frame X_train in the same order
  X_train       <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt", col.names=features$featurename)
  subject_train <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt", col.names="subject")
  y_train       <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt", col.names="activitycode")
  y_train       <- left_join(y_train, activitylabels, by="activitycode")
  X_train       <- mutate(X_train, type="train", subject=subject_train$subject, activity=y_train$activitylabel)
  
  ## Read test data and merge into the data frame X_test in the same order
  X_test       <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt", col.names=features$featurename)
  subject_test <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt", col.names="subject")
  y_test       <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt", col.names="activitycode")
  y_test       <- left_join(y_test, activitylabels, by="activitycode")
  X_test       <- mutate(X_test, type="test", subject=subject_test$subject, activity=y_test$activitylabel)
  
  ## ----------------------------------------------------------------------------------------------
  ## STEP 4 Merges the training and the test sets to create one data set.
  
  X<-rbind(X_train, X_test)
  
  ## ----------------------------------------------------------------------------------------------
  ## STEP 5 Extracts only the measurements on the mean and standard deviation for each measurement

  limitedX <-select(X, grep("(.*)mean[^F]|std(.*)", features$featurename, value=TRUE), type, subject, activity)

  ## ----------------------------------------------------------------------------------------------
  ## STEP 6 Creates a second, independent tidy data set with the average of each variable for each 
  ##        activity and each subject
  ##        Saves the tidy data set into a file
  
  limitedX %>%
         group_by(subject, activity) %>%
         summarise_at(vars(-c("type")), mean) %>%
         write.table(file=filename, row.names=FALSE)
  
}
