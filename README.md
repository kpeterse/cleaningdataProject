# cleaningdataProject

The script contained in this repository is used to clean the dataset "Human Activity Recognition Using Smartphones"

The script must be deployed in the "UCI HAR Dataset" folder

The run.analysis function leverages the dplyr package to summarize the data contained within both the "train" and "test" directories

There are two primary outputs of this script
1) fullData - the non-summarized combined data set
2) summarizedData - the summarized version of "fullData"

These are the steps taken to arrive at these datasets
0) Initializes fullData as Null

1) Merges the train and test raw  data sets by looping through both sub-directories and binding the "subject", "activity" and "results" datasets for both train and test

2) Once these subdata sets are binded, we combine train and test together into one large data set

3) fullData is now created, and in the following steps we enrich it with descriptive variables 

4) We rename the columns from "V1:Vn" to reflect the respective measures that can be found in the "features.txt" file

5) We rename the "activities" to reflect the actual activity instead of the number 1-6 as per the "activity_labels.txt" file

6) The columns are refined to only include variables including "mean" or "std"

7) We then group the data by "subject" and "activity" and summarize it by taking the mean of each variable usign the summarise_each function found in the dplyr package

8) This summarized data is then returned  
