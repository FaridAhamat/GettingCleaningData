# GettingCleaningData

Requirement:
1. run_analysis.R file should be at the root directory together with the Samsung data such that:
/YourDirectory/run_analysis.R
/YourDirectory/UCI HAR Dataset

2. The script requires two R package (besides the base R package) which is:
	i. 	plyr
	ii.	data.table

Tackling the problem:
Question1:
1. Read all the data from train and test folder.
2. rbind all the measurement data from both train and test folder.
3. cbind the measurement together with the activity and subject data.
4. Create a new table from this data frame.

Question 2:
1. Read features.txt.
2. Find the names which the measurement is of mean and standard deviation. Create logical vector from this.
3. Apply the logical vector into the data created from question 1.

Question 3.
1. Just rename the activity names according to the activity_labels.txt.
2. Hardcoded since there's only so few activity, it's easier than to code it.
Note: Will have to add into script to read from the txt file should there'll be any more activity.

Question 4.
1. Just rename the data set with the variable names. Aesthetic matter, since the predefined column names already explain what each measurement is doing.

Question 5.
1. Create a new table from the data frame created from question 2-4.