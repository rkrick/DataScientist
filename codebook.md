---
title: "Codebook for Peer-Graded Assignment"
author: "Rodney Krick"
date: "8 Dezember 2016"
output: html_document
---
## Used APIs and Data

The script run_analysis.R uses the library plyr to generate tidy data at the end of the work

The data used in the analysis can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A description of the data can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The used files are descripted in the README.txt file, inside the downloaded zip file. We've copied the description here to facilitate the understanding of the contents we will be using:

- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


## Variables used
* **subject** - the person for whom the data was collected
* **activity** - the kind of activity that was collected
* a high bunch of measurements for the accelerometer and gyroscope of the smartphones used in the experiment.

## The algorithms used
All the actions in the data sources are commented in the script run_analysis.R so we do not repeat them here.

Thank you!