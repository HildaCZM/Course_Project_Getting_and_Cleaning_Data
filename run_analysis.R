# Course Project Getting and Cleaning Data 
# Author: Hilda Zamora-Maldonado

# This script is the Course Project for the Getting and Cleaning Data Course of Coursera
# It does the following:

# 0. Download the data and get ready the data set
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(tidyr)
library(dplyr)

# 0. Download the data 
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="localfile.zip",method="curl")
# 0.1.Unzip the file
unzip(zipfile="localfile.zip", exdir="./data")
# 0.2.Unzipped files are in the folderUCI HAR Dataset. Reading files

Xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

Xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

feature_name <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)

activity_label <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
Xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

Xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
feature_name <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
activity_label <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)

# 1. Merges the training and the test sets to create one data set using cbind and rbind
names <- c("subject_id", feature_name$V2, "activity_id")
merge_train <- cbind(subject_train, Xtrain, ytrain)
merge_test <- cbind(subject_test, Xtest, ytest)
merge_data <- rbind(merge_train, merge_test)
colnames(merge_data) <- names
colnames(activity_label) <- c("activity_id", "activity_name")

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
feat_mean_std <- merge_data[, grepl("subject_id|activity_id|mean|std", names)]
# 2.1. name `activity_id` with descriptive activity names given in activity-label
feat_named_act <- merge(feat_mean_std, activity_label, by = "activity_id")
feat_named_act$"activity_id" = NULL

# 3. Uses descriptive activity names to name the activities in the data set
# name `activity_id` with descriptive activity names given in activity-label
feat_named_act <- merge(feat_mean_std, activity_label, by = "activity_id")
feat_named_act$"activity_id" = NULL
  
# 4. Appropriately labels the data set with descriptive variable names.
# In the former part, variables activity and subject and names of the activities have been labelled using descriptive names.In this part, Names of Feteatures will labelled using descriptive variable names.
# prefix t is replaced by time
# Acc is replaced by Accelerometer
# Gyro is replaced by Gyroscope
# prefix f is replaced by frequency
# Mag is replaced by Magnitude
# BodyBody is replaced by Body
names(feat_named_act)<-gsub("^t", "time", names(feat_named_act))
names(feat_named_act)<-gsub("^f", "frequency", names(feat_named_act))
names(feat_named_act)<-gsub("Acc", "Accelerometer", names(feat_named_act))
names(feat_named_act)<-gsub("Gyro", "Gyroscope", names(feat_named_act))
names(feat_named_act)<-gsub("Mag", "Magnitude", names(feat_named_act))
names(feat_named_act)<-gsub("BodyBody", "Body", names(feat_named_act))
# check
names(feat_named_act)

# 5. From the data set in step 4, creates a second, independent tidy data 
tidy_unique <- aggregate(. ~ subject_id + activity_name, feat_named_act, FUN = mean)
# 5.1. a second, independent tidy data set will be created with the average of each variable for each activity and each subject
tidy_unique<- arrange(tidy_unique, subject_id, activity_name)
write.table(tidy_unique, file = "tidydata.txt",row.name=FALSE)
tidydata<-read.table("tidydata.txt",head=TRUE)
dim(tidydata)







