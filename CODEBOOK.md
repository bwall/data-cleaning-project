# Code Book
## IDs
- `subject`: Identifier for the test subject
- `activity_id`: Integer identifier for the activity the subject was doing
- `activity_name`: String identifier for the activity the subject was doing (`WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`, `LAYING`)

## Feature Selection
(This section updated from the "features_info.txt" file in the original dataset)

### Preprocessing
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

A Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

Finally, for each subject and activity, the gathered values are then averaged.

### Features
These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

 - `tBodyAcc-XYZ`
 - `tGravityAcc-XYZ`
 - `tBodyAccJerk-XYZ`
 - `tBodyGyro-XYZ`
 - `tBodyGyroJerk-XYZ`
 - `tBodyAccMag`
 - `tGravityAccMag`
 - `tBodyAccJerkMag`
 - `tBodyGyroMag`
 - `tBodyGyroJerkMag`
 - `fBodyAcc-XYZ`
 - `fBodyAccJerk-XYZ`
 - `fBodyGyro-XYZ`
 - `fBodyAccMag`
 - `fBodyAccJerkMag`
 - `fBodyGyroMag`
 - `fBodyGyroJerkMag`

The set of variables that were estimated from these signals are: 

 - `mean()`: Mean value
 - `std()`: Standard deviation

The raw complete list of variables of each feature vector is available in 'features_tidy.txt'

### Removed features
Features not related to the "mean()" and "std()" based features were removed.  These measurements include the following:

 - `mad()`: Median absolute deviation 
 - `max()`: Largest value in array
 - `min()`: Smallest value in array
 - `sma()`: Signal magnitude area
 - `energy()`: Energy measure. Sum of the squares divided by the number of values. 
 - `iqr()`: Interquartile range 
 - `entropy()`: Signal entropy
 - `arCoeff()`: Autorregresion coefficients with Burg order equal to 4
 - `correlation()`: correlation coefficient between two signals
 - `maxInds()`: index of the frequency component with largest magnitude
 - `meanFreq()`: Weighted average of the frequency components to obtain a mean frequency
 - `skewness()`: skewness of the frequency domain signal 
 - `kurtosis()`: kurtosis of the frequency domain signal 
 - `bandsEnergy()`: Energy of a frequency interval within the 64 bins of the FFT of each window.
 - `angle()`: Angle between to vectors.

The following features were also removed:

 - `gravityMean`
 - `tBodyAccMean`
 - `tBodyAccJerkMean`
 - `tBodyGyroMean`
 - `tBodyGyroJerkMean`



# Study Design

## Obtaining the data
The data collected in this data set was downloaded from the following URL.
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The MD5 of this zip file at time of download was as follows: `d29710c9530a31f303801b6bc34bd895`

Upon download of this zip file, the command `unzip` was applied, extracting the contents of the archive to the `data` directory.

## Naming the features
The names of features were read from the `features.txt` text file in order to identify the features we had interest in. The feature names were grep'd for `mean()` and `std()`.

For both the training and testing set, a set of steps were taken to load and merge the different data values into a single data frame.

## Training data steps
1. Loaded `X_train.txt` and applied feature names from `features.txt` to the column names
2. Loaded `subject_train.txt` and defined the values as the `subject` column
3. Loaded `y_train.txt` and defined the values as the `activity_id` column

## Testing data steps
1. Loaded `X_test.txt` and applied feature names from `features.txt` to the column names
2. Loaded `subject_test.txt` and defined the values as the `subject` column
3. Loaded `y_test.txt` and defined the values as the `activity_id` column

## Merging and Slicing
The testing data was then appended with the training data, making a single dataset by adding all the testing rows to the training rows.  At that point, the feature indices identified as relevant (containing `mean()` or `std()`) were applied in a slicing operation to the dataframe in order to extract only the relevant features.

## Describing activities
Activity names were loaded from `activity_labels.txt` in order to apply descriptive naming to activities.  The activity table (containing activity_id's and activity_name's) was joined (left outer) with the dataset into order to add a column with the descriptive name of each activity.

## Grouping averages
The dataset was then grouped by the columns `subject`, `activity_id`, and `activity_name`, and for each group, the other columns were averaged with the mean function.  Each row of the resulting dataset contains the average of each feature as well as the `subject`, `activity_id`, and `activity_name` for that group.

## Saving the data set
The dataset was then saved as a CSV excluding the row names.
