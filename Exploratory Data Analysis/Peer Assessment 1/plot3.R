# Downloading, unzipping and importing the data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              temp, method ="curl")
d <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", dec=".",header=T,
                na.strings = "?")
unlink(temp)

# data proprocessing
library("dplyr")
d <- filter(d,Date == "1/2/2007" | Date == "2/2/2007") 
d <- transform(d,Date_Time = strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S"))
Sys.setlocale("LC_TIME", "C") # for english days name


# Making the plot and saving it in png file
png(file = "plot3.png")
plot(d$Date_Time,
     d$Sub_metering_1,
     type= "l",
     xlab = "", 
     ylab = "Energy sub metering")
lines(d$Date_Time, d$Sub_metering_2,col="red")
lines(d$Date_Time, d$Sub_metering_3,col=" blue")
legend("topright",
       pch = "_",
       lty = 7,
       col=c("black","blue","red"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
