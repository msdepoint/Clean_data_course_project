#run_analyis.R

##STEP 1 Merges the training and the test sets to create one data set.
## WE need to read all of the test, train, and subject data sets and merge
train_x <- read.table("./UCI HAR Dataset/train/x_train.txt")
#str(train_d1)
train_y <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

test_x <- read.table("./UCI HAR Dataset/test/x_test.txt")
test_y <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# now bring together the X data sets
data_x <- rbind(train_x, test_x)
# now bring together the Y data sets
data_y <- rbind(train_y,test_y)
# lastly, lets do the same for the subject data sets
data_subject <- rbind(train_subject,test_subject)

#STEP 2 Extracts only the measurements on the mean and standard deviation for each measurement. 
#now we focus on cleaning up the data and then extract only what is needed
#features.txt List of all features.
features <- read.table("./UCI HAR Dataset/features.txt")
#str(features)
# we only want columns with mean or std in their name. use regular expressions
features_m_s <- grep("-(mean|std)\\(\\)", features[, 2])
#features go with the x data (activities go with the y data)
data_x <- data_x[, features_m_s]
#clean up the messy columns
names(data_x) <- features[features_m_s, 2]

#STEP3 Uses descriptive activity names to name the activities in the data set
#now we focus on the y data sets and the activities
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

# gotta fix up the correct activity names
data_y[, 1] <- activities[data_y[, 1], 2]

# same thing for these column names
names(data_y) <- "activity"

#STEP 4 Appropriately labels the data set with descriptive variable names. 
# now we can to fix up the column names for subject
names(data_subject) <- "subject"

#STEP 5 From the data set in step 4, creates a second, 
#independent tidy data set with the average of each variable for each activity and each subject.
data_x_y_sub <- cbind(data_x,data_y,data_subject)
library(plyr)
data_means <- ddply(data_x_y_sub, .(subject, activity), function(x) colMeans(x[, 1:66]))
#str(data_means)
summary(data_means$activity)
# now we need to write a text file using write.table
write.table(data_means, "depoint_cleandata_course_project_means.txt", row.name=FALSE)
