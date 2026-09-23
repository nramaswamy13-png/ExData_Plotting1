dataFile <- "household_power_consumption.txt"
if (!file.exists(dataFile)) {
  zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  zipFile <- "household_power_consumption.zip"
  if (!file.exists(zipFile)) {
    download.file(zipUrl, destfile = zipFile, mode = "wb")
  }
  unzip(zipFile)
}

data <- read.table(dataFile, header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
subData <- subset(data, Date %in% c("1/2/2007", "2/2/2007"))
subData$DateTime <- strptime(paste(subData$Date, subData$Time), "%d/%m/%Y %H:%M:%S")

png("plot3.png", width = 480, height = 480)
plot(subData$DateTime, as.numeric(subData$Sub_metering_1), 
     type = "l", 
     xlab = "", 
     ylab = "Energy sub metering")
lines(subData$DateTime, as.numeric(subData$Sub_metering_2), col = "red")
lines(subData$DateTime, as.numeric(subData$Sub_metering_3), col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = 1)
dev.off()
