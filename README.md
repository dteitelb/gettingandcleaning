# gettingandcleaning
for Getting and Cleaning Data Course Project
This script downloads and unzips the "Human Activity Recognition Using Smartphones Data Set" found in the UCI Machine Learning Repository at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. A full description of this dataset can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The script reads in the data from the test and train groups, keeping only the variables that are means and standard deviations of the different signals. It then combines the two groups and renames the columns with descriptive titles to create one tidy dataset with subject #s, acitivity types and the mean and standard deviation variables.

Lastly, the script creates a second tidy dataset that provides the average mean and standard deviation for each variable, grouped by activity and subject.
