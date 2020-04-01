# FileName: plot4.R
# Author: Daniel Fynes-Clinton
# Date: 2020-04-01
# Description: This file extracts data from the Electric power consumption dataset and plots multiple graphs on plot4.png

setwd("C:\\Users\\RYZEN\\Documents\\R\\Exploratory Data Course\\Week 1 Project")

#Download, unzip and read in data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.csv(unz(temp, "household_power_consumption.txt"),sep=";")
unlink(temp)

#Convert date/time columns and subset data according to date requirements
data$Date<-as.Date(strptime(data$Date, "%d/%m/%Y"))
data <- subset(data,Date>"2007-01-31" & Date<"2007-02-03")

#Convert values to numeric
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
data$Voltage <- as.numeric(as.character(data$Voltage))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))

#Prepare PNG file, plot graphs
png(file="plot4.png",width=480,height=480)
data$DateTime<-as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")
par(mfcol=c(2,2))
plot(data$DateTime,data$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
plot(data$DateTime,data$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
lines(data$DateTime,data$Sub_metering_2,col="red")
lines(data$DateTime,data$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n",cex=1, lty=1.5,col=c("black","blue","red"))
plot(data$DateTime,data$Voltage,type="l",ylab="Voltage",xlab="datetime")
plot(data$DateTime,data$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime")
dev.off()