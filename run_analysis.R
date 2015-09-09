#############
###  getting and cleaning data
###  course project 
###########################


install.packages("dplyr") #install dplyr
library(dplyr)

#download files
setwd("~/2014-09-10_FETP/Libros y cursos/coursera/3.getting and cleaning data")
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "dataproyect.zip")
unzip("dataproyect.zip")
list.files()


##open names, train and test data files

#open variable names
setwd("~/2014-09-10_FETP/Libros y cursos/coursera/3.getting and cleaning data/UCI HAR Dataset")
list.files()
names<-read.table("features.txt") 
glimpse(names)
#open test set
setwd("~/2014-09-10_FETP/Libros y cursos/coursera/3.getting and cleaning data/UCI HAR Dataset/test")
list.files()
test<-read.table("X_test.txt") 
glimpse(test)
#open train set
setwd("~/2014-09-10_FETP/Libros y cursos/coursera/3.getting and cleaning data/UCI HAR Dataset/train")
list.files()
train<-read.table("X_train.txt") 
glimpse(train)




############################################################
###  1. merge train and test data and add variables names
############################################################
tt<-rbind(train, test)#10299 observarions, equivalent to 2947+7352
glimpse(tt)

### modify variables names
aa<-names[,2]
bb<-as.character(aa)
bb
cc<-gsub(",", "", bb)
dd<-gsub("-", "", cc)
ee<-gsub(")", "", dd)
ff<-gsub("\\(", "", ee)
ff
colnames(tt)<-ff #add variables names
names(tt)
TT <- tbl_df(tt)
glimpse(tt)
class(tt)



###############################################################################################
###  2. Extracts only the measurements on the mean and standard deviation for each measurement.
##############################################################################################
valid_column_names <- make.names(names=names(tt), unique=TRUE, allow_ = TRUE) #eliminate duplicates
names(tt) <- valid_column_names
meanstd<-select(tt, contains("mean"), contains("std")) #choose on variables sith the mean or standard deviation
names(meanstd)



##############################################################################
###  3. Uses descriptive activity names to name the activities in the data set
################################################################################
#open test set
setwd("~/2014-09-10_FETP/Libros y cursos/coursera/3.getting and cleaning data/UCI HAR Dataset/test")
list.files()
y_test<-read.table("y_test.txt")
table(y_test$V1)
#open train test
setwd("~/2014-09-10_FETP/Libros y cursos/coursera/3.getting and cleaning data/UCI HAR Dataset/train")
list.files()
y_train<-read.table("y_train.txt")
#join test and train set
activity<-rbind(y_train, y_test)
names(activity)
#create a factor variable of activities
activity$activity[activity$V1==1]<-"walking"
activity$activity[activity$V1==2]<-"walking upstairs"
activity$activity[activity$V1==3]<-"walking downstairs"
activity$activity[activity$V1==4]<-"walking sitting"
activity$activity[activity$V1==5]<-"walking standing"
activity$activity[activity$V1==6]<-"walking laying"
table(activity$activity, activity$V1)
activity<-activity %>% select(activity)
activity<-as.factor(activity$activity)
meanstd2<-cbind(activity, meanstd) #join activities with data base
glimpse(meanstd2)



#########################################################################
###  4. Appropriately labels the data set with descriptive variable names
###################################################################
#modify col names
aa<-sub("tBody", "TimeBody", names(meanstd2)) #modify names
bb<-sub("tGravity", "TimeGravity", aa)
cc<-sub("fBody", "FrequencyBody", bb)
dd<-sub("Acc", "Accelerometer", cc)
ee<-sub("mean", "Mean", dd)
ff<-sub("Gyro", "Gyroscpe", ee)
gg<-sub("angle", "Angle", ff)
hh<-sub("gravity", "Gravity", gg)
ii<-sub("std", "STD", hh)
colnames(meanstd2)<-ii #rename the database



##############################################################################################
###  5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##############################################################################################
#unir el subject id

#open test set
setwd("~/2014-09-10_FETP/Libros y cursos/coursera/3.getting and cleaning data/UCI HAR Dataset/test")
list.files()
subject_test<-read.table("subject_test.txt")
#open train test
setwd("~/2014-09-10_FETP/Libros y cursos/coursera/3.getting and cleaning data/UCI HAR Dataset/train")
list.files()
subject_train<-read.table("subject_train.txt")
#join test and train set
subject<-rbind(subject_train, subject_test)
names(subject)
subject<-subject %>% rename(subjectID=V1) #name variable
meanstd3<-cbind(subject, meanstd2) #join subject id with database
glimpse(meanstd3)
table(meanstd3$subjectID, meanstd3$activity)
summary<-meanstd3 %>% group_by(subjectID, activity) %>% summarise_each(funs(mean)) #average of each variable for each activity and each subject
glimpse(summary)
setwd("~/2014-09-10_FETP/Libros y cursos/coursera/3.getting and cleaning data/Project")
write.table(summary, file="summary mean and std from UCI HAR Dataset.txt", row.names = F)


################
### THE END
##############