setwd('~/Documents/coursera_ds_r_specialization/EDA/proj1')

data <- read.table(file = 'household_power_consumption.txt', header = TRUE, sep = ';')
head(data)

power <- subset(data, Date == '1/2/2007' | Date == '2/2/2007')
power$Date <- as.Date(power$Date, format = '%d/%m/%Y')
power$datetime <- strptime(paste(power$Date, power$Time), format = '%Y-%m-%d %H:%M:%S')
head(power)

plot(power$datetime, power$Sub_metering_1,
     type = 'l', xlab = '', ylab = 'Energy sub metering', xaxt = 'n')
lines(power$datetime, power$Sub_metering_2, col = 'red')
lines(power$datetime, power$Sub_metering_3, col = 'blue')
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)
axis(1, at = pretty(power$datetime, n = 2), labels = c('Thu', 'Fri', 'Sat'))

dev.print(png, 'plot3.png', width = 480, height = 480)
dev.off()
