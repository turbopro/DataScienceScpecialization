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
png(file = "plot2.png")
plot(d$Date_Time,
     d$Global_active_power,
     type= "l",
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off()
