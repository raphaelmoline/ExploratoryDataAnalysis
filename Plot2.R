#plot 2 (data already loaded)
plot(data$Time, data$Global_active_power, type = "l", xlab ="", ylab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot2.png")
dev.off()