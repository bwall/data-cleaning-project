# Peer-graded Assignment: Getting and Cleaning Data Course Project
This is my submission for the course project. Run the `run_analysis.R` script to reproduce the tidy dataset.  The steps it takes are as follows:

1. Loads the original dataset feature names and activity names to identify relevant features
2. Loads the training and testing data from the "data" directory, including labels and subject data
3. Merges training and testing data
4. Applies descriptive names for activities
5. Groups rows by subject and activity, and averages the values
6. Writes the produced data set out to `average_tidy_dataset.csv`

The data set is included in the repository, so running the script is not required to utilize the data.  The data read by the script is located in the `data` directory of this repository.