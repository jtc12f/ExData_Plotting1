##This script creates a png file showing a histogram of the "Global Active Power" 
##used by a single household over the course of a two-day period.
##There are 2880 observations in this histogram, taken every
##minute on 2007-02-01 and 2007-01-02. The distribution is 
##positively skewed, with most observations falling below two kilowatts
##of Global Active Power. To run, the text file ("household_power_consumption.txt")
##must be in the working directory. 


###Loads necesarry packages and reads the data into R from the working directory, classifying the data where applicable.
library(readr)
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


##Opens graphic device and creates a png of a histogram of the selected data in the working directory. closes graphic device.
png(filename = "plot1.png", width = 480, height = 480)
par(mfrow = c(1,1))
hist(feb_hpc$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()