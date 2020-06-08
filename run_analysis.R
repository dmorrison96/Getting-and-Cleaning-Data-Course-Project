# Get the data

library(data.table)
fileURL = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./UCI HAR Dataset.zip')){
  download.file(fileURL,'./UCI HAR Dataset.zip', mode = 'curl')
  unzip("UCI HAR Dataset.zip", exdir = getwd())
}

features <- read.table('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
features <- as.character(features[,2])

train_x <- read.table('./UCI HAR Dataset/train/X_train.txt')
train_activity <- read.table('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
train_subject <- read.table('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')

train <-  data.frame(train_subject, train_activity, train_x)
names(train) <- c(c('subject', 'activity'), features)

test_x <- read.table('./UCI HAR Dataset/test/X_test.txt')
test_activity <- read.table('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
test_subject <- read.table('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')

test <-  data.frame(test_subject, test_activity, test_x)
names(test) <- c(c('subject', 'activity'), features)

# 1 - Merge training and test data to create one dataset

all <- rbind(train, test)

# 2 - Extract only the measurements on the mean and standard deviation for each measurement

mean_std <- grep('mean|std', features)
sub <- all[,c(1,2,mean_std+ 2)]

# 3 - Uses descriptive activity names to name the activities in the dataset

activity.labels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
activity.labels <- as.character(activity.labels[,2])
sub$activity <- activity.labels[sub$activity]

# 4 - Appropriately labels the dataset with descriptive variable names

name.new <- names(data.sub)
name.new <- gsub("[(][)]", "", name.new)
name.new <- gsub("^t", "Time", name.new)
name.new <- gsub("tBody", "TimeBody", name.new)
name.new <- gsub("^f", "Frequency", name.new)
name.new <- gsub("Acc", "Accelerometer", name.new)
name.new <- gsub("Gyro", "Gyroscope", name.new)
name.new <- gsub("Mag", "Magnitude", name.new)
name.new <- gsub("-mean-", "Mean", name.new)
name.new <- gsub("-std-", "StandardDeviation", name.new)
name.new <- gsub("BodyBody", "Body", name.new)
name.new <- gsub("-", "_", name.new)
names(data.sub) <- name.new

# 5 - Create a second, clean dataset with the average of each variable for each activity and each subject.

data.tidy <- aggregate(data.sub[,3:81], by = list(activity = data.sub$activity, subject = data.sub$subject),FUN = mean)
write.table(x = data.tidy, file = "tidy_data.txt", row.names = FALSE)


