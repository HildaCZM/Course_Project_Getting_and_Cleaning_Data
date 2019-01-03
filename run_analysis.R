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

# 0. Download the data 
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="localfile.zip",method="curl")
# 0.1.Unzip the file
unzip(zipfile="localfile.zip", exdir="./data")
# 0.2.Unzipped files are in the folderUCI HAR Dataset. Get the list of the files
path_file <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_file, recursive=TRUE)
files
# 0.3. Read data from the files into the variables
# Read the Activity files
dataActTest  <- read.table(file.path(path_file, "test" , "Y_test.txt" ),header = FALSE)
dataActTrain <- read.table(file.path(path_file, "train", "Y_train.txt"),header = FALSE)
# Read the Subject files
dataSubjTrain <- read.table(file.path(path_file, "train", "subject_train.txt"),header = FALSE)
dataSubjTest  <- read.table(file.path(path_file, "test" , "subject_test.txt"),header = FALSE)
# Read Fearures files
dataFeatTest  <- read.table(file.path(path_file, "test" , "X_test.txt" ),header = FALSE)
dataFeatTrain <- read.table(file.path(path_file, "train", "X_train.txt"),header = FALSE)
# Look at the properties of the above varibles
str(dataActTest)
str(dataActTrain)
str(dataSubjTrain)
str(dataSubjTest)
str(dataFeatTest)
str(dataFeatTrain)

# 1. Merges the training and the test sets to create one data set
# 1.1 Concatenate the data tables by rows
dataSubject <- rbind(dataSubjTrain, dataSubjTest)
dataActivity<- rbind(dataActTrain, dataActTest)
dataFeatures<- rbind(dataFeatTrain, dataFeatTest)
# 1.2 set names to variables
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_file, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2
# 1.3 Merge columns to get the data frame Data for all data
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 2.1. Subset Name of Features by measurements on the mean and standard deviation
subdataFeatNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
# 2.2. Subset the data frame Data by selected names of Features
 selectedNames<-c(as.character(subdataFeatNames), "subject", "activity" )
 Data<-subset(Data,select=selectedNames)
# 2.3.Check the structures of the data frame Data
str(Data)

# 3. Uses descriptive activity names to name the activities in the data set
# 3.1. Read descriptive activity names from “activity_labels.txt”
activityLabels <- read.table(file.path(path_file, "activity_labels.txt"),header = FALSE)
# 3.2. facorize Variale activity in the data frame Data using descriptive activity names
# 3.3. check
head(Data$activity,30)
names(Data)

# 4. Appropriately labels the data set with descriptive variable names.
# In the former part, variables activity and subject and names of the activities have been labelled using descriptive names.In this part, Names of Feteatures will labelled using descriptive variable names.
# prefix t is replaced by time
# Acc is replaced by Accelerometer
# Gyro is replaced by Gyroscope
# prefix f is replaced by frequency
# Mag is replaced by Magnitude
# BodyBody is replaced by Body
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
# check
names(Data)

# 5. From the data set in step 4, creates a second, independent tidy data 
# 5.1. a second, independent tidy data set will be created with the average of each variable for each activity and each subject
library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)

# Tidy Data
tidydata<-read.table("tidydata.txt",head=TRUE)
dim(tidydata)
#columns<-colnames(tidydata)[-c(1,2)]
#cat(paste('*', columns), sep = '\n') 



