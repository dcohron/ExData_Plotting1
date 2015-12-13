# Project #1
# Plot #2

# open libraries used
library(data.table)
library(dplyr)

# read file, extract rows, create table/data frame for dplyr
file<-"household_power_consumption.txt"
data<- fread(file, sep=";", header=TRUE, na.strings=="?")
day1<- subset(data, Date=="1/2/2007")
day2<- subset(data, Date=="2/2/2007")
days<- rbind(day1, day2)
days<-tbl_df(days)

# force convert Global_active_power to double and add as new column
gap=as.numeric(days$Global_active_power)

# force convert Date to date format
datetime<-as.POSIXct(paste(days$Date, days$Time), format="%d/%m/%Y %H:%M:%S")

# open png device with defining parameters
png(file="plot2.png", width=480, height=480, units="px", res=NA, bg="white")

plot(datetime,
     gap,
     type="l",
     col="black",
     xlab="",
     ylab="Global Active Power (kilowatts)")

dev.off()  ## close the PNG device
