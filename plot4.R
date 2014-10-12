

fileZip<-"exdata_data_household_power_consumption.zip";
fileCSV<-"household_power_consumption.txt";

dt <- read.table(unz(fileZip, fileCSV),  header=T,  sep=";")

dt$Date <- strptime(paste(dt$Date, dt$Time), format= "%d/%m/%Y %H:%M:%S")

dt <- dt[dt$Date$year + 1900 == 2007 & dt$Date$mon + 1 == 2 &  (dt$Date$mday == 1 | dt$Date$mday == 2) ,]

dt$Global_active_power <- as.numeric(as.character(dt$Global_active_power))

dt$Sub_metering_1 <- as.numeric(as.character(dt$Sub_metering_1))
dt$Sub_metering_2 <- as.numeric(as.character(dt$Sub_metering_2))
dt$Sub_metering_3 <- as.numeric(as.character(dt$Sub_metering_3))


dt$Voltage <- as.numeric(as.character(dt$Voltage))
dt$Global_reactive_power <- as.numeric(as.character(dt$Global_reactive_power))

png(file = "plot4.png", width = 480, height = 480, units = "px",bg = "transparent")
par(mfrow = c(2, 2))
#1
plot(dt$Global_active_power, type="l", col="black", xaxt = "n", axes=TRUE,  ylab = "Global Active Power", xlab ="")
xticks <- list(0,60*24,60*24*2)
xlabel <- list("Thu","Fri","Sat")
axis(1, at = xticks  , labels=xlabel)

#2
plot(dt$Voltage, type="l", col="black", xaxt = "n", axes=TRUE,  ylab = "Voltage", xlab ="datetime")
xticks <- list(0,60*24,60*24*2)
xlabel <- list("Thu","Fri","Sat")
axis(1, at = xticks  , labels=xlabel)


#3
plot(dt$Sub_metering_1, type="l", col="black", xaxt = "n", axes=TRUE,  ylab = "Energy sub metering", xlab ="")
lines(dt$Sub_metering_2, type="l", col="red")
lines(dt$Sub_metering_3, type="l", col="blue")

xticks <- list(0,60*24,60*24*2)
xlabel <- list("Thu","Fri","Sat")
axis(1, at = xticks  , labels=xlabel)

legend("topright", col = c("black", "red" , "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3")
       ,lwd=1, lty=1, bty="n")


#4
plot(dt$Global_reactive_power, type="l", col="black", xaxt = "n", axes=TRUE,  ylab = "Global_reactive_power", xlab ="datetime")
xticks <- list(0,60*24,60*24*2)
xlabel <- list("Thu","Fri","Sat")
axis(1, at = xticks  , labels=xlabel)
dev.off()