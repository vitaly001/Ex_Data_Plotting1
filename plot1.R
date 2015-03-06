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
#create  hist plot with Title and x label
hist(data$Global_active_power, col="red", main = 'Global Active Power', xlab= 'Global Active Power (kilowatts)')
#create png file and turn off device
dev.copy(png, file = 'plot1.png')
dev.off()
