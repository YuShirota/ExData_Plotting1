library(data.table)
## Please assume that the .txt file is already in the working directory ##
mydata <- fread("household_power_consumption.txt", na.strings = '?')
mydata$DateTime <- as.POSIXct(paste(mydata$Date, mydata$Time), 
                              format = "%d/%m/%Y %H:%M:%S")
#Sebset the two day data
submydata <- subset(mydata, (as.POSIXct('2007-02-01 00:00') <= mydata$DateTime) & 
                        (mydata$DateTime <= as.POSIXct('2007-02-02 23:59')))
submydata$Global_active_power <- as.numeric(submydata$Global_active_power)

# Create a histogram png file
png(file = "plot1.png")
hist(submydata$Global_active_power, main = "Global active power", 
     xlab = "Global Active Power (kilowats)", col = "orange")
dev.off()
