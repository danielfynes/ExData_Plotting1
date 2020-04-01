# FileName: plot2.R
# Author: Daniel Fynes-Clinton
# Date: 2020-04-01
# Description: This file extracts data from the Electric power consumption dataset and plots the graph plot2.png

setwd("C:\\Users\\RYZEN\\Documents\\R\\Exploratory Data Course\\Week 1 Project")

#Download, unzip and read in data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.csv(unz(temp, "household_power_consumption.txt"),sep=";")
unlink(temp)

#Convert date/time columns and subset data according to date requirements
data$Date<-as.Date(strptime(data$Date, "%d/%m/%Y"))
data <- subset(data,Date>"2007-01-31" & Date<"2007-02-03")

#Convert global active power to numeric
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

#Prepare PNG file, plot line graph
png(file="plot2.png",width=480,height=480)
data$DateTime<-as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")
plot(data$DateTime,data$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off()