#   Required libraries
require(lubridate)
require(pryr)

#   for first plot, check memory to ensure 2 million rows can be read into data (machine has 32 GB memory)
#   assume other 4 plots don't need memory check if this one is ok.
rm(list=ls())
memory.limit()
#   32647

gc()
#used (Mb) gc trigger  (Mb) max used  (Mb)
#Ncells 483727 25.9     818163  43.7   818163  43.7
#Vcells 729733  5.6   37754973 288.1 62595695 477.6

mem_used()
#   ~33 MB

#   Load data
data <- read.csv(unz(
    "d:/data_archive/UCI/PowerConsumption/exdata-data-household_power_consumption.zip", 
    "household_power_consumption.txt"), header=T,  sep=";", stringsAsFactors = FALSE)

memory.limit()
gc()
mem_used()
#   ~183 MB

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

#   Plot 1
png(file = "ExploratoryDataAnalysis/plot1.png", width = 480, height = 480  )
hist(plotData$Global_active_power, col="tomato3", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
