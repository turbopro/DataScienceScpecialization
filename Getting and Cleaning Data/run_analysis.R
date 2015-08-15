setwd("/home/benybrahim/Bureau/UCI HAR Dataset")

# names of features X and labels of y levels
features <- read.table("features.txt",stringsAsFactors = F)[,2]
activity.labels <- read.table("activity_labels.txt",stringsAsFactors = F)[,2]


# importing testing set
X.test <- read.table("test/X_test.txt",col.names = features) 
y.test <- factor(read.table("test/y_test.txt")[,1],labels = activity.labels)
subject.test <- read.table("test/subject_test.txt", col.names = "subject") 


# importing training set
X.train <- read.table("train/X_train.txt",col.names = features) 
y.train <- factor(read.table("train/y_train.txt")[,1],labels = activity.labels)
subject.train <- read.table("train/subject_train.txt", col.names = "subject") 

# merging the two datasets
test <- cbind(subject.test,y.test,X.test)
train <- cbind(subject.train,y.train,X.train)

# Merge the two datasets and arrange by subject
library("plyr")
test <- rename(test,activity = y.test)
train <- rename(train,activity = y.train)
dataset <- arrange(rbind(test,train),subject)

# Computing mean of measurements for each subject and each activity (only mean and std)
library("dplyr")
Final.dataset <- dataset %>%
        # selecting only the mean and std columns (also subject and activity)
        select(subject:tBodyAcc.std...Z,
               tGravityAcc.mean...X:tGravityAcc.std...Z,
               tBodyAccJerk.mean...X:tBodyAccJerk.std...Z) %>% 
        # getting the mean for each subject and activity
        group_by(subject,activity) %>%
        summarise(tBodyAcc.mean...X= mean(tBodyAcc.mean...X,na.rm=T),
                  tBodyAcc.mean...Y= mean(tBodyAcc.mean...Y,na.rm=T),
                  tBodyAcc.mean...Z= mean(tBodyAcc.mean...Z,na.rm=T),
                  tBodyAcc.std...X= mean(tBodyAcc.std...X,na.rm=T),
                  tBodyAcc.std...Y= mean(tBodyAcc.std...Y,na.rm=T),
                  tBodyAcc.std...Z= mean(tBodyAcc.std...Z,na.rm=T),
                  tGravityAcc.mean...X= mean(tGravityAcc.mean...X,na.rm=T),
                  tGravityAcc.mean...Y= mean(tGravityAcc.mean...Y,na.rm=T),
                  tGravityAcc.mean...Z= mean(tGravityAcc.mean...Z,na.rm=T),
                  tGravityAcc.std...X= mean(tGravityAcc.std...X,na.rm=T),
                  tGravityAcc.std...Y= mean(tGravityAcc.std...Y,na.rm=T),
                  tGravityAcc.std...Z= mean(tGravityAcc.std...Z,na.rm=T),
                  tBodyAccJerk.mean...X= mean(tBodyAccJerk.mean...X,na.rm=T),
                  tBodyAccJerk.mean...Y= mean(tBodyAccJerk.mean...Y,na.rm=T),
                  tBodyAccJerk.mean...Z= mean(tBodyAccJerk.mean...Z,na.rm=T),
                  tBodyAccJerk.std...X= mean(tBodyAccJerk.std...X,na.rm=T),
                  tBodyAccJerk.std...Y= mean(tBodyAccJerk.std...Y,na.rm=T),
                  tBodyAccJerk.std...Z= mean(tBodyAccJerk.std...Z,na.rm=T)
        )
