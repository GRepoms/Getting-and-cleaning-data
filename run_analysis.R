## Download UCI HAR Dataset from below URL
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## read X_train.txt,X_test.txt,y_train.txt,y_test.txt,subject_train.txt,subject_test.txt,featues.txt and activity_labels.txt

##1.Merges the training and the test sets to create one data set.
X_train   <-  read.table("UCI HAR Dataset/train/X_train.txt")
X_test    <-  read.table("UCI HAR Dataset/test/X_test.txt")
X_merge   <-  rbind(X_train, X_test)

y_train   <-  read.table("UCI HAR Dataset/train/y_train.txt")
y_test    <-  read.table("UCI HAR Dataset/test/y_test.txt") 
y_merge   <-  rbind(y_train,y_test)
   
subject_train  <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test   <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_merge <-  rbind(subject_train,subject_test)
 
##2.Extracts only the measurements on the mean and standard deviation
##  for each measurement.
features <- read.table("UCI HAR Dataset/features.txt")
# look for mean(),std() and capture only those observations
 reqd_features_indices <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
#  get subset of X_merge for above columns
 X_merge <- X_merge[, reqd_features_indices]
 ## read column names and remove ()
 names(X_merge) <-  features[reqd_features_indices, 2]
 names(X_merge) <- gsub("\\(|\\)", "",names(X_merge))
 
 ## 3.Uses descriptive activity names to name the activities in the data set.
 
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
activities[,2] <-  tolower(as.character(activities[, 2]))
 
activities_rows <- nrow(activities)
ny_merge_row <- nrow(y_merge)
 
 for(ny in 1:ny_merge_row) {
   for(act in 1:activities_rows) {
            if (activities[act,1] == y_merge[ny, 1]) 
               y_merge[ny,1] <- activities[act,2] 
          } 
     }
names(y_merge) <- "activity"
 
## 4.Appropriately labels the data set with descriptive variable names. 
names(subject_merge) <- "subject"
tidy_dataset1 <- cbind(X_merge,y_merge,subject_merge)
write.table(tidy_dataset1,"merged_tidy_dataset.txt",row.names=FALSE)
 
## 5.Creates a second, independent tidy data set -
##   with the average of each variable for each activity and each subject.
library(reshape2)
tidy_dataset2 <- melt(tidy_dataset1, id = c("subject", "activity"))

tidy_dataset_2 <- dcast(tidy_dataset2, subject + activity ~ variable, mean)

write.table(tidy_dataset_2,"tidy_dataset.txt",row.names=FALSE)
