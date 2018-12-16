# assignment week 1

#load from a text file
data <- read.table(file = "data/household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)

# format columns and create a date/time column
data$Time <- paste(data$Date, data$Time, sep =" ")
data$Date <- as.Date(data[,1],"%d/%m/%Y")
tempdata <- strptime(data[,2], "%d/%m/%Y %H:%M:%S")
data$Time <- tempdata
data$Global_active_power <- as.numeric(data$Global_active_power)

# filter for only the two dates we require
data <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]

#reset in case the script is run several times
par(mfrow = c(1,1))

#plot 1
hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.copy(png, file = "plot1.png")
dev.off()

#plot 2
plot(data$Time, data$Global_active_power, type = "l", xlab ="", ylab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot2.png")
dev.off()

#plot 3
plot(data$Time, data$Sub_metering_1, type = "l", xlab ="", ylab = "Energy sub metering")
points(data$Time, data$Sub_metering_2, col = "red", type = "l")
points(data$Time, data$Sub_metering_3, col = "blue", type = "l")
legend("topright", pch = "_" , col = c("black", "red", "blue"), legend = names(data)[7:9])
dev.copy(png, file = "plot3.png")
dev.off()

#plot 4
par(mfrow = c(2,2))
plot(data$Time, data$Global_active_power, type = "l", xlab ="", ylab = "Global Active Power (kilowatts)")
plot(data$Time, data$Voltage, type = "l", xlab ="datetime", ylab = "Voltage")
plot(data$Time, data$Sub_metering_1, type = "l", xlab ="", ylab = "Energy sub metering")
points(data$Time, data$Sub_metering_2, col = "red", type = "l")
points(data$Time, data$Sub_metering_3, col = "blue", type = "l")
legend("topright", pch = "_" , col = c("black", "red", "blue"), legend = names(data)[7:9], bty = "n", xjust = 1)
plot(data$Time, data$Global_reactive_power, type = "l", xlab ="datetime", ylab = "Global_reactive_power")
dev.copy(png, file = "plot4.png")
dev.off()