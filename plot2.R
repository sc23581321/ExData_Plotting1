library(tidyverse)
library(lubridate)

#read the data table into pwr
pwr <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)

#coerce into numeric value
pwr$Global_active_power <- as.numeric(pwr$Global_active_power)

#create column new_date with date time format
pwr$new_date <- strptime(paste(pwr$Date, pwr$Time), "%d/%m/%Y %H:%M:%S")

# select the two days
dt <- subset(pwr, (new_date >="2007-02-01" & new_date <= "2007-02-03"))

# calculate fraction weekday
dt$fwday <- wday(dt$new_date, week_start=1) + (hour(dt$new_date) + minute(dt$new_date)/60 + second(dt$new_date)/3600)/24

# make the plot and save it to plot2.png
png(file = "plot2.png", width = 480, height = 480)
plot(dt$fwday, dt$Global_active_power, type="l", lty =1, xaxt='n', xlab = "", ylab = "Global Active Power (killowatts)")
axis(1, at=seq(4,6,1), labels = c("Thur","Fri","Sat"))
dev.off()
