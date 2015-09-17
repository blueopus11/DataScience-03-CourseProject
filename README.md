DataScience-03-CourseProject
----------------------------
Coursera Data Science Class 3:  Getting and Cleaning Data
Course Project

I would normally put author contact info here, but wish to remain
anonymous for this project.

Purpose
-------
The purpose of this project is to demonstrate the ability to collect, work 
with, and clean a data set. The goal is to prepare tidy data that can be 
used for later analysis. The following is what has been submitted for this
project:

1.  a tidy data set as described below, 
2.  a link to a Github repository 
3.  a script, called run_analysis.R, for performing the analysis, 
4.  a code book called CodeBook.md that describes the variables, the data, and  
                transformations performed to clean up 
                the data
5.  this README.md  

The original data to be tidied is data collected 
from the accelerometers from the Samsung Galaxy S smartphone. A full description 
is available at the site where the data was obtained: 
        
    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 
        
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

run_analysis.R does the following: 

1.  Merges the training and the test sets to create one data set.
2.  Extracts only the measurements on the mean and standard deviation for 
    each measurement. 
3.  Uses descriptive activity names to name the activities in the data set
4.  Appropriately labels the data set with descriptive variable names. 
5.  Creates a second, independent tidy data set with the average of each 
    variable for each activity and each subject.

run_analysis.R accomplishes the above as follows:

1.  Reading and merging data
  1.  Read in the activity labels and the features/column labels, so as to 
        provide info to label data in a human-friendly way.
  2.  Read in the training set, the associated label file, and the subject 
        information, and merge all of these together.
  3.  Do the same with the test set
  4.  Merge the results of b and c using rbind.  Now we have the training
        set and the test set merged together with appropriate labeling, which
        makes it more interpretable for humans.     
2.  Extract only the columns onf data that contain the strings "mean" and "std".
    The strings can be any combination of upper and lower case letters.
3.  Item 3 was done in conjunction with step 1, above, because doing it early
    just made the data more understandable during the first step.
4.  I just maintained the original variable names, because the final data set
    is explicitly documented as "averages", and I did not want to lose the context
    original data sets.
5.  Groups the large merged data set by subject and activity, and then averages
    based on the grouping.  This is the final, target data set, which is written
    out to "averagedData.txt".  See CodeBook.md for details of the fields
    associated with this data set.
  
The codebook can be found in this repo at:  <https://github.com/blueopus11/DataScience-03-CourseProject/blob/master/CodeBook.md>


