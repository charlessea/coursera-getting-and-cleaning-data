library(dplyr)

if (!file.exists('UCI HAR Dataset')){
	download.file(url='http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip', destfile='uci_har_dataset.zip', method='curl')
	unzip('uci_har_dataset.zip')
}


# Get and clean features names from file features.txt to prepare train and test datasets
featuresNames <- read.table("UCI HAR DataSet/features.txt", stringsAsFactors=FALSE)[2][, 1]
featuresIndexes<-grep('.*mean.*|.*std.*', featuresNames)
featuresNames <- gsub('-mean', 'Mean', featuresNames[featuresIndexes])
featuresNames <- gsub('-std', 'Std', featuresNames)
featuresNames <- gsub('[-()]', '', featuresNames)

# Load, clean and prepare train dataset to bind test dataset
train <- read.table("UCI HAR DataSet/train/X_train.txt", stringsAsFactors=FALSE)[featuresIndexes]
colnames(train) <- featuresNames
subjectsTrain <- read.table("UCI HAR DataSet/train/subject_train.txt", stringsAsFactors=FALSE)
colnames(subjectsTrain) <- c("subject")
activitiesTrain <- read.table("UCI HAR DataSet/train/y_train.txt", stringsAsFactors=FALSE)
colnames(activitiesTrain) <- c("activity")
train <- cbind(train, subjectsTrain, activitiesTrain)

# Load, clean and prepare train dataset to bind train dataset
test <- read.table("UCI HAR DataSet/test/X_test.txt", stringsAsFactors=FALSE)[featuresIndexes]
colnames(test) <- featuresNames
subjectsTest <- read.table("UCI HAR DataSet/test/subject_test.txt", stringsAsFactors=FALSE)
colnames(subjectsTest) <- c("subject")
activitiesTest <- read.table("UCI HAR DataSet/test/y_test.txt", stringsAsFactors=FALSE)
colnames(activitiesTest) <- c("activity")
test <- cbind(test, subjectsTest, activitiesTest)

# Put both datasets, train and test, together into only one repository
oneRepository <- rbind(train, test)

# Get and clean activities label from file activity_labels.txt
activityLabel <- read.table("UCI HAR DataSet/activity_labels.txt", stringsAsFactors=FALSE)
colnames(activityLabel) <- c("id", "activity")

# Replace activities codes by activities labels to become activity variable more descriptive
oneRepository$activity <- factor(oneRepository$activity, levels=activityLabel$id, labels=activityLabel$activity)

# Group all data by activity and subject then summarise others columns calculate their means
groupedRepository <- group_by(oneRepository, activity, subject)
tidyData <- summarise_at(groupedRepository, featuresNames, mean)

# Write summarized data into text tidy file 
write.table(tidyData, "UCI HAR DataSet/tidy_repository.txt")