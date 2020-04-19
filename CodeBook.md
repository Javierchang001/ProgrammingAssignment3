This code book describes the variables, the data, and any
transformations or work to clean up the Final Getting and Cleaning Data
Course Project data

Getting the Raw Data
--------------------

The raw data comes from the accelerometers from Samsung Galaxy S
smartphones used in an experiment carried out with a group of 30
volunteers. Each person performed six activities wearing the smartphone
on the waist and using its embedded accelerometer and gyroscope they
collected several measures. The obtained dataset has been randomly
partitioned into two sets, where 70% of the volunteers was selected for
generating the training data and 30% the test data.

A full description is available at the site where the data was obtained:

<a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones" class="uri">http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones</a>

The data for the project is downloaded from:

<a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" class="uri">https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip</a>

The zip file is saved in the working directory and it is unzipped to the
folder ‘UCI HAR Dataset’. In this folder there is a **README.txt** file
describing the raw data set.

The Cleaning Data process
-------------------------

The R script called run\_analysis.R that does the following.

1.  Read the raw data master files

    The following files are read into the corresponding data frames

    -   ‘features.txt’ is loaded into *features* data frame and it’s
        special charaters are removed or modified to ‘.’
    -   ‘activity\_labels.txt’ is loaded into *activitylabels* data
        frame.

2.  Read the raw training data

    The train data set is located at the ‘UCI HAR Dataset’ folder. The
    data set is splitted into three files:

    -   ‘X\_train.txt’ are all the train observations for the
        experiment.The column names are assigned from the *features*
        data frame with the descriptive variable names.
    -   ‘y\_train.txt’ are the activity codes (numeric) related to each
        observation in X\_train in the same order. The only column name
        is called ‘activitycode’.
    -   ‘subject\_train.txt’ are the subjects related to each
        observation in X\_train in the same order. The only column name
        is called ‘subject’.

    The three file are read into the *X\_train*, *y\_train*,
    *subject\_train* data frames. The *y\_train* data frame is joined
    with *activitylabes* to obtaint the activity labels and finally the
    *X\_train* data frame is added with the following columns:

    -   type: contains the string ‘train’ to identify the type of data
        set
    -   subject: contains the subject of the observation
    -   activity: contains the activity label for the observation

3.  Read the raw testing data

    The test data set is located at the ‘UCI HAR Dataset’ folder. The
    data set is splitted into three files:

    -   ‘X\_test.txt’ are all the test observations for the experiment.
        The column names are assigned from the *features* data frame
        with the descriptive variable names.

    -   ‘y\_test.txt’ are the activity code (numeric) related to each
        observation in X\_test in the same order. The only column name
        is called ‘activitycode’.

    -   ‘subject\_test.txt’ are the subjects related to each observation
        in X\_train in the same order. The only column name is called
        ‘subject’.

    The three file are read into the *X\_test*, *y\_test*,
    *subject\_test* data frames. The *y\_test* data frame is joined with
    *activitylabes* to obtaint the activity labels and finally the
    *X\_test* data frame is added with the following columns:

    -   type: contains the string ‘test’ to identify the type of data
        set
    -   subject: contains the subject of the observation
    -   activity: contains the activity label for the observation

4.  Merges the training and the test sets to create one data set.

    The *X\_train* and the *X\_test* data frames, which contains the
    same columns, are merged into the *X* data frame

5.  Extracts only the measurements on the mean and standard deviation
    for each measurement.

    A new data frame called *limitedX* is created with the selection of
    only the rows (measurements) on the mean and standard deviation for
    each measurent, plus the *type*, *activitylabel* and *subject*
    columns

6.  Creates a second, independent tidy data set with the average of each
    variable for each activity and each subject.

    The *limitedX* data frame is grouped by subject and activity and
    then it is summarized with the means of all the measurements except
    the ‘type’ variable to obtain the final data set.

The Tidy Data Set
-----------------

This is the final output of the cleaning process. The tidy data set is
written to a file named *TidyAvgSummary.txt* in the working directory.
It contains the average of each variable for each subject and each
activity. The columns are the following:

-   Subject : ID of the subject (1 to 30)
-   Activity: WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING,
    STANDING, LAYING
-   tBodyAcc.mean.X
-   tBodyAcc.mean.Y
-   tBodyAcc.mean.Z
-   tBodyAcc.std.X
-   tBodyAcc.std.Y
-   tBodyAcc.std.Z
-   tGravityAcc.mean.X
-   tGravityAcc.mean.Y
-   tGravityAcc.mean.Z
-   tGravityAcc.std.X
-   tGravityAcc.std.Y
-   tGravityAcc.std.Z
-   tBodyAccJerk.mean.X
-   tBodyAccJerk.mean.Y
-   tBodyAccJerk.mean.Z
-   tBodyAccJerk.std.X
-   tBodyAccJerk.std.Y
-   tBodyAccJerk.std.Z
-   tBodyGyro.mean.X
-   tBodyGyro.mean.Y
-   tBodyGyro.mean.Z
-   tBodyGyro.std.X
-   tBodyGyro.std.Y
-   tBodyGyro.std.Z
-   tBodyGyroJerk.mean.X
-   tBodyGyroJerk.mean.Y
-   tBodyGyroJerk.mean.Z
-   tBodyGyroJerk.std.X
-   tBodyGyroJerk.std.Y
-   tBodyGyroJerk.std.Z
-   tBodyAccMag.std
-   tGravityAccMag.std
-   tBodyAccJerkMag.std
-   tBodyGyroMag.std
-   tBodyGyroJerkMag.std
-   fBodyAcc.mean.X
-   fBodyAcc.mean.Y
-   fBodyAcc.mean.Z
-   fBodyAcc.std.X
-   fBodyAcc.std.Y
-   fBodyAcc.std.Z
-   fBodyAccJerk.mean.X
-   fBodyAccJerk.mean.Y
-   fBodyAccJerk.mean.Z
-   fBodyAccJerk.std.X
-   fBodyAccJerk.std.Y
-   fBodyAccJerk.std.Z
-   fBodyGyro.mean.X
-   fBodyGyro.mean.Y
-   fBodyGyro.mean.Z
-   fBodyGyro.std.X
-   fBodyGyro.std.Y
-   fBodyGyro.std.Z
-   fBodyAccMag.std
-   fBodyBodyAccJerkMag.std
-   fBodyBodyGyroMag.std
-   fBodyBodyGyroJerkMag.std
