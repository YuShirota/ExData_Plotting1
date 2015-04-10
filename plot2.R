library(data.table)
## Please assume that the .txt file is already in the working directory ##
mydata <- fread("household_power_consumption.txt", na.strings = '?')
mydata$DateTime <- as.POSIXct(paste(mydata$Date, mydata$Time), 
                              format = "%d/%m/%Y %H:%M:%S")
submydata <- subset(mydata, (as.POSIXct('2007-02-01 00:00') <= mydata$DateTime) & 
                        (mydata$DateTime <= as.POSIXct('2007-02-02 23:59')))

submydata$Global_active_power <- as.numeric(submydata$Global_active_power)

#Sys.setlocale("LC_TIME", "English")     # From Japanese to Englich
#format(submydata$DateTime[1], "%a")     # "Thu"
png(file = "plot2.png")
plot(submydata$DateTime, submydata$Global_active_power, type = "l", 
     main = "", xlab = "", ylab = "Global Active Power (kilowats)")
dev.off()
