# Getting and Cleaning Data Course Project

##### The goal of this project is to collect and clean a data set.

##### The requirements of the script as stated in the assignment are:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5, From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

My interpretation of step 2 is as follows:

- Measurements refers to the data from the Inertial Signals directories in the Training and Test sets.  
- All other data, that being from the X_train.txt and X-test.txt files are largely derived data, not measurements.
- Although the means and standard deviations of the measurements for body_acc and body_gyro are available and included in the X_train.txt and X-test.txt files, I chose to calculate means and standard deviations since I could not find the average for total_acc measurements.  So there is an additional step of calculating means and standard deviations from each of the 9 measurement files from both the training and test data.

##### Repo contents.
As described in the instructions, there is one script in this repo called <b><i>run_analysis.R</i></b>.  The script does the following:

1. Reads each of the 9 measurement files from each of the 2 datasets (training and test).
2. Calculates means and standard deviations of each measurement.
3. Assigns subject and activity to each measurement, mapping activity names.
4. Combines training and test sets to a single data frame.
5, Renames the variable names.  Saves data as <b><i>all_data.csv</i></b>
6, Create a second data set with averages of each variable for each activity for each subject.  This data is saved in csv and text files named, <b><i>average_data.csv</i></b> and <b><i>average_data.txt</i></b>, respectively.
