# Codebook.md
This codebook describes the variables, the data, and any transformations or work that you performed to clean up the data.

##### The following actions are performed in the <b><i>run_analysis.R</i></b> script:
1) Reads each of the 9 measurement files from each of the 2 datasets (training and test).
  - These are located in the directories "UCI HAR Dataset/train/Inertial Signals/" and UCI HAR Dataset/test/Inertial Signals/"

2) Calculates means and standard deviations of each measurement across the window (row) for the measurement.

3) Assigns subject and activity to each measurement, mapping activity names.
  - Using the data from "UCI HAR Dataset/train/subject_train.txt" and "UCI HAR Dataset/test/subject_train.txt", the subject numbers are attached to the mean and standard deviations of the measurements.
  - Using the data from "UCI HAR Dataset/train/y_train.txt" and "UCI HAR Dataset/test/y_test.txt", the activity is assigned based on number.

4) Combines training and test sets to a single data frame.
  - the two datasets are combined using rbind.
  - The activities names are read from "UCI HAR Dataset/activity_labels.txt" and the activity numbers are replaced by the names.
  - data are stored in the file, "all_data.csv"

5) Create a second data set with averages of each variable for each activity for each subject.
  - Two for loops are used to iterate over all subjects and activities
  - The average of all the means and standard deviations for a given subject/activity combination are calculated
  - data are stored by format in the files, "average_data.csv" or "average_data.txt"

As previously described ([ref](http://archive.ics.uci.edu/ml/datasets/Smartphone-Based+Recognition+of+Human+Activities+and+Postural+Transitions)), the units are ass followed:

- The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2). 
- The gyroscope units are rad/seg. 

##### Column names in all_data.csv
- subject: number assigned to subjects 1-30
- activity: name of activity performed during the measurement
- acc_x_mean: mean estimated body acceleration in the x direction
- acc_x_sd: standard deviation of measurements on body acceleration in the x direction
- acc_y_mean: mean estimated body acceleration in the y direction
- acc_y_sd: standard deviation of measurements on body acceleration in the y direction
- acc_z_mean: mean estimated body acceleration in the z direction
- acc_z_sd: standard deviation of measurements on body acceleration in the z direction
- gyro_x_mean: mean angular velocity measurement from the gyroscope in the x direction
- gyro_x_sd: standard deviation of angular velocity measurements from the gyroscope in the x direction
- gyro_y_mean: mean angular velocity measurement from the gyroscope in the y direction
- gyro_y_sd: standard deviation of angular velocity measurements from the gyroscope in the y direction
- gyro_z_mean: mean angular velocity measurement from the gyroscope in the z direction
- gyro_z_sd: standard deviation of angular velocity measurements from the gyroscope in the z direction
- total_x_mean: mean of measurements of acceleration in the x direction from the accelerometer
- total_x_sd: standard deviation of measurements of acceleration in the x direction from the accelerometer
- total_y_mean: mean of measurements of acceleration in the y direction from the accelerometer
- total_y_sd: standard deviation of measurements of acceleration in the y direction from the accelerometer
- total_z_mean: mean of measurements of acceleration in the z direction from the accelerometer
- total_z_sd: standard deviation of measurements of acceleration in the z direction from the accelerometer
- set: label indicating origin of data (train or test)

##### Activity names
- LAYING
- SITTING
- STANDING
- WALKING
- WALKING_DOWNSTAIRS
- WALKING_UPSTAIRS

##### Column names in average_data.csv
- subject: number assigned to subjects 1-30
- activity: name of activity performed during the measurement
- ave_acc_x_mean: average of all means of estimated body acceleration measurements in the x direction
- ave_acc_x_sd: average of all standard deviations of estimated body acceleration measurements in the x direction
- ave_acc_y_mean: average of all means of estimated body acceleration measurements in the y direction
- ave_acc_y_sd: average of all standard deviations of estimated body acceleration measurements in the y direction
- ave_acc_z_mean: average of all means of estimated body acceleration measurements in the z direction
- ave_acc_z_sd: average of all standard deviations of estimated body acceleration measurements in the z direction
- ave_gyro_x_mean: average of all means of gyroscope angular momentun measurements in the x direction
- ave_gyro_x_sd: average of all standard deviations of gyroscope angular momentun measurements in the x direction
- ave_gyro_y_mean: average of all means of gyroscope angular momentun measurements in the y direction
- ave_gyro_y_sd: average of all standard deviations of gyroscope angular momentun measurements in the y direction
- ave_gyro_z_mean: average of all means of gyroscope angular momentun measurements in the z direction
- ave_gyro_z_sd: average of all standard deviations of gyroscope angular momentun measurements in the z direction
- ave_total_x_mean: average of all means of accelerometer acceleration measurements in the x direction
- ave_total_x_sd: average of all standard deviations of accelerometer acceleration measurements in the x direction
- ave_total_y_mean: average of all means of accelerometer acceleration measurements in the y direction
- ave_total_y_sd: average of all standard deviations of accelerometer acceleration measurements in the y direction
- ave_total_z_mean: average of all means of accelerometer acceleration measurements in the z direction
- ave_total_z_sd: average of all standard deviations of accelerometer acceleration measurements in the z direction
