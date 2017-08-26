#load libraries
library(dplyr)
library(data.table)
library(lubridate)

#Assumpting the R file will be saved and run from the same directory where the data file is kept
#setwd("~/Data")

# Read data set from the data file
data <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", dec = ".", stringsAsFactors = FALSE, na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
data <- tbl_df(data)

# Household power consumption for Feb. 1 and 2, 2007 only
subdata <- data[data$Date %in% c("1/2/2007", "2/2/2007"),]

# Merge Date and Time variables
# Convert to Date/Time class
subdata$Time <- strptime(paste(subdata$Date, subdata$Time), "%d/%m/%Y %H:%M:%S")
subdata$Date <- as.Date(subdata$Date, "%d/%m/%Y")

# Plot Energy sub metering
png("plot3.png", width = 480, height = 480)
plot(subdata$Time, subdata$Sub_metering_1, type = "l", col = "black", xlab="", ylab = "Energy sub metering")
lines(subdata$Time, subdata$Sub_metering_2, col="red")
lines(subdata$Time, subdata$Sub_metering_3, col="blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)

dev.off()