## 1.Merges the training and the test sets to create one data set.
setwd("C:\\johnhopkin\\class3\\week4")
traindata <- read.table("UCI\\train\\X_train.txt",header = FALSE)
testdata <- read.table("UCI\\test\\X_test.txt",header = FALSE)

##2.Extracts only the measurements on the mean and standard
## deviation for each measurement.
## loading features and activity labels 
fetdata <- read.table("UCI\\features.txt",header = FALSE)
fetdata[,2] <- as.character(fetdata[,2])
actlabels <- read.table("UCI\\activity_labels.txt",header = FALSE)
actlabels <- as.character(actlabels[,2])

features <- grep(".*mean.*|.*std.*",fetdata[,2])
features.names <-fetdata[features,]
features.names[,2] = gsub("-mean","Mean",features.names[,2])
features.names[,2] = gsub("-std","Std",features.names[,2])
features.names[,2] = gsub("[-()]","",features.names[,2])

traindata <- traindata[,features.names[,1]]
testdata <- testdata[,features.names[,1]]

##3. Uses descriptive activity names to name the activities in the data set
trainactivity <-read.table("UCI\\train\\y_train.txt")
trainsubject <-read.table("UCI\\train\\subject_train.txt")
traindata <-cbind(trainactivity,trainsubject,traindata)

testactivity <-read.table("UCI\\test\\y_test.txt")
testsubject <-read.table("UCI\\test\\subject_test.txt")
testdata <-cbind(testactivity,testsubject,testdata)

##4. Appropriately labels the data set with descriptive variable names
finaldata <- rbind(traindata,testdata)
colnames(finaldata) <-c("Activity","Subject",features.names[,2])

##5. From the data set in step 4, creates a second, independent
##tidy data set with the average of each variable for each 
##activity and each subject.
tidydata <- aggregate(finaldata[,c(3:81)],by=list(Activity=finaldata$Activity,Subject=finaldata$Subject),FUN=mean)

