require(plyr)

# Identify relevant features
features <- read.table("./data/features.txt")
mean_indices <- grep("mean\\(\\)", features[, 2])
mean_names <- features[mean_indices, 2]
std_indices <- grep("std\\(\\)", features[, 2])
std_names <- features[std_indices, 2]
activity_names <- read.table("./data/activity_labels.txt", col.names = c("activity_id", "activity_name"))
activity_names <- as.data.frame(activity_names, stringsAsFactors=FALSE)

# Load training data into a dataframe
train <- read.table("./data/train/X_train.txt")
colnames(train) <- features[,2]
train$subject <- readLines("./data/train/subject_train.txt")
train$activity_id <- readLines("./data/train/y_train.txt")

# Load testing data into a dataframe
test <- read.table("./data/test/X_test.txt")
colnames(test) <- features[,2]
test$subject <- readLines("./data/test/subject_test.txt")
test$activity_id <- readLines("./data/test/y_test.txt")

# Merge training and testing data sets
data <- rbind(train, test)
indices_to_keep <- c(mean_indices, std_indices, dim(data)[2] - 1, dim(data)[2])
meanstddata <- data[, indices_to_keep]

# Give descriptive activity names
meanstdactivitydata <- merge(x=meanstddata, y=activity_names, by="activity_id", all.x=TRUE)
meanstdactivitydata$subject <- as.integer(meanstdactivitydata$subject)
meanstdactivitydata$activity_id <- as.integer(meanstdactivitydata$activity_id)

# Function to apply to colmeans and retain non-numeric features
reducingMean <- function(frame)
{
  data <- frame[,-grep("subject|activity_", colnames(frame))]
  data <- colMeans(data)
  suppressWarnings(data$subject <- frame[1, "subject"])
  data$activity_id <- frame[1, "activity_id"]
  data$activity_name <- frame[1, "activity_name"]
  return(data)
}

# Create dataset based on the subject and activity that produces the average of the values
groupColumns <- c("subject", "activity_name", "activity_id")
dataColumns <- colnames(meanstdactivitydata)[-grep("subject|activity_", colnames(meanstdactivitydata))]
average_tidy_dataset <- ddply(meanstdactivitydata, groupColumns, function(x) colMeans(x[dataColumns]))
write.csv(average_tidy_dataset, "average_tidy_dataset.csv", row.names = FALSE)


