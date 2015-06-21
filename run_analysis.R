## Project - Getting & Cleaning Data - Week 5
##
## Step 1: Merge the test and training data by "stacking" the data so that 
## the test data is in the first set of rows and the training 
## data is in the last rows of the data frame.
##
## Make a data table of the test data
##
X_test <- read.table("wearable_data/UCI\ HAR\ Dataset/test/X_test.txt",header=FALSE)
y_test <- read.table("wearable_data/UCI\ HAR\ Dataset/test/y_test.txt",header=FALSE)
subject_test <- read.table("wearable_data/UCI\ HAR\ Dataset/test/subject_test.txt",header=FALSE)
test_data <- data.frame(subject_test, y_test, X_test)
## 
## Make a data frame of the training data  
## 
X_train <- read.table("wearable_data/UCI\ HAR\ Dataset/train/X_train.txt",header=FALSE)
y_train <- read.table("wearable_data/UCI\ HAR\ Dataset/train/y_train.txt",header=FALSE)
subject_test <- read.table("wearable_data/UCI\ HAR\ Dataset/test/subject_test.txt",header=FALSE)
train_data <- data.frame(subject_train, y_train, X_train)
##
## Merge (or stack) the test data and training data together
all_data <- rbind(test_data,train_data)
##
## Step 2: Add the column names to the data by making a vector of 
## column names and then using it as input to the names() function
## to set the column names.
##
features_labels <- read.table("wearable_data/UCI\ HAR\ Dataset/features.txt",header=FALSE)
features_character <- levels(features_labels$V2)[as.numeric(features_labels$V2)]
all_data_labels <- c("subject_ID","activity",features_character)
names(all_data) <- all_data_labels
##
## Step 3: Change the activity values in the data from codes to values so
## that the activity names are descriptive
library(car)
all_data$activity <- recode(all_data$activity,"1='WALKING';2='WALKING_UPSTAIRS';3='WALKING_DOWNSTAIRS';4='SITTING';5='STANDING';6='LAYING'")
## 
##
## Step 4: Extract only the measuments of the mean and standard deviation
## of each measurement.
all_data_mean_std <- all_data[,(c(1,2,3:8,43:48,83:88,123:128,163:168,203:204,216:217,229:230,242:243,255:256,268:273,296:298,347:352,375:377,426:431,454:456,505:506,515,518:519,531:532,541,544:545,554,558,563))]
##
## Step 5: Generate a dataframe that has the mean of each variable for each
## subject and activity.
##
library(data.table)
all_data_step5 <- rbind(test_data,train_data)
all_data_step5_dt <- data.table(all_data_step5)
setkey(all_data_step5_dt,V1,V1.1)
all_data_agg_means <- as.data.frame(all_data_step5_dt[,j=list(mean(V1.2),mean(V2),mean(V3),mean(V4),mean(V5),mean(V6),mean(V41),mean(V42),
mean(V43),mean(V44),mean(V45),mean(V46),mean(V81),mean(V82),mean(V83),mean(V84),mean(V85),mean(V86),
mean(V121),mean(V122),mean(V123),mean(V124),mean(V125),mean(V126),mean(V161),mean(V162),mean(V163),
mean(V164),mean(V165),mean(V166),mean(V201),mean(V202),mean(V214),mean(V215),mean(V227),mean(V228),
mean(V240),mean(V241),mean(V253),mean(V254),mean(V266),mean(V267),mean(V268),mean(V269),mean(V270),mean(V271),
mean(V294),mean(V295),mean(V296),mean(V345),mean(V346),mean(V347),mean(V348),mean(V349),mean(V350),
mean(V373),mean(V374),mean(V375),mean(V424),mean(V425),mean(V426),mean(V427),mean(V428),mean(V429),
mean(V452),mean(V453),mean(V454),mean(V503),mean(V504),mean(V513),mean(V516),mean(V517),mean(V529),mean(V530),mean(V539),mean(V542),
mean(V543),mean(V552),mean(V556),mean(V561)),by=list(V1,V1.1)])
##
## Add the column names to the data table. We can use the names created
## in step 4 because the structure is the same here.
##
names(all_data_agg_means) <- names(all_data_mean_std)
##
## Export Data
##
con5 = file("data_step5.txt","w")
write.table(all_data_agg_means,file=con,row.names=FALSE)
