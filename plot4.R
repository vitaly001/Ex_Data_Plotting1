#Read text file into data frame and convert "?" to NA 
data_full <- read.csv("household_power_consumption.txt", header = T, sep = ';', 
                      +                       na.strings = "?", nrows = 2075259, check.names = F, 
                      +                       stringsAsFactors = F, comment.char = "", quote = '\"')

#convert Date form characters to date format using as.Date function
data_full$Date <- as.Date(data_full$Date, "%d/%m/%Y")

#subset data for two days
data <- subset(data_full, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

#create character vector with paste function
datetime <- paste(as.Date(data$Date), data$Time)

#convert it to date/time format using as.POSIXct and add to the data as separate column
data$Datetime = as.POSIXct(datetime)

#create  multiple plots in single device
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(data, {
        plot(Global_active_power ~ Datetime, type = "l", ylab = "Global Active Power", xlab = "")
        plot(Voltage ~ Datetime, type = "l", ylab = "Voltage", xlab = "datetime")
        plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering", xlab = "")
        lines(Sub_metering_2 ~ Datetime, col = 'Red')
        lines(Sub_metering_3 ~ Datetime, col = 'Blue')
        legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, bty = "n",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power ~ Datetime, type = "l", ylab = "Global_rective_power", xlab = "datetime")
})

#create png file and turn off device
dev.copy(png, file = 'plot4.png')
dev.off()

