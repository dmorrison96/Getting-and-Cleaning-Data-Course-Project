# Getting-and-Cleaning-Data-Course-Project

This is my submission for the final course project in "Getting and Cleaning Data" on Coursera.
Included you will find a codebook (CodeBook.md), which containts information on the modifications applied to the original datasets and descriptors for the new dataset, and an R script (run_analysis.R), which does the following: 

- Downloads the dataset from the web zip file provided (if it not already present in the working directory).
- Reads the test and training datasets and merges them into one dataset.
- Uses descriptive activity names to name the activities in the dataset.
- Appropriately labels the dataset with descriptive variable names.
- Creates a second, clean dataset with the average of each variable for each activity and each subject.

The resultant dataset is shown in the file tidy_data.txt.
