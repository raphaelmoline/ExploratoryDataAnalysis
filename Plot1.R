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