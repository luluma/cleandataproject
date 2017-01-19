## Data Origins and Background
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

### Data Cleaning
The original train and test data sets were first combined into one data set, but only measurements on the mean and standard deviation value were preserved. Then subject id and activity name were match for each measurement record. In the end, the average value of each measurement for each activity and each subject is calculated. So in the clean data (*summarydata.txt*) the value in the cell for each measurement is not a single record, but the mean value from multiple obersevation.

### Data Structure
Variable Name | Data Type | Description | Value |
--------------|-----------|-------------|-------|
subjectid | Integer | Subject id | 1:30 |
activity | Character | Activity Name | WALKING/WALKING_UPSTAIRS/WALKING_DOWNSTAIRS/SITTING/STANDING/LAYING|
other variables | Numeric | Measurement Label | Average value of each measurements for each activity and each subject, see **Feature Labels** for the signal explanation|

### Feature Labels
These signals were used to estimate variables of the feature vector for each pattern:
* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

`-XYZ` is used to denote 3-axial signals in the X, Y and Z directions.
`t` is used to denote time.
`Acc` and `Gyro` are used to denote the source of measurements -- accelerometer and gyroscope.
`Body` and `Gravity` stand for body and gravity acceleration signals.
`Jerk` denotes that the body linear acceleration and angular velocity were derived in time to obtain Jerk signals ()
`Mag` means the magnitude of the signals were calculated using the Euclidean norm.
And the `f` in the front are to indicate frequency domain signals, meaning a Fast Fourier Transform (FFT) was applied to some of these signals

### How to read data
After downloading this repo into your local machine, you can run the script by following the code: 
```
    setwd("this repo's location on you machine")
    source("run_analysis.R")
    cleandata()
    summarydata <- read.table("./summarydata.txt", header = TRUE)
    View(summarydata)
```
