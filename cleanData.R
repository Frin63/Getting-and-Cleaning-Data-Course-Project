#
# Read the activity lables
#

activityLabels=read.csv(file="UCI HAR Dataset/activity_labels.txt",sep=" ",
                        header=FALSE)
names(activityLabels)=c("label","name")

#
# Read the feature names
#
featureLabels=read.csv(file="UCI HAR Dataset/features.txt",sep=" ",
                         header=FALSE)
names(featureLabels)=c("label","name")

#
# Read the "Test" data
#
test_X <- read.fwf(file="UCI HAR Dataset/test/X_test.txt",
          widths=rep(16,561),n=3000,buffersize=100)
names(test_X)=featureLabels$name

test_y <- read.csv(file="UCI HAR Dataset/test/y_test.txt",header=FALSE)
names(test_y)="activity"

test_subject <- read.csv(file="UCI HAR Dataset/test/subject_test.txt",header=FALSE)
names(test_subject)="subject"

test=cbind(test_y,test_subject,test_X)

#
# Read the "Train" data
#
train_X <- read.fwf(file="UCI HAR Dataset/train/X_train.txt",
                   widths=rep(16,561),n=8000,buffersize=100)
names(train_X)=featureLabels$name

train_y <- read.csv(file="UCI HAR Dataset/train/y_train.txt",header=FALSE)
names(train_y)="activity"

train_subject <- read.csv(file="UCI HAR Dataset/train/subject_train.txt",header=FALSE)
names(train_subject)="subject"

train=cbind(train_y,train_subject,train_X)

projectData <- rbind(train,test)
rm(train_y,train_X,train_subject,test_y,test_X,test_subject,train,test)

#
# Replace activity numerical code by description
#
projectData$activity=activityLabels$name[projectData$activity]

#
# Retain only the first two columns (activity and subject) and those having 'mean()' or 'std()' in the name
#
wantedCols=c(1,2,grep("mean\\(\\)|std\\(\\)",names(projectData)))

projectData<-projectData[,wantedCols]


#
# Save the result in csv format
#
write.csv(projectData,file="projectData.csv",row.names = FALSE)
