# Download the original data
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "zipdata", method = "curl")

# Read the relevant data in data frames
features <- read.table(unz("zipdata", "UCI HAR Dataset/features.txt"))
activities <- read.table(unz("zipdata", "UCI HAR Dataset/activity_labels.txt"))

X_train <- read.table(unz("zipdata", "UCI HAR Dataset/train/X_train.txt"))
y_train <- read.table(unz("zipdata", "UCI HAR Dataset/train/y_train.txt"))
subject.train <- read.table(unz("zipdata", "UCI HAR Dataset/train/subject_train.txt"))

X_test <- read.table(unz("zipdata", "UCI HAR Dataset/test/X_test.txt"))
y_test <- read.table(unz("zipdata", "UCI HAR Dataset/test/y_test.txt"))
subject.test <- read.table(unz("zipdata", "UCI HAR Dataset/test/subject_test.txt"))
closeAllConnections()

# Concatenate the test and the train data
X <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject.train, subject.test)

# The names of the variables of the X data frame is taken from the
# feature data frame
names(X) <- features$V2

# Only the mean and the standard deriviation is of interest.
# The criterium is that the variable name contains either
# std() or mean(). The brackets are included to avoid accidental
# matches with variable name parts.
data <- X[, grep("(std|mean)\\(\\)", names(X))]

# The activities are stored in the data fram y. Replace with meaningful
# name (taken from dataframe activities) and add as new colums to the
# data
yActivities <- merge(y, activities, by = "V1")
names(yActivities) <- c("V1", "activity")
data <- cbind(yActivities$activity, data)

# Add the subject as new column to the data
data <- cbind(subject, data)

# Transform from wide to long data form
library(reshape2)
dataLong <- melt(data, c("V1", "yActivities$activity"))

# Give better names to variable
names(dataLong) <- c("subject", "activity", "measure", "value")

# Calculate mean per subject and activity
dataMean <- dcast(dataLong, subject + activity ~ measure, fun.aggregate = mean)

# Convert to long data form
dataMeanLong <- melt(dataMean, c("subject", "activity"))

# Write tidy data to file
write.table(dataMeanLong, "tidy_data.txt", row.name = FALSE)