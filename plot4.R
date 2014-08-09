plot4 <- function() {
  
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
  
  ## Convert the "Date" and "Time" values to Date/Time classes in R
  x <- paste(data$Date, data$Time)
  data$Time <- strptime(x, "%Y-%m-%d %H:%M:%S")

  ## Generate plots
  par(mfrow = c(2,2), mar = c(4, 4, 2, 1), oma = c (0, 0, 2 , 0)) 
  with(data, {
    plot(data$Time, as.numeric(as.character(data$Global_active_power)), type = "l", xlab = "", ylab = "Global Active Power (Kilowatts)")
    plot(data$Time, as.numeric(as.character(data$Voltage)), type = "l", xlab = "datetime", ylab = "Voltage")
    plot(data$Time, as.numeric(as.character(data$Sub_metering_1)), type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
    lines(data$Time, as.numeric(as.character(data$Sub_metering_2)), col = "red")
    lines(data$Time, as.numeric(as.character(data$Sub_metering_3)), col = "blue")
    legendNames <- c("Sub_metering_1          ", "Sub_metering_2          ", "Sub_metering_3          ")
    legend('topright', legendNames, col = c('black', 'red', 'blue'), lwd = 2, cex = 0.7)
    plot(data$Time, as.numeric(as.character(data$Global_reactive_power)), type = "l", xlab = "datetime", ylab = "Global_reactive_power")
  })
  
  ## Print plot to file "plot4.png" and close graphics device
  dev.copy(png,'plot4.png', width = 480, height = 480)
  dev.off()
  
}