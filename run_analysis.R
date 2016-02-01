#This assumes the current directory is where you want to work. Otherwise use lines 2-4.
#fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileurl, destfile="courseProject.zip")
#unzip("courseProject.zip")
#The next six lines bing in the various pieces of information needed to create the full
#dataset.
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
activity_train<-read.table("UCI HAR Dataset/train/y_train.txt")
activity_test<-read.table("UCI HAR Dataset/test/y_test.txt")
data_train<-read.table("UCI HAR Dataset/train/x_train.txt")
data_test<-read.table("UCI HAR Dataset/test/x_test.txt")

#This loads in the list of all the data column names.
features<-read.table("UCI HAR Dataset/features.txt")

#This loads in a reference vector of the activity types.
activity_index<-read.table("UCI HAR Dataset/activity_labels.txt")

#This creates a vector of the full subject list to match the full data in x.
subject_traintest<-as.vector(rbind(subject_train, subject_test))

#This line combines all of the activity descriptors into a single vector.
activity_traintest<-as.vector(rbind(activity_train, activity_test))
#Task 3: This turns all of the activity numbers into activity descriptors. 
activity <- sapply(activity_traintest, function(x){activity_index$V2[x]})
#This turns all the activity descriptors into factors.
activity_factor<-factor(activity, levels=activity_index$V2)

#This is a vector that describes each row as belonging to either the test or train group.
train<-rep("train", nrow(activity_train))
test<-rep("test", nrow(activity_test))
traintest<-c(train, test)
#This turns the vector into a factor.
traintest_factor<-factor(traintest)

#The next few lines find the column indicies of all variables that include the text
#mean or std. To be used in extracting mean and std data from full data set.
mean<-grep("mean",features$V2)
std<-grep("std",features$V2)
column_index<-sort(c(mean,std))

#This creates a giant matrix containing all of the data.
data_traintest<-rbind(data_train, data_test)


#Task 1- This creates a data frame of all the data with row descriptors of 
#subject, activity and test/train descriptor.
total_data<-as.data.frame(cbind(subject_traintest,activity_factor,traintest_factor,data_traintest))
#Creates columns names.
#Task 4- Descriptive names for each column.
colnames(total_data)<-c("subject", "activity","test_or_train", as.character(features$V2))

#Task 2 Creates a data subset that only includes mean and std data. 
subset_data<-as.data.frame(cbind(subject_traintest,activity_factor,traintest_factor,data_traintest[,column_index]))
#Task 4- Creates columns names, uses a subset of the full features list for mean and std
colnames(subset_data)<-c("subject", "activity","test_or_train", as.character(features$V2[column_index]))


#This creates a series of variables to summarize the data.
l<-list(subset_data$subject, subset_data$activity, subset_data$test_or_train)
#This takes the mean according to subject and activity levels. The data is then organized
#by activity and train/test group.
mean_values_raw<-aggregate(subset_data, l, mean)
#a actually has three redundant rows that show up as NA after the mean function. This subsets the matrix.
mean_values_subject_activity<-mean_values_raw[,c(1:3,7:length(mean_values_raw))]
#This renames the rows with the description text.
colnames(mean_values_subject_activity)<-c("subject", "activity","test_or_train",as.character(features$V2[column_index]))
#Task 5- Orders data by subject first, followed by activity. Test/train grouping is also maintained.
Final_subset_mean<-mean_values_subject_activity[order(mean_values_subject_activity$subject, mean_values_subject_activity$activity),]
write.table(Final_subset_mean, file = "getcleandataproject_DLO.txt", row.name=FALSE)
