##This script creates a png file showing a plot of the energy consumption
## of three different sub-meters in single household over the course of a two-day period.
##There are 2880 observations in this histogram, taken every
##minute on 2007-02-01 and 2007-01-02. Sub-meter 1 is the kitchen, sub-meter 2 is the laundry room,
##and sub-meter 3 is a water heater and air conditioner. To run, the text file ("household_power_consumption.txt")
##must be in the working directory. 

###Loads necesarry packages and reads the data into R from the working directory, classifying the data where applicable.
library(readr)
library(lubridate)
library(dplyr)
hpc <- read_delim("household_power_consumption.txt", 
                  ";", escape_double = FALSE, col_types = cols(Date = col_date(format = "%d/%m/%Y"), 
                                                               Global_active_power = col_number(), 
                                                               Global_intensity = col_number(), 
                                                               Global_reactive_power = col_number(), 
                                                               Sub_metering_1 = col_number(), Sub_metering_2 = col_number(), 
                                                               Sub_metering_3 = col_number(), Time = col_time(format = "%H:%M:%S"), 
                                                               Voltage = col_number()), trim_ws = TRUE)

##Selects only the desired dates.
feb_hpc <- filter(hpc, Date == "2007-02-01" | Date == "2007-02-02")

##creates a new column (datetime) by combining "Date" and "Time"
feb_hpc$datetime <- ymd_hms(paste(feb_hpc$Date, feb_hpc$Time))

##Opens graphic device and creates png of a plot  in the working directory with separate lines for each of the Sub_metering 
##variables over the two day period. Closes graphic device.
png(filename = "plot3.png", width = 480, height = 480)
par(mfrow = c(1,1))
plot(Sub_metering_1 ~ datetime, feb_hpc, type = "l", ylab = "Energy sub metering", xlab = "")
lines(Sub_metering_2 ~ datetime, feb_hpc, col = "red")
lines(Sub_metering_3 ~ datetime, feb_hpc, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
dev.off()