run_analysis <- function() {
  # Set path for all files
  testSubjectPath <- paste(getwd(), "test", "subject_test.txt", sep="/")
  testXPath <- paste(getwd(), "test", "X_test.txt", sep="/")
  testYPath <- paste(getwd(), "test", "y_test.txt", sep="/")
  
  trainSubjectPath <- paste(getwd(), "train", "subject_train.txt", sep="/")
  trainXPath <- paste(getwd(), "train", "X_train.txt", sep="/")
  trainYPath <- paste(getwd(), "train", "y_train.txt", sep="/")
  
  # Read all
  testSubjectTable <- read.table(testSubjectPath)
  trainSubjectTable <- read.table(trainSubjectPath)
  
  testXTable <- read.table(testXPath)
  trainXTable <- read.table(trainXPath)
  
  testYTable <- read.table(testYPath)
  trainYTable <- read.table(trainYPath)
  
  # Get ready for Q3,4 - will use later
  featTable <- read.table("features.txt")
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
  
  # Clean it up
  summarizedData$Activity <- factor(summarizedData$Activity)
  summarizedData$Activity <- revalue(summarizedData$Activity, c("1" = "WALKING", "2" = "WALKING_UPSTAIRS", "3" = "WALKING_DOWNSTAIRS", "4" = "SITTING", "5" = "STANDING", "6" = "LAYING"))
  
  # WIP
  walking1 <- subset(summarizedData, summarizedData$Subject == 1 & summarizedData$Activity == "WALKING")
  x <- lapply(walking1[, 3:ncol(walking1)], mean)
}