# Instructions
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# This script uses mutate
library(dplyr)

### Helper function to read measurement files and calculate means and standard deviations.
calculate_average_and_stdevs <- function(filename, prefix){
  # calculate_average_and_stdevs("UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt", "body_acc_train_x")
  # returns a dataframe where the labels are prefix
  # in this example, they would be "body_acc_train_x_mean", "body_acc_train_x_sd"
  
  file_data  <- read.delim(filename, sep="", header=FALSE)
  mean_list <- rowMeans(file_data)
  stdev_list <- apply(file_data, 1 , sd)
  mean_label <- paste(prefix, "_mean", sep="")
  sd_label <- paste(prefix, "_sd", sep="")
  df<-data.frame(cbind(mean_list,  stdev_list))
  names(df) <- c(mean_label, sd_label)
  df
}



### 1) Reads each of the 9 measurement files from each of the 2 datasets (training and test).
### 2) Calculates means and standard deviations of each measurement.

training_data <- cbind( calculate_average_and_stdevs("UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt", "acc_x"),
                        calculate_average_and_stdevs("UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt", "acc_y"),
                        calculate_average_and_stdevs("UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt", "acc_z"),
                        calculate_average_and_stdevs("UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt", "gyro_x"),
                        calculate_average_and_stdevs("UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt", "gyro_y"),
                        calculate_average_and_stdevs("UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt", "gyro_z"),
                        calculate_average_and_stdevs("UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt", "total_x"),
                        calculate_average_and_stdevs("UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt", "total_y"),
                        calculate_average_and_stdevs("UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt", "total_z") )

testing_data <- cbind( calculate_average_and_stdevs("UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt", "acc_x"),
                       calculate_average_and_stdevs("UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt", "acc_y"),
                       calculate_average_and_stdevs("UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt", "acc_z"),
                       calculate_average_and_stdevs("UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt", "gyro_x"),
                       calculate_average_and_stdevs("UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt", "gyro_y"),
                       calculate_average_and_stdevs("UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt", "gyro_z"),
                       calculate_average_and_stdevs("UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt", "total_x"),
                       calculate_average_and_stdevs("UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt", "total_y"),
                       calculate_average_and_stdevs("UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt", "total_z") )

### 3) Assigns subject and activity to each measurement, mapping activity names.
# Training set
# read subject data
training_subjects <- read.delim("UCI HAR Dataset/train/subject_train.txt", header=FALSE)
names(training_subjects) <- "subject"

# read activity data
training_activities<- read.delim("UCI HAR Dataset/train/y_train.txt", header=FALSE)
names(training_activities) <- "activity"

# prepend subject and activity data and clean up
training_data <- cbind(training_subjects, training_activities, training_data)
rm(training_subjects, training_activities)

# set unnecessary flag to track where data originated from.
training_data <- mutate(training_data, set="train")

# Test Set
# read subject data
testing_subjects <- read.delim("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
names(testing_subjects) <- "subject"

# read activity data
testing_activities<- read.delim("UCI HAR Dataset/test/y_test.txt", header=FALSE)
names(testing_activities) <- "activity"

# prepend subject and activity data and clean up
testing_data <- cbind(testing_subjects, testing_activities, testing_data)
rm(testing_subjects, testing_activities)

# set unnecessary flag to track where data originated from.
testing_data <- mutate(testing_data, set="test")

### 4) Combines training and test sets to a single data frame.
all_data <- rbind(training_data, testing_data)

# read mapping of activity number to name.
# replace number with names in place in the dataset
activities_map <- read.delim("UCI HAR Dataset/activity_labels.txt", header=FALSE, sep="")
all_data <- mutate(all_data, activity = activities_map[activity,2])
# all_data <- mutate(all_data, activity = gsub("_", " ", activities_map[activity,2]))


# convert subjects to factors
all_data$subject <- as.factor(all_data$subject)

# write out csv file
write.csv(all_data, file="all_data.csv" )



labels <- c("subject", "activity", 
            "body_acc_x", "body_acc_y", "body_acc_z", 
            "body_gyro_x", "body_gyro_y", "body_gyro_z",
            "total_acc_x", "total_acc_y", "total_acc_z" )


### 5) Create a second data set with averages of each variable for each activity for each subject.
#create an empty data frame
average_data = data.frame()

#iterate over all subjects and activities
# average all the means and standard deviations for a given subject/activity combination
# Add the averages to the data frame
for (s in levels(all_data$subject)){
  for (a in levels(all_data$activity)) {
    subject_per_activity_data <- filter(all_data, subject==s, activity==a)
     averages <- colMeans(select(subject_per_activity_data, -subject, -activity, -set))
     averages <- c(subject=s, activity=a, averages)
     average_data <- rbind(average_data, matrix(unlist(averages), nrow = 1))
  }
}

# set the column names on the data frame
#names(average_data) <- names(all_data)[1:20]
names(average_data) <- gsub("acc_", "ave_acc_", gsub("gyro_", "ave_gyro_", gsub("total_", "ave_total_", names(all_data)[1:20])))

# change the numeric columns back to numeric
cols <- c(3:20)
average_data[,cols] <- apply(average_data[,cols], 2, function(x) as.numeric(as.character(x)))
                  
# write the averages back out to file
write.csv(average_data, file="averaged_data.csv" )
write.table(average_data, file="averaged_data.txt", row.name=FALSE)
