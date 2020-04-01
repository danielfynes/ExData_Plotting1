# FileName: plot1.R
# Author: Daniel Fynes-Clinton
# Date: 2020-04-01
# Description: This file extracts data from the Electric power consumption dataset and plots the histogram plot1.png

setwd("C:\\Users\\RYZEN\\Documents\\R\\Exploratory Data Course\\Week 1 Project")

#Download, unzip and read in data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.csv(unz(temp, "household_power_consumption.txt"),sep=";")
unlink(temp)

#Convert date/time columns and subset data according to date requirements
data$Date<-as.Date(strptime(data$Date, "%d/%m/%Y"))
data$Time<-strptime(data$Time, "%H:%M:%S")
data <- subset(data,Date>"2007-01-31" & Date<"2007-02-03")

#Convert global active power to numeric
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

#Prepare PNG file, plot histogram
png(file="plot1.png",width=480,height=480)
hist(data$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power")
dev.off()



