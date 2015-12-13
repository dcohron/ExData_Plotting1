# Project #1
# Plot #1

# open libraries used
library(data.table)
library(dplyr)

# read file, extract rows, create table/data frame for dplyr
file<-"household_power_consumption.txt"
data<- fread(file, sep=";", header=TRUE, na.strings=="?")
day1<- subset(data, Date=="1/2/2007")
day2<- subset(data, Date=="2/2/2007")
days<- rbind(day1, day2)
days2<-tbl_df(days)

# force convert Global_active_power to double and add as new column
days2<-mutate(days2, gap=as.numeric(Global_active_power))

# open png device with defining parameters
png(file="plot1.png", width=480, height=480, units="px", res=NA, bg="white")

# create the histogram with titles and color
with(days2, hist(gap, main="Global Active Power",
                 xlab="Global Active Power (kilowatts)",
                 ylab="Frequency",
                 col="red",
                 freq=TRUE))
  
dev.off()  ## close the PNG device

