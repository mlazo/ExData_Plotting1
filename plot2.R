#Read in all of the data
alldata <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")

#Extract the subset of data for Feb 1 an Feb 2 2007
subdata <- alldata[as.Date(alldata$Date, format="%d/%m/%Y")>="2007-02-01" & as.Date(alldata$Date, format="%d/%m/%Y")<="2007-02-02",]

#Remove alldata to free up memory
rm(alldata)
##Create a Date_Time field by combining the data from the Date and Time columns, then converting them to dates and times ( "POSIXlt" and "POSIXt")
subdata$Date <- as.Date(subdata$Date, format="%d/%m/%Y")
subdata$Date_Time <- paste(subdata$Date, subdata$Time)

subdata$Date_Time <- strptime(subdata$Date_Time, format= "%Y-%m-%d %H:%M:%S")

#prepare to plot to a png file
png("plot2.png", width = 480, height = 480, units = "px")
#Create the line plot
plot(subdata$Date_Time, subdata$Global_active_power, type="l", xlab="",ylab="Global Active Power (kilowatts)")


# close the device
dev.off()