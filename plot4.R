#   Required libraries
require(lubridate)

#   Load data
data <- read.csv(unz(
    "d:/data_archive/UCI/PowerConsumption/exdata-data-household_power_consumption.zip", 
    "household_power_consumption.txt"), header=T,  sep=";", stringsAsFactors = FALSE)

#   Subset to only include 2 days:  2/1/07 - 2/2/07
plotData <- data[as.Date(dmy(wdf$Date)) == "2007-02-01" | as.Date(dmy(wdf$Date)) == "2007-02-02",]

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

#   Plot 4
png(file = "ExploratoryDataAnalysis/plot4.png", width = 480, height = 480  )
par(mfrow = c(2,2))

#   Top left plot
with(plotData, plot(plotData$DateTime, plotData$Global_active_power, type="l", ylab="Global Active Power", xlab=""))

# Top right plot
with(plotData, plot(plotData$DateTime, plotData$Voltage, type="l", ylab="Voltage", xlab="datetime"))

#   Bottom left plot
with(plotData, plot(plotData$DateTime, plotData$Sub_metering_1,  
                    type="l", 
                    ylab="Energy sub metering", 
                    xlab=""
                    #xlim=c(0, 30) 
))
with(plotData, lines(plotData$DateTime, plotData$Sub_metering_2, type="l", col = "red"))
with(plotData, lines(plotData$DateTime, plotData$Sub_metering_3, type="l", col = "blue"))
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n",
       lwd = 1, cex = 0.9, col = c("black", "blue", "red"), lty = c(1, 1, 1))

#   Bottom Right plot
with(plotData, plot(plotData$DateTime, plotData$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime"))
dev.off()
