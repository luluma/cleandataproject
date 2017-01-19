### About This Repo
This repo is the course project of **Getting and Cleanning Data** from Coursera. It contains four parts:

- the original data files which are to be cleaned, in the "/data" folder,
- the .R script that does data cleanning and summarizing by demand,
- the tidy data (*summarydata.txt*) that results from the .R script,
- a CodeBook.md that provides basic information about the tidy data. 
    
### The Original Data Files
The original data files are put in the "/data" folder. They are included in so 
that you can run the R script without changing the hard-coded file paths. 
These data were provided along with the assignment, and can also be downloaded 
from [Here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

**Note** that only data files that are useful for producing tidy data are included in
this repo.

### The R Script
The R script mainly does the following:

1. Reads data that records the measurements, subjectid, activityid from both *train* and *test* folder. They are read by `read.table` function and combined using `rbind` funciton.

2. Subject id and activity id are first combined using `cbind` function, and activity labels are matched using:`sub_act_label <- merge(sub_act_id, activity_labels, by.x = "activityid", by.y = "V1")` 

3. According to *features.txt*, filter out measurements on the mean and standard deviation for each measurement. This is done by filtering the feature list, keeping only measurements with **mean()** and **std()** in it. Measurements with **mean** in the middle of its name or other forms are not considered in this question.

4. Assign all the measurements a descriptive name by:
`names(selected_measure) <- grep("mean\\(\\)|std\\(\\)", features$V2, value = TRUE)`

5. Combine subject id, activity id, and measurements into one data set, and assign descriptive variable name if necessary.

6. Using *reshape2* package, to creates a second, independent tidy data set with the average of each variable for each activity and each subject.
```
library(reshape2)
melt_data <- melt(tidy_data, id = c("subjectid","activity"),
                  measure.vars = 3:length(names(tidy_data)) )
summary_data <- dcast(melt_data, subjectid + activity ~ variable, mean)
```
7. Output the clean data set into folder using `write.table` function.
    
### The CodeBook.md
This file provides basic information about the tidy data, such as explanations of variable names.

### How to read data
After downloading this repo into your local machine, you can run the script by following the code: 
```
    setwd("this repo's location on you machine")
    source("run_analysis.R")
    cleandata()
    summarydata <- read.table("./summarydata.txt", header = TRUE)
    View(summarydata)
```
