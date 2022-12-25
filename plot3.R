library(lubridate)

#read the data table into pwr
pwr <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE, colClasses = c("character", "character", rep("numeric", 7)),
                  na.strings = "?")

#create column new_date with date time format
pwr$new_date <- strptime(paste(pwr$Date, pwr$Time), "%d/%m/%Y %H:%M:%S")

# select the two days
dt <- subset(pwr, (new_date >="2007-02-01" & new_date <= "2007-02-03"))

# make the plot and save it to plot3.png
png(file = "plot3.png", width = 480, height = 480)
with(dt, plot(new_date, Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub metering"))
with(dt, lines(new_date, Sub_metering_2, type = "l", col = "red"))
with(dt, lines(new_date, Sub_metering_3, type = "l", col = "blue"))

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col=c("black","red", "blue"), lty = c(1,1,1))
dev.off()
