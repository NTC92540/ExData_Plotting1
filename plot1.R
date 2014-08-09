plot1 <- function() {
  
  ## Assign name of external .zip file to "fileUrl"
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  
  ## Download file and save within working directory with file name "exdata_data_household_power_consumption.zip"
  download.file(fileUrl, "./exdata_data_household_power_consumption.zip")

  ## Extract .zip file into text file "household_power_consumption" within working directory
  filePath <- unzip("./exdata_data_household_power_consumption.zip", overwrite=TRUE)
  
  ## Set column names and read text file into R table called "tempData"
  colNames <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity",
                  "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  tempData <- read.table(filePath, sep = ";", col.names = colNames, skip = 1)
  
  ## Set format of "Date" column within "tempData" to format year-month-day
  tempData[,1] <- as.Date(tempData[,1], "%d/%m/%Y")
  
  ## Subset data set within tempdata to include rows tagged with dates of "2007-02-01" or "2007-02-02"
  data <- subset(tempData, tempData$Date == "2007-02-01" | tempData$Date == "2007-02-02" )
  
  ## Generate histogram
  hist(as.numeric(as.character(data$Global_active_power)), xlab = "Global Active Power (Kilowatts)", 
       col = "red", main = paste("Global Active Power"))
  
  ## Print histogram to file "plot1.png" and close graphics device
  dev.copy(png,'plot1.png', width = 480, height = 480)
  dev.off()
  
}
