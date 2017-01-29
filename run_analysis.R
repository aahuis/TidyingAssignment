#We will need descriptive activity names, so
#read activity labels
activity_labels <- read.table("activity_labels.txt")

#read column names
features <- read.table("features.txt")
names_vector <- as.vector(features$V2)
rm("features")

#read test data set
test_data <- read.table("test/X_test.txt")
#give names to the test data columns
colnames(test_data) <- names_vector

#read the labels of the test data set
test_labels <- read.table("test/y_test.txt")

#read the subjects of the test data set
test_subjects <- read.table("test/subject_test.txt")
#rename the column with the subjects
#as to avoid two columns with the same name
colnames(test_subjects) <- c("Subject")
#append the test subjects to the test data set
test_data <- cbind(test_data,test_subjects)
rm("test_subjects")

#add activities to the test data set
#corresponds to the requirement "Uses descriptive activity names to name the activities 
#in the data set"
temporary_test <- merge(test_labels,activity_labels, by.x="V1", by.y="V1")
colnames(temporary_test) <- c("ActivityNo", "Activity")
test_data <- cbind(test_data, temporary_test)
rm("temporary_test")

#read the training data set
train_data <- read.table("train/X_train.txt")
#give names to the train data columns
colnames(train_data) <- names_vector

#read the labels of the training data set
train_labels <- read.table("train/y_train.txt")

#read the subjects of the train data set
train_subjects <- read.table("train/subject_train.txt")
#read the labels of the activity numbers
#rename the column with the subjects
#as to avoid two columns with the same name
colnames(train_subjects) <- c("Subject")
#append the test subjects to the test data set
train_data <- cbind(train_data,train_subjects)
rm("train_subjects")

#add activities to the train data set
#corresponds to the requirement "Uses descriptive activity names to name the activities 
#in the data set"
temporary_train <- merge(train_labels,activity_labels, by.x="V1", by.y="V1")
colnames(temporary_train) <- c("ActivityNo", "Activity")
train_data <- cbind(train_data, temporary_train)
rm("temporary_train")
rm("activity_labels")

#update the contents of the names vector with the subject and activity columns
names_vector <- c(names_vector,"Subject", "ActivityNo", "Activity")

#merge the training and the testing data set
##corresponds to the requirement "Merges the training and the test sets to create one data set."
data_set <- rbind(test_data, train_data)
rm("test_data")
rm("train_data")
rm("test_labels")
rm("train_labels")

#find the mean and standard deviation variables based on the names of the columns
mean_indexes <- grep("mean", names_vector)
std_indexes <- grep("std", names_vector)
act_indexes <- grep("Activity", names_vector)
sub_indexes <- grep("Subject", names_vector)
#all columns containing mean, std, activity and subject
indexes <- sort(c(mean_indexes, std_indexes, act_indexes, sub_indexes))
rm("mean_indexes")
rm("std_indexes")
rm("act_indexes")
rm("sub_indexes")

#Extracts only the measurements on the mean and standard deviation for each measurement.
#it isn't extremely clear whether to keep or not the X,Y,Z values
smaller_data_set <- data_set[,indexes]
#if we were to ignore als X, Y, Z values: smaller_data_set <- select(smaller_data_set,31:40,68:82)
#names of the columns
less_names <- colnames(smaller_data_set)
rm("indexes")
rm("data_set")
rm("names_vector")

#process column names
processed_names <- gsub("\\-mean","_MEAN", less_names)
processed_names <- gsub("\\-std","_STD", processed_names)
processed_names <- gsub("\\(\\)","", processed_names)
processed_names <- gsub("\\-X","_X", processed_names)
processed_names <- gsub("\\-Y","_Y", processed_names)
processed_names <- gsub("\\-Z","_Z", processed_names)

#corresponds to the requirement 
#"Appropriately labels the data set with descriptive variable names."
colnames(smaller_data_set) <- processed_names

#From the data set creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
#automatically produce the new variables as argument for summarize function
sir <- "tBodyAcc_MEAN_X=mean(tBodyAcc_MEAN_X)"
for (i in 2:79) sir <- paste(sir,",",processed_names[i],"=mean(",processed_names[i],")")
write.csv(sir,"myargument.txt")
#finally the new data set
new_set <- smaller_data_set %>% group_by(Subject,Activity) %>% summarise(tBodyAcc_MEAN_X=mean(tBodyAcc_MEAN_X) , tBodyAcc_MEAN_Y =mean( tBodyAcc_MEAN_Y ) , tBodyAcc_MEAN_Z =mean( tBodyAcc_MEAN_Z ) , tBodyAcc_STD_X =mean( tBodyAcc_STD_X ) , tBodyAcc_STD_Y =mean( tBodyAcc_STD_Y ) , tBodyAcc_STD_Z =mean( tBodyAcc_STD_Z ) , tGravityAcc_MEAN_X =mean( tGravityAcc_MEAN_X ) , tGravityAcc_MEAN_Y =mean( tGravityAcc_MEAN_Y ) , tGravityAcc_MEAN_Z =mean( tGravityAcc_MEAN_Z ) , tGravityAcc_STD_X =mean( tGravityAcc_STD_X ) , tGravityAcc_STD_Y =mean( tGravityAcc_STD_Y ) , tGravityAcc_STD_Z =mean( tGravityAcc_STD_Z ) , tBodyAccJerk_MEAN_X =mean( tBodyAccJerk_MEAN_X ) , tBodyAccJerk_MEAN_Y =mean( tBodyAccJerk_MEAN_Y ) , tBodyAccJerk_MEAN_Z =mean( tBodyAccJerk_MEAN_Z ) , tBodyAccJerk_STD_X =mean( tBodyAccJerk_STD_X ) , tBodyAccJerk_STD_Y =mean( tBodyAccJerk_STD_Y ) , tBodyAccJerk_STD_Z =mean( tBodyAccJerk_STD_Z ) , tBodyGyro_MEAN_X =mean( tBodyGyro_MEAN_X ) , tBodyGyro_MEAN_Y =mean( tBodyGyro_MEAN_Y ) , tBodyGyro_MEAN_Z =mean( tBodyGyro_MEAN_Z ) , tBodyGyro_STD_X =mean( tBodyGyro_STD_X ) , tBodyGyro_STD_Y =mean( tBodyGyro_STD_Y ) , tBodyGyro_STD_Z =mean( tBodyGyro_STD_Z ) , tBodyGyroJerk_MEAN_X =mean( tBodyGyroJerk_MEAN_X ) , tBodyGyroJerk_MEAN_Y =mean( tBodyGyroJerk_MEAN_Y ) , tBodyGyroJerk_MEAN_Z =mean( tBodyGyroJerk_MEAN_Z ) , tBodyGyroJerk_STD_X =mean( tBodyGyroJerk_STD_X ) , tBodyGyroJerk_STD_Y =mean( tBodyGyroJerk_STD_Y ) , tBodyGyroJerk_STD_Z =mean( tBodyGyroJerk_STD_Z ) , tBodyAccMag_MEAN =mean( tBodyAccMag_MEAN ) , tBodyAccMag_STD =mean( tBodyAccMag_STD ) , tGravityAccMag_MEAN =mean( tGravityAccMag_MEAN ) , tGravityAccMag_STD =mean( tGravityAccMag_STD ) , tBodyAccJerkMag_MEAN =mean( tBodyAccJerkMag_MEAN ) , tBodyAccJerkMag_STD =mean( tBodyAccJerkMag_STD ) , tBodyGyroMag_MEAN =mean( tBodyGyroMag_MEAN ) , tBodyGyroMag_STD =mean( tBodyGyroMag_STD ) , tBodyGyroJerkMag_MEAN =mean( tBodyGyroJerkMag_MEAN ) , tBodyGyroJerkMag_STD =mean( tBodyGyroJerkMag_STD ) , fBodyAcc_MEAN_X =mean( fBodyAcc_MEAN_X ) , fBodyAcc_MEAN_Y =mean( fBodyAcc_MEAN_Y ) , fBodyAcc_MEAN_Z =mean( fBodyAcc_MEAN_Z ) , fBodyAcc_STD_X =mean( fBodyAcc_STD_X ) , fBodyAcc_STD_Y =mean( fBodyAcc_STD_Y ) , fBodyAcc_STD_Z =mean( fBodyAcc_STD_Z ) , fBodyAcc_MEANFreq_X =mean( fBodyAcc_MEANFreq_X ) , fBodyAcc_MEANFreq_Y =mean( fBodyAcc_MEANFreq_Y ) , fBodyAcc_MEANFreq_Z =mean( fBodyAcc_MEANFreq_Z ) , fBodyAccJerk_MEAN_X =mean( fBodyAccJerk_MEAN_X ) , fBodyAccJerk_MEAN_Y =mean( fBodyAccJerk_MEAN_Y ) , fBodyAccJerk_MEAN_Z =mean( fBodyAccJerk_MEAN_Z ) , fBodyAccJerk_STD_X =mean( fBodyAccJerk_STD_X ) , fBodyAccJerk_STD_Y =mean( fBodyAccJerk_STD_Y ) , fBodyAccJerk_STD_Z =mean( fBodyAccJerk_STD_Z ) , fBodyAccJerk_MEANFreq_X =mean( fBodyAccJerk_MEANFreq_X ) , fBodyAccJerk_MEANFreq_Y =mean( fBodyAccJerk_MEANFreq_Y ) , fBodyAccJerk_MEANFreq_Z =mean( fBodyAccJerk_MEANFreq_Z ) , fBodyGyro_MEAN_X =mean( fBodyGyro_MEAN_X ) , fBodyGyro_MEAN_Y =mean( fBodyGyro_MEAN_Y ) , fBodyGyro_MEAN_Z =mean( fBodyGyro_MEAN_Z ) , fBodyGyro_STD_X =mean( fBodyGyro_STD_X ) , fBodyGyro_STD_Y =mean( fBodyGyro_STD_Y ) , fBodyGyro_STD_Z =mean( fBodyGyro_STD_Z ) , fBodyGyro_MEANFreq_X =mean( fBodyGyro_MEANFreq_X ) , fBodyGyro_MEANFreq_Y =mean( fBodyGyro_MEANFreq_Y ) , fBodyGyro_MEANFreq_Z =mean( fBodyGyro_MEANFreq_Z ) , fBodyAccMag_MEAN =mean( fBodyAccMag_MEAN ) , fBodyAccMag_STD =mean( fBodyAccMag_STD ) , fBodyAccMag_MEANFreq =mean( fBodyAccMag_MEANFreq ) , fBodyBodyAccJerkMag_MEAN =mean( fBodyBodyAccJerkMag_MEAN ) , fBodyBodyAccJerkMag_STD =mean( fBodyBodyAccJerkMag_STD ) , fBodyBodyAccJerkMag_MEANFreq =mean( fBodyBodyAccJerkMag_MEANFreq ) , fBodyBodyGyroMag_MEAN =mean( fBodyBodyGyroMag_MEAN ) , fBodyBodyGyroMag_STD =mean( fBodyBodyGyroMag_STD ) , fBodyBodyGyroMag_MEANFreq =mean( fBodyBodyGyroMag_MEANFreq ) , fBodyBodyGyroJerkMag_MEAN =mean( fBodyBodyGyroJerkMag_MEAN ) , fBodyBodyGyroJerkMag_STD =mean( fBodyBodyGyroJerkMag_STD ) , fBodyBodyGyroJerkMag_MEANFreq =mean( fBodyBodyGyroJerkMag_MEANFreq ))

library(tidyr)
library(dplyr)
#reorder the column order in the set
new_set <- new_set[,c(1,2,3,6,9,12,15,18,21,24,27,30,43,46,49,52,55,58,61,64,67,4,7,10,13,16,19,22,25,28,31,44,47,50,53,56,59,62,65,68,5,8,11,14,17,20,23,26,29,32,45,48,51,54,57,60,63,66,69,33,34,35,36,37,38,39,40,41,42,70,71,72,73,74,75,76,77,78,79,80,81)]
#transform most of the column names to data in one column, descr
changed_set <- gather(new_set,descr,measure,3:81)
#create column for X,Y,Z or all of them
changed_set$dimension <- 'ALL'
changed_set[grep('X',changed_set$descr),]$dimension <- 'X'
changed_set[grep('Y',changed_set$descr),]$dimension <- 'Y'
changed_set[grep('Z',changed_set$descr),]$dimension <- 'Z'
#describe whether measure is a mean or an std value in the original data set
changed_set$type_computation <- ''
changed_set[grep('MEAN',changed_set$descr),]$type_computation <- 'MEAN'
changed_set[grep('STD',changed_set$descr),]$type_computation <- 'STD'
#as X,Y,Z and MEAN/STD have been dealt with, get rid of them from the description
changed_set$descr <- gsub("_X","",changed_set$descr)
changed_set$descr <- gsub("_Y","",changed_set$descr)
changed_set$descr <- gsub("_Z","",changed_set$descr)
changed_set$descr <- gsub("_MEAN","",changed_set$descr)
changed_set$descr <- gsub("_STD","",changed_set$descr)
#create column for t=time, f=Fourier frequency domain signals
changed_set$typetime <- ''
changed_set$typetime <- substr(changed_set$descr,1,1)
#make a difference between Gyro and Acc
changed_set$type_measure <- ''
changed_set[grep('Gyro',changed_set$descr),]$type_measure <- 'Gyro'
changed_set$descr <- gsub("Gyro","",changed_set$descr)
changed_set[grep('Acc',changed_set$descr),]$type_measure <- 'Acc'
changed_set$descr <- gsub("Acc","",changed_set$descr)
#body versus gravity measurement
changed_set$body_vs_gravity <- ''
changed_set[grep('Body',changed_set$descr),]$body_vs_gravity <- 'B'
changed_set[grep('Gravity',changed_set$descr),]$body_vs_gravity <- 'G'
changed_set$descr <- gsub("Body","",changed_set$descr)
changed_set$descr <- gsub("Gravity","",changed_set$descr)
#magnitude value 
changed_set$mag <- 'FALSE'
changed_set[grep('Mag',changed_set$descr),]$mag <- 'TRUE'
changed_set$descr <- gsub("Mag","",changed_set$descr)
#jerk signals
changed_set$jerk <- 'FALSE'
changed_set[grep('Jerk',changed_set$descr),]$jerk <- 'TRUE'
changed_set$descr <- gsub("Jerk","",changed_set$descr)
#frequency values
changed_set$freq <- 'FALSE'
changed_set[grep('Freq',changed_set$descr),]$freq <- 'TRUE'
changed_set$descr <- gsub("Freq","",changed_set$descr)
#get rif od descr since it's not bringing additional information any longer
changed_set$descr <- NULL

#write the tidy data set to file on disk
write.table(changed_set,"tidy_dataset.txt",row.name=FALSE)
