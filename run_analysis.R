run_analysis <- function() {
  # Set path for all files
  testSubjectPath <- paste(getwd(), "UCI HAR Dataset", "test", "subject_test.txt", sep="/")
  testXPath <- paste(getwd(), "UCI HAR Dataset", "test", "X_test.txt", sep="/")
  testYPath <- paste(getwd(), "UCI HAR Dataset", "test", "y_test.txt", sep="/")
  
  trainSubjectPath <- paste(getwd(), "UCI HAR Dataset", "train", "subject_train.txt", sep="/")
  trainXPath <- paste(getwd(), "UCI HAR Dataset", "train", "X_train.txt", sep="/")
  trainYPath <- paste(getwd(), "UCI HAR Dataset", "train", "y_train.txt", sep="/")
  
  # Read all
  testSubjectTable <- read.table(testSubjectPath)
  trainSubjectTable <- read.table(trainSubjectPath)
  
  testXTable <- read.table(testXPath)
  trainXTable <- read.table(trainXPath)
  
  testYTable <- read.table(testYPath)
  trainYTable <- read.table(trainYPath)
  
  # Get ready for Q3,4 - will use later
  featPath <- paste(getwd(), "UCI HAR Dataset", "features.txt", sep="/")
  featTable <- read.table(featPath)
  featLogical <- grepl("mean|std", featTable[, 2])
  
  # Bind subject, Y, X
  subjectBind <- rbind(testSubjectTable, trainSubjectTable)
  yBind <- rbind(testYTable, trainYTable)
  xBind <- rbind(testXTable, trainXTable)
  
  # Change name of the features
  featNewName <- gsub("mean()", "MeanValue", featTable[, 2])
  featNewName <- gsub("std()", "StdDeviation", featNewName)
  featNewName <- gsub("mad()", "MedianValue", featNewName)
  featNewName <- gsub("max()", "MaxValue", featNewName)
  featNewName <- gsub("min()", "MinValue", featNewName)
  featNewName <- gsub("sma()", "SignalMagnitudeArea", featNewName)
  featNewName <- gsub("energy()", "EnergyMeasure", featNewName)
  featNewName <- gsub("iqr()", "InterquartileRange", featNewName)
  featNewName <- gsub("entropy()", "Entropy", featNewName)
  featNewName <- gsub("arCoeff()", "AutoregressionCoeff", featNewName)
  featNewName <- gsub("correlation()", "Correlation", featNewName)
  featNewName <- gsub("maxInds()", "MaxMagnitudeIndex", featNewName)
  featNewName <- gsub("meanFreq()", "MeanFrequency", featNewName)
  featNewName <- gsub("skewness()", "Skewness", featNewName)
  featNewName <- gsub("kurtosis()", "Kurtosis", featNewName)
  featNewName <- gsub("bandsEnergy()", "BandsEnergy", featNewName)
  featNewName <- gsub("angle()", "VectorsAngle", featNewName)
  featNewName <- gsub("\\(\\)", "", featNewName)
  
  colnames(xBind) <- t(featNewName)
  featData <- xBind[, featLogical]
  
  # Now bind everything to make proper data set
  # setnames is under data.table
  setnames(subjectBind, c("V1"), c("Subject"))
  setnames(yBind, "V1", "Activity")
  allData <- cbind(subjectBind, yBind, xBind)
  
  # Arrange so that it's easier to look at
  # arrange is under dplyr
  allData <- data.frame(allData, check.names = T)
  allData <- arrange(allData, Subject, Activity)
  
  # Create data set here (TBD later)
  
  # Start of Q3, 4
  summarizedData <- cbind(subjectBind, yBind, featData)
  summarizedData <- arrange(summarizedData, Subject, Activity)
  
  tidyAveData <- aggregate(. ~ Subject + Activity, data = summarizedData, FUN = mean)
  
  # Rename again, since the data now contains means of means/std.deviation
  tidyNewNameVect <- colnames(tidyAveData)
  tidyNewNameVect <- gsub("MeanValue", "MeanOfMean", tidyNewNameVect)
  tidyNewNameVect <- gsub("StdDeviation", "MeanOfStdDeviation", tidyNewNameVect)
  colnames(tidyAveData) <- tidyNewNameVect
  
  write.table(allData, "./AllData.txt", row.names = F)
  write.table(tidyAveData, "./TidyAverageData.txt", row.names = F)
}