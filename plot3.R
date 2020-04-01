# FileName: plot3.R
# Author: Daniel Fynes-Clinton
# Date: 2020-04-01
# Description: This file extracts data from the Electric power consumption dataset and plots the graph plot3.png

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
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))

#Prepare PNG file, plot line graph, add 2 more lines,add legend
png(file="plot3.png",width=480,height=480)
data$DateTime<-as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")
plot(data$DateTime,data$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
lines(data$DateTime,data$Sub_metering_2,col="red")
lines(data$DateTime,data$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1,1),col=c("black","blue","red"))
dev.off()