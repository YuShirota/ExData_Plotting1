library(data.table)
## Please assume that the .txt file is already in the working directory ##
mydata <- fread("household_power_consumption.txt", na.strings = '?')
mydata$DateTime <- as.POSIXct(paste(mydata$Date, mydata$Time), 
                              format = "%d/%m/%Y %H:%M:%S")
submydata <- subset(mydata, (as.POSIXct('2007-02-01 00:00') <= mydata$DateTime) & 
                        (mydata$DateTime <= as.POSIXct('2007-02-02 23:59')))

# Numerize required values
submydata$Sub_metering_1 <- as.numeric(submydata$Sub_metering_1)
submydata$Sub_metering_2 <- as.numeric(submydata$Sub_metering_2)
submydata$Sub_metering_3 <- as.numeric(submydata$Sub_metering_3)

# Create a plot
png(file = "plot3.png")
plot(submydata$DateTime, submydata$Sub_metering_1, type = "l",
     main = "", xlab = "", ylab = "Energy sub metering", col = "black")
lines(submydata$DateTime, submydata$Sub_metering_2, type = "l", col = "red")
lines(submydata$DateTime, submydata$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()




