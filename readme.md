
Getting and Cleaning data
========================================================

### Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip .
### Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


#### The attached R script (run_analysis.R) performs the following to create a tidy dataset

```

1. Merges the training and test sets to create one data set as per   below:
         1.train/X_train.txt with test/X_test.txt   
         2.train/y_train.txt with test/y_test.txt
         3.train/subject_train.txt with test/subject_test.txt 


2.Extracts only the measurements on the mean and standard deviation for each measurement.

    1. reads feature.txt into a table
    2. Extracts column indices from above table containing mean() or 		std()
    3. Extracts information from X_merge using above column indices from
       features table and replaces column names with the above.
    4. Removes () & - from the column names  
    

 3.Uses descriptive activity names to name the activities in the 	     data set.
     1. reads acitivity_labels.txt
     2. changes all the names that have a capital letter in coulmn 2 of the
        above to lower case.
     3. replaces id of y_merge with activity labels of activity label
        by matching id of y_merge with id of the activity 	table.
     4. changes the column name of y_merge to activity
     

 4.Appropriately labels the data set with descriptive variable 		names.
       1.replaces the column name of subject_merge with subject
       2. Adds columns y_merge & subject_merge to X_merge
       3. writes merged dataset into a text file
       

 5.Creates a second, independent tidy data set -
   with the average of each variable for each activity and each    subject.
       1. loads reshape2 package from installed packages
       2. melts the dataset  to identify rows for each subject and activity
       3. dcast above dataset from step 2 and calculates mean of each variable 
          for each subject and each activity
       4. write above tidy dataset into a text file.

```


