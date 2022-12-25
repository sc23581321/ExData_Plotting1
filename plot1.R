library(tidyverse)

#read in data table
pwr <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE, colClasses = c("character", "character", rep("numeric", 7)),
                  na.strings = "?")

#create column new_date with date time format
pwr$new_date <- strptime(paste(pwr$Date, pwr$Time), "%d/%m/%Y %H:%M:%S")

# select the two days
dt <- subset(pwr, (new_date >="2007-02-01" & new_date <= "2007-02-03"))

#plot the data and save it to plot1.png
png(file = "plot1.png", width = 480, height = 480)

hist(dt$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", xlim = c(0,6), main = "Global Active Power")

dev.off()
