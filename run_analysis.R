library(plyr)
# Initialization - clean up, set the files (source and destination) and download
rm(list=ls())

# set working directory
workDir = "C:\\Users\\rodney\\git\\DataScientist"
setwd(workDir);
# set the target directory for the zip file
dataDir = paste(workDir, "\\data", sep = '')

# data source
zipUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# zip file, destination
myZipFile = paste(dataDir, "\\datenbasis.zip", sep='')

# download the file
download.file(zipUrl, destfile=myZipFile)

# unzip the file
unzip(zipfile = myZipFile, exdir = dataDir)

# set the basis dir for the extracted files
baseDir <- paste(dataDir, "\\UCI HAR Dataset", sep='')

# Now the real work.
# First step: The script merges the training and the test sets to create one data set.

# Train datasets
x_train <- read.table(paste(baseDir, "\\train\\X_train.txt", sep=''))
y_train <- read.table(paste(baseDir, "\\train\\y_train.txt", sep=''))
subject_train <- read.table(paste(baseDir, "\\train\\subject_train.txt", sep=''))

# Test datasets
x_test <- read.table(paste(baseDir, "\\test\\X_test.txt", sep=''))
y_test <- read.table(paste(baseDir, "\\test\\y_test.txt", sep=''))
subject_test <- read.table(paste(baseDir, "\\test\\subject_test.txt", sep=''))

# merge train and test for further work
# x data
x_merged_observations <- rbind(x_train, x_test)

# y data
y_merged_observations <- rbind(y_train, y_test)

# subject data
subject_merged_observations <- rbind(subject_train, subject_test)

# Second step: The script extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table(paste(baseDir, "\\features.txt", sep=''))

# will filter using grep. The regexp here is the input for grep:
# (mean|std) has mean OR std
# \\(\\) followed by ()
filterForFeatures <- "-(mean|std)\\(\\)"

# filter the features. They are found in the second column of the dataFrame
filteredFeaturs <- grep(filterForFeatures, features[, 2])

# apply the filter to the merged observations 
x_merged_observations <- x_merged_observations[, filteredFeaturs]

# set the column names to the correct ones
names(x_merged_observations) <- features[filteredFeaturs, 2]

# Third step: The script uses descriptive activity names to name the activities in the data set

activityLabel <- read.table(paste(baseDir,"\\activity_labels.txt", sep=''))

# The first column of acitivyLabel has the key, the second has the Value for the label
# We replace the content of the first column (y_merged_observations[, 1]) with 
# the value of the second column (activityLabel[,2])
y_merged_observations[, 1] <- activityLabel[y_merged_observations[, 1], 2]

# correct column name
names(y_merged_observations) <- "activity"

# Forth step: The script appropriately labels the data set with descriptive variable names.

# We use subject as the column name for the subject observations
names(subject_merged_observations) <- "subject"

# bind all the data in a single data set
whole_merged_data <- cbind(x_merged_observations, y_merged_observations, subject_merged_observations)

# Fifth step: From the data set in step 4, the script creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Columns dim(x_merged_observations)[2] are from x_merged_observations
# Column dim(x_merged_observations)[2] + 1 is from activity
# Column dim(x_merged_observations)[2] + 2 is from subject
# We need to compute the average for the first columns using the last two as "variables"
colsToCompute <- c(1:as.integer(dim(x_merged_observations)[2]))
computed_averages4data <- ddply(whole_merged_data, .(subject, activity), function(theData) colMeans(theData[, colsToCompute]))

write.table(computed_averages4data, "computed_averages4data.txt", row.name=FALSE)

# End of the script