##This script creates a png file showing a plot of the "Global Active Power" 
##used by a single household over the course of a two-day period.
##There are 2880 observations in this histogram, taken every
##minute on 2007-02-01 and 2007-01-02. To run, the text file ("household_power_consumption.txt")
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

##Opens graphic device and creates a png of a plot in the working directory
## of Global Active Power over the two day period. closes graphic device.
png(filename = "plot2.png", width = 480, height = 480)
par(mfrow = c(1,1))
plot(Global_active_power ~ datetime, feb_hpc, type = "l", ylab = "Global Active Power (kilowatts")
dev.off()
