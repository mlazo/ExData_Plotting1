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
png("plot3.png", width = 480, height = 480, units = "px")
#Determine the ranges for the three columns I want to plot
yrange<-range(c(subdata$Sub_metering_1, subdata$Sub_metering_2, subdata$Sub_metering_3))
#Create the first line plot
plot(subdata$Date_Time, subdata$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(subdata$Date_Time, subdata$Sub_metering_2, type="l",col="red", ylim=yrange, xlab="", ylab="")
lines(subdata$Date_Time, subdata$Sub_metering_3, type="l",col="blue", ylim=yrange, xlab="", ylab="")
legend("topright", lty=c(1,1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=.9)


# Close the Device
dev.off()