# Course_Project_Getting_and_Cleaning_Data
This data set is derived from the course project of Getting and Cleaning Data course from Coursera John Hopkins University 
# This repository contains the following files

CodeBook.md: itis the code book that describes the variables, the data, and any transformations or work that you performed to clean up the data

README.md: this file explains how all of the scripts work and how they are connected.

run_analysis.R: it is the code generating the tidy data set from raw data recorded in the Human Activity Recognition Using Smartphones Data Set. The process of generating tidy data set includes the following steps:

- 0. Download the data and get ready the data set
- 1. Merges the training and the test sets to create one data set.
- 2. Extracts only the measurements on the mean and standard deviation for each measurement.
- 3. Uses descriptive activity names to name the activities in the data set
- 4. Appropriately labels the data set with descriptive variable names.
- 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidydata.txt: it is a tidy data set with unique identifiers subject and activity, with 180 observations and 81 variables 
