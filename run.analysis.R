run.analysis <- function() {
        nameSet <- c("train", "test")
        fileSet <- c("subject_", "y_", "X_")
        fullData <- NULL
        
        ## Merges the two data sets
        for(i in 1:length(nameSet)){
                middleData <- NULL
                ## sets the file path to either test or train
                path <- paste(c(nameSet[i], "/"), collapse = "")
                for(j in 1:length(fileSet)){
                        ## adds the file name to the file path
                        fullPath <- paste(c(path, fileSet[j], nameSet[i], ".txt"), collapse = "") 
                        if(is.null(middleData)){
                                middleData <- read.table(fullPath)
                        } else {
                                tempData <- read.table(fullPath)
                                middleData <- cbind(middleData, tempData)
                        }        
                }       
                ## if the data if the first added data set, then that is the "full data set"
                ## else we bind it to the previously added data sets
                if(is.null(fullData)){
                        fullData <- middleData
                } else {
                        fullData <- rbind(fullData, middleData)
                }
        }
        ## clear out tempdata and middleData
        tempData <- NULL; middleData <- NULL
        ## rename the columns to correspond to the real names of the columns
        colNames <- read.table("features.txt")
        colNames <- rbind("subject", "activity", matrix(colNames[1:nrow(colNames), 2]))
        colnames(fullData) <- colNames
        ## rename the activity numbers to represent the name of the activity
        activityIndex <- read.table("activity_labels.txt", stringsAsFactors = F)
        for(k in 1:nrow(fullData)){
                fullData[k, "activity"] <- activityIndex[fullData[k, "activity"], 2]
        }
        ## select on the columns that pertain to mean and std data
        newColNames <- names(fullData)
        ## find all columns names that have mean or std in them and sort by column number
        meanStdCols <- sort(c(grep("std()", newColNames), grep("mean()", newColNames)))
        ## find what columns subject and activity are in, and concatenate them to list above
        allCols <- c(c(match("subject", newColNames), match("activity", newColNames)), meanStdCols)
        ## filter the fullData to only have the columns specified above
        fullData <- fullData[, allCols]
        
        ## Summarize the data
        groupedData <- group_by(fullData, subject, activity)
        summarizedData <- summarise_each(groupedData, funs(mean))

        return(summarizedData)
}

