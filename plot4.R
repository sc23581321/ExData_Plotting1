library(lubridate)

#read the data table into pwr
pwr <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE, colClasses = c("character", "character", rep("numeric", 7)),
                  na.strings = "?")

#create column new_date with date time format
pwr$new_date <- strptime(paste(pwr$Date, pwr$Time), "%d/%m/%Y %H:%M:%S")

# select the two days
dt <- subset(pwr, (new_date >="2007-02-01" & new_date <= "2007-02-03"))

# make the plot and save it to plot4.png
png(file = "plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

#plot 1
with(dt, plot(new_date, Global_active_power, type="l", lty =1, xlab = "", ylab = "Global Active Power (killowatts)"))

#plot 2
with(dt, plot(new_date, Voltage, type = "l", xlab = "datetime"))

#plot 3
with(dt, plot(new_date, Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub metering"))
with(dt, lines(new_date, Sub_metering_2, type = "l", col = "red"))
with(dt, lines(new_date, Sub_metering_3, type = "l", col = "blue"))

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col=c("black","red", "blue"), lty = c(1,1,1))

#plot 4
with(dt, plot(new_date, Global_reactive_power, type = "l", xlab = "datetime"))

dev.off()

