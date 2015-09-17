#  run_analysis.R
#  Merges the training and the test sets to create one data set.
#  Extracts only the measurements on the mean and standard deviation for
#      each measurement. 
#  Uses descriptive activity names to name the activities in the data set
#  Appropriately labels the data set with descriptive variable names. 
#  From the data set in step 4, creates a second, independent tidy data set
#       with the average of each variable for each activity and each subject.

#
#  Read in the activity labels
#
dataFileName<-"UCI HAR Dataset/activity_labels.txt"
activityLabels<-read.table(dataFileName, header=FALSE)
class(activityLabels)
names(activityLabels)<-c("activityNumber", "activityLabel")
activityLabels[1,]
activityLabels

#
#  Read in the features, which will be column labels
#
dataFileName<-"UCI HAR Dataset/features.txt"
features<-read.table(dataFileName, header=FALSE)
class(features)
dim(features)      #  561  2

columnNames<-as.character(features[,2])
class(columnNames)


#  Read the training set files
#       Data
trainsetfile="UCI HAR Dataset/train/X_train.txt"
trainset <- read.table(trainsetfile, header=FALSE)
class(trainset)
dim(trainset)           #  7352  561    that is, 7352 rows and 561 columns

#       Labels
trainsetlabelsfile="UCI HAR Dataset/train/y_train.txt"
trainsetlabels <- read.table(trainsetlabelsfile, header=FALSE)
class(trainsetlabels)
dim(trainsetlabels)     #  7352    1

#  Merge the labels in with the data
trainingData<-cbind(trainsetlabels, trainset)

#  Subject data
trainsubjectfile="UCI HAR Dataset/train/subject_train.txt"
trainsubjects <- read.table(trainsubjectfile, header=FALSE)
class(trainsubjects)
dim(trainsubjects)     #  7352    1

#  Add the subject data to the training data set, too
allTrainingData<-cbind(trainsubjects, trainingData)

#  Make the column names descriptive
names(allTrainingData) <- c("subject", "activity", columnNames)
View(allTrainingData)

#  Repeat most of the above process for the test set.
#  Read the test set files
#       Data
testsetfile="UCI HAR Dataset/test/X_test.txt"
testset <- read.table(testsetfile, header=FALSE)
class(testset)
dim(testset)            #  2947  561

#       Labels
testsetlabelsfile="UCI HAR Dataset/test/y_test.txt"
testsetlabels <- read.table(testsetlabelsfile, header=FALSE)
class(testsetlabels)
dim(testsetlabels)      #  2947    1

#  Merge the labels in with the data
testingData<-cbind(testsetlabels, testset)

#  Subject data
testsubjectfile="UCI HAR Dataset/test/subject_test.txt"
testsubjects <- read.table(testsubjectfile, header=FALSE)
class(testsubjects)
dim(testsubjects)       #  2947    1

#  Add the subject data to the training data set, too
allTestingData<-cbind(testsubjects, testingData)

#  Make the column names descriptive
names(allTestingData) <- c("subject", "activity", columnNames)

#  Merge the training and the test sets to create one data set.
allData <- rbind(allTrainingData, allTestingData)
dim(allData)            #  10299   563
View(allData)

#  Extract only the measurements on the mean and standard deviation for
#      each measurement. 

#  Assume that the associate variable names will contain the strings "mean" or "std"
#  Also assume that case doesn't matter (we'll take upper, lower, or mixed case)
matchingColumns <- grep("*[Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]*", names(allData))
meanstdData <- allData[,c(1,2,matchingColumns)]
dim(meanstdData)        #  10299    88

#  Uses descriptive activity names to name the activities in the data set
install.packages("plyr")
library(plyr)
meanstdData <- mutate(meanstdData, activity=activityLabels[activity,2])

#  Appropriately labels the data set with descriptive variable names. 
#  Performed above.

#  From the data set in step 4, creates a second, independent tidy data set
#       with the average of each variable for each activity and each subject.
install.packages("dplyr")
library(dplyr)
groupedMeanStdData <- group_by(meanstdData, subject, activity)
averagedMSD<-summarize_each(groupedMeanStdData, funs(mean))

#  Write out the small tidy data set 
write.table(averagedMSD, file="averagedData.txt", row.name=FALSE)

#  Just to double check, read that back in
doubleCheck <- read.table("averagedData.txt", header=TRUE)
View(doubleCheck)
