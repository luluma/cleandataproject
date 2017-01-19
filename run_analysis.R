## This function cleandata() is a part of the Getting and Cleanning Data course
## project. It takes no argument, but outputs a .txt file to the folder where
## this code is run: 
##      summarydata.txt -- average value of each variable for each activity 
##                         and each subject
## Original dataset are included in the same folder, and their path are hardcoded
## in the function. 

## Attention:
# 1. when you try to run this function, please don't move data files inside
#    the folder.
# 2. Be sure to set the folder as your working directory before running the code
# 3. you can use the following command to view the result
#                > source("run_analysis.R")
#                > clean_data <- cleandata()
#                > View(clean_data)
cleandata <- function(){
    ## Merges the training and the test sets to create one data set.
    x_train <- read.table("./data/train/X_train.txt")
    x_test <- read.table("./data/test/X_test.txt")
    all_measure <- rbind(x_train, x_test)
    
    ## Merges activity id of each measuremeant
    y_train <- read.table("./data/train/y_train.txt")
    y_test <- read.table("./data/test/y_test.txt")
    activityid <- rbind(y_train, y_test)
    
    ## Merges subject id of each measurements
    subject_train <- read.table("./data/train/subject_train.txt")
    subject_test <- read.table("./data/test/subject_test.txt")
    subjectid <- rbind(subject_train, subject_test)
    
    ## Combine subject id and activity id into one dataset
    ## and give descriptive names to the activities
    sub_act_id <- as.data.frame(cbind("subjectid" = subjectid[,1], 
                                      "activityid" = activityid[,1]))
    activity_labels <- read.table("./data/activity_labels.txt")
    sub_act_label <- merge(sub_act_id, activity_labels, 
                           by.x = "activityid", by.y = "V1")
    
    ## Filter out meausrements with only mean and standard deviation value
    ## by examing the existence of the string "mean()" and "std()".
    features <- read.table("./data/features.txt")
    selected_measure <- all_measure[,grep("mean\\(\\)|std\\(\\)", features$V2)]
    
    ## Use descriptive names to name the variables,
    ## These names are chosen from the original data info - features.txt
    names(selected_measure) <- grep("mean\\(\\)|std\\(\\)", 
                                    features$V2, value = TRUE)
    
    ## Merge subject id, activity label, and measurements into one data set
    ## Give subject id and activity label descriptive variable names
    tidy_data <- cbind("subjectid" = sub_act_label[,2],
                       "activity" = sub_act_label[,3],
                       selected_measure)
    
    library(reshape2)
    melt_data <- melt(tidy_data, id = c("subjectid","activity"),
                      measure.vars = 3:length(names(tidy_data)) )
    summary_data <- dcast(melt_data, subjectid + activity ~ variable, mean)
    
    ## Write the result into .txt file.
    write.table(summary_data, file="./summarydata.txt", row.names = FALSE)
}

