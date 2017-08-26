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

# Plot the distribution of global active power
png("plot1.png", width = 480, height = 480)
hist(subdata$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
