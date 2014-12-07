#   Required libraries
require(lubridate)

#   Load data
data <- read.csv(unz(
    "d:/data_archive/UCI/PowerConsumption/exdata-data-household_power_consumption.zip", 
    "household_power_consumption.txt"), header=T,  sep=";", stringsAsFactors = FALSE)

#   Subset to only include 2 days:  2/1/07 - 2/2/07
plotData <- data[as.Date(dmy(data$Date)) == "2007-02-01" | as.Date(dmy(data$Date)) == "2007-02-02",]

#   Add DateTime column from date column and time column in posix format for plots
plotData$DateTime <- strptime(paste(dmy(plotData$Date),plotData$Time), format="%Y-%m-%d %H:%M:%S")

#   Convert types to numeric
plotData$Global_active_power <- as.numeric(plotData$Global_active_power)
plotData$Global_reactive_power <- as.numeric(plotData$Global_reactive_power)
plotData$Voltage <- as.numeric(plotData$Voltage)
plotData$Global_intensity <- as.numeric(plotData$Global_intensity)
plotData$Sub_metering_1 <- as.numeric(plotData$Sub_metering_1)
plotData$Sub_metering_2 <- as.numeric(plotData$Sub_metering_2)
plotData$Sub_metering_3 <- as.numeric(plotData$Sub_metering_3)

#   Plot 3
png(file = "ExploratoryDataAnalysis/plot3.png", width = 480, height = 480  )
with(plotData, plot(plotData$DateTime, plotData$Sub_metering_1,  
                    type="l", 
                    ylab="Energy sub metering", 
                    xlab=""
                    #xlim=c(0, 30) 
))
with(plotData, lines(plotData$DateTime, plotData$Sub_metering_2, type="l", col = "red"))
with(plotData, lines(plotData$DateTime, plotData$Sub_metering_3, type="l", col = "blue"))
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lwd = 2, cex = 1.2, col = c("black", "red", "blue"), lty = c(1, 1, 1))
dev.off()
