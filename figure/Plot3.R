# Project #1
# Plot #3

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

# force convert power columns to double and add as new column
#days2<-mutate(days2, gap=as.numeric(Global_active_power))
days<-mutate(days, sm1=as.numeric(Sub_metering_1))
days<-mutate(days, sm2=as.numeric(Sub_metering_2))
days<-mutate(days, sm3=as.numeric(Sub_metering_3))

# force convert Date to date format
datetime<-as.POSIXct(paste(days$Date, days$Time), format="%d/%m/%Y %H:%M:%S")
days<-mutate(days, date_time=datetime)

# open png device with defining parameters
png(file="plot3.png", width=480, height=480, units="px", res=NA, bg="white")

xrange<- range(days$date_time)
yrange<- range(days$sm1)
graph_lines<-c(days$sm1, days$sm2, days$sm3)
colors<-c("black", "red", "blue")
plot(xrange,
     yrange,
     type="n",
     xlab="",
     ylab="Energy sub metering")

  lines(days$date_time, days$sm1, type="l", col="black")
  lines(days$date_time, days$sm2, type="l", col="red")
  lines(days$date_time, days$sm3, type="l", col="blue")

  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=2.5, col=c("black", "red", "blue"))

dev.off()  ## close the PNG device
