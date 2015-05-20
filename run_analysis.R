#Getting and cleaning data
#Project


#Read training data
setwd("D:/PML/UCI HAR Dataset/train")
list.files()
train.X <- read.table("X_train.txt")
train.Subject <- read.table("subject_train.txt")
train.Y <- read.table("y_train.txt")

#Read testing data
setwd("D:/PML/UCI HAR Dataset/test")
list.files()
test.X <- read.table("X_test.txt")
test.Subject <- read.table("subject_test.txt")
test.Y <- read.table("y_test.txt")

#Merges the training and the test sets to create one data set.
Data <- rbind(train.X,test.X)
Label <- rbind(train.Y,test.Y)
Subject <- rbind(train.Subject,test.Subject)

#Extracts only the measurements on the mean and standard deviation for each measurement.
setwd("D:/PML/UCI HAR Dataset")
list.files()
features <- read.table("features.txt")
newvariable <- grep("mean\\(\\)|std\\(\\)", features[, 2])
Data <- Data[,newvariable]

#Uses descriptive activity names to name the activities in the data set
activity <- read.table("activity_labels.txt")
labelVariable <- activity[Label[, 1], 2]
Label[,1]<-labelVariable
names(Label) <- "Activity"

#Appropriately labels the data set with descriptive activity names.
names(Subject) <- "Subject"
compactData <- cbind(Subject, Label, Data)
write.table(compactData, "compactData.txt", row.name=F)

#From the data set in step 4, creates a second, independent tidy data set with
#the average of each variable for each activity and each subject.

cols <- names(compactData)
wrapCols <-gsub("-","",cols)
names(compactData)<-wrapCols
attach(compactData)
meansData <-aggregate(.~Subject+Activity,FUN=mean, na.rm=TRUE, data=compactData)
detach(compactData)
write.table(meansData, "meansData.txt", row.name=F)

