fileZip<-"exdata_data_household_power_consumption.zip";
fileCSV<-"household_power_consumption.txt";

dt <- read.table(unz(fileZip, fileCSV),  header=T,  sep=";")

dt$Date <- strptime(paste(dt$Date, dt$Time), format= "%d/%m/%Y %H:%M:%S")

dt <- dt[dt$Date$year + 1900 == 2007 & dt$Date$mon + 1 == 2 &  (dt$Date$mday == 1 | dt$Date$mday == 2) ,]

dt$Global_active_power <- as.numeric(as.character(dt$Global_active_power))

png(file = "plot2.png", width = 480, height = 480, units = "px",bg = "transparent")
plot(dt$Global_active_power, type="l", col="black", xaxt = "n", axes=TRUE,  ylab = "Global Active Power (kilowatts)", xlab ="")
xticks <- list(0,60*24,60*24*2)
xlabel <- list("Thu","Fri","Sat")
axis(1, at = xticks  , labels=xlabel)
dev.off()
