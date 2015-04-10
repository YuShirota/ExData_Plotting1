library(data.table)
## Please assume that the .txt file is already in the working directory ##
mydata <- fread("household_power_consumption.txt", na.strings = '?')
mydata$DateTime <- as.POSIXct(paste(mydata$Date, mydata$Time), 
                              format = "%d/%m/%Y %H:%M:%S")
submydata <- subset(mydata, (as.POSIXct('2007-02-01 00:00') <= mydata$DateTime) & 
                        (mydata$DateTime <= as.POSIXct('2007-02-02 23:59')))

# Numerize required values
submydata$Global_active_power <- as.numeric(submydata$Global_active_power)
submydata$Voltage <- as.numeric(submydata$Voltage)
submydata$Global_reactive_power <- as.numeric(submydata$Global_reactive_power)
submydata$Sub_metering_1 <- as.numeric(submydata$Sub_metering_1)
submydata$Sub_metering_2 <- as.numeric(submydata$Sub_metering_2)
submydata$Sub_metering_3 <- as.numeric(submydata$Sub_metering_3)

# Create a plot
png(file = "plot4.png")
par(mfcol = c(2, 2))
plot(submydata$DateTime, submydata$Global_active_power, type = "l", 
     main = "", xlab = "", ylab = "Global Active Power (kilowats)")
plot(submydata$DateTime, submydata$Sub_metering_1, type = "l",
     main = "", xlab = "", ylab = "Energy sub metering", col = "black")
lines(submydata$DateTime, submydata$Sub_metering_2, type = "l", col = "red")
lines(submydata$DateTime, submydata$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")
plot(submydata$DateTime, submydata$Voltage, type = "l",
     main = "", xlab = "datetime", ylab = "Voltage", col = "black")
plot(submydata$DateTime, submydata$Global_reactive_power, type = "l",
     main = "", xlab = "datetime", ylab = "Global_reactive_power", col = "black")
dev.off()


