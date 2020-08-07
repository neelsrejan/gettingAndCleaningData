run_analysis <- function() {
    library(dplyr)
    fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileurl, destfile = "./course3coursera-R", method = "curl")
    unzip("./course3coursera-R")
    #combine files in zip folder into one dataframe called data
    activity_labels <- read.table("./UCI\ HAR\ Dataset/activity_labels.txt", col.names = c("label", "activity"))
    features <- read.table("./UCI\ HAR\ Dataset/features.txt", col.names = c("col_num", "features"))
    
    x_train <- read.table("./UCI\ HAR\ Dataset/train/X_train.txt", col.names = features$features)
    y_train <- read.table("./UCI\ HAR\ Dataset/train/y_train.txt", col.names = c("label"))
    subject_train <- read.table("./UCI\ HAR\ Dataset/train/subject_train.txt", col.names = c("person"))
    
    x_test <- read.table("./UCI\ HAR\ Dataset/test/X_test.txt", col.names = features$features)
    y_test <- read.table("./UCI\ HAR\ Dataset/test/y_test.txt", col.names = c("label"))
    subject_test <- read.table("./UCI\ HAR\ Dataset/test/subject_test.txt", col.names = c("person"))
    
    x_combined <- rbind(x_train, x_test)
    y_combined <- rbind(y_train, y_test)
    subject_combined <- rbind(subject_train, subject_test)
    
    data <- cbind(subject_combined, y_combined, x_combined)
    
    #take out columns that only have the mean and std information
    data_mean_std <- select(data, person, label, contains("mean"), contains("std"))
    
    #take the numeric labels and change them to the word description 
    #as seen from the activity_labels data we loaded in.
    data_mean_std$label <- activity_labels[data_mean_std$label, 2]
    
    #give column names more meaningful names
    names(data_mean_std) <- gsub("^t", "Time", names(data_mean_std))
    names(data_mean_std) <- gsub("Acc", "Acceleration", names(data_mean_std))
    names(data_mean_std) <- gsub("-mean()", "Mean", names(data_mean_std))
    names(data_mean_std) <- gsub("-std()", "Std", names(data_mean_std))
    names(data_mean_std) <- gsub("Gyro", "Gyroscope", names(data_mean_std))
    names(data_mean_std) <- gsub("Mag", "Magnitude", names(data_mean_std))
    names(data_mean_std) <- gsub("^f", "Frequency", names(data_mean_std))
    
    #clean data frame with average of each variable from each label and subject
    clean_data <- data_mean_std %>% group_by(person, label) %>% summarize(across(.fns = mean))
    
    #output df to new file 
    write.table(clean_data, "FinalData.txt", row.name=FALSE)
}


