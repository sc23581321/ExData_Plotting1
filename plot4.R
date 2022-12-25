library(tidyverse)
library(lubridate)

#read the data table into pwr
pwr <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)

#coerce into numeric value
pwr$Global_active_power <- as.numeric(pwr$Global_active_power)
pwr$Global_reactive_power <- as.numeric(pwr$Global_reactive_power)
pwr$Voltage <- as.numeric(pwr$Voltage)
pwr$Sub_metering_1 <- as.numeric(pwr$Sub_metering_1)
pwr$Sub_metering_2 <- as.numeric(pwr$Sub_metering_2)
pwr$Sub_metering_3 <- as.numeric(pwr$Sub_metering_3)

#create column new_date with date time format
pwr$new_date <- strptime(paste(pwr$Date, pwr$Time), "%d/%m/%Y %H:%M:%S")

# select the two days
dt <- subset(pwr, (new_date >="2007-02-01" & new_date <= "2007-02-03"))

# calculate fraction weekday
dt$fwday <- wday(dt$new_date, week_start=1) + (hour(dt$new_date) + minute(dt$new_date)/60 + second(dt$new_date)/3600)/24

# make the plot and save it to plot4.png
png(file = "plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

with(dt, plot(fwday, Global_active_power, type="l", lty =1, xaxt='n', xlab = "", ylab = "Global Active Power (killowatts)"))
axis(1, at=seq(4,6,1), labels = c("Thur","Fri","Sat"))

with(dt, plot(fwday, Voltage, type = "l", xaxt='n', xlab = "datetime"))
axis(1, at=seq(4,6,1), labels = c("Thur","Fri","Sat"))

with(dt, plot(fwday, Sub_metering_1, type = "l", xaxt='n', xlab = "", ylab = "Energy Sub metering"))
with(dt, lines(fwday, Sub_metering_2, type = "l", col = "red"))
with(dt, lines(fwday, Sub_metering_3, type = "l", col = "blue"))

axis(1, at=seq(4,6,1), labels = c("Thur","Fri","Sat"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col=c("black","red", "blue"), lty = c(1,1,1))

with(dt, plot(fwday, Global_reactive_power, type = "l", xaxt='n', xlab = "datetime"))
axis(1, at=seq(4,6,1), labels = c("Thur","Fri","Sat"))

dev.off()

