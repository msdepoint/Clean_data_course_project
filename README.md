# Clean_data_course_project
This is a repo that contains the necessary content for the Getting and Cleaning Data Course Project

##STEP 1 Merges the training and the test sets to create one data set.
We read in all of the test, train, and subject data sets in order to row bind them together

#STEP 2 Extracts only the measurements on the mean and standard deviation for each measurement. 
now we focus on cleaning up the data and then extract only what is needed
the Features data set tells us the variable labels. extract only those related to MEAN and STD
Apply those labels to the names

#STEP3 Uses descriptive activity names to name the activities in the data set
#now we focus on the y data sets and the activities
gotta fix up the correct activity names
same thing for these column names

#STEP 4 Appropriately labels the data set with descriptive variable names. 
# now we can to fix up the column names for subject

#STEP 5 From the data set in step 4, creates a second, 
#independent tidy data set with the average of each variable for each activity and each subject.
Column bind x y and subject data sets together

using the "plyr" package to get the Column Means by subject and activity

# now we need to write a text file using write.table
write.table(data_means, "depoint_cleandata_course_project_means.txt", row.name=FALSE)
