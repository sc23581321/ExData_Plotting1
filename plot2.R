library(lubridate)

#read the data table into pwr
pwr <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE, colClasses = c("character", "character", rep("numeric", 7)),
                  na.strings = "?")

#create column new_date with date time format
pwr$new_date <- strptime(paste(pwr$Date, pwr$Time), "%d/%m/%Y %H:%M:%S")

# select the two days
dt <- subset(pwr, (new_date >="2007-02-01" & new_date <= "2007-02-03"))

# make the plot and save it to plot2.png
png(file = "plot2.png", width = 480, height = 480)
plot(dt$new_date, dt$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (killowatts)")
dev.off()