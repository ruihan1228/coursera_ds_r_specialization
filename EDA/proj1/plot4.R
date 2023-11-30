setwd('~/Documents/coursera_ds_r_specialization/EDA/proj1')

data <- read.table(file = 'household_power_consumption.txt', header = TRUE, sep = ';')
head(data)

power <- subset(data, Date == '1/2/2007' | Date == '2/2/2007')
power$Date <- as.Date(power$Date, format = '%d/%m/%Y')
power$datetime <- strptime(paste(power$Date, power$Time), format = '%Y-%m-%d %H:%M:%S')
head(power)

par(mfcol = c(2, 2))

# plot 1
plot(power$datetime, power$Global_active_power,
     type='l', xlab = '', ylab = 'Global Active Power (kilowatts)', xaxt = 'n')
axis(1, at = pretty(power$datetime, n = 2), labels = c('Thu', 'Fri', 'Sat'))

# plot 2
plot(power$datetime, power$Sub_metering_1,
     type = 'l', xlab = '', ylab = 'Energy sub metering', xaxt = 'n')
lines(power$datetime, power$Sub_metering_2, col = 'red')
lines(power$datetime, power$Sub_metering_3, col = 'blue')
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, bty = 'n')
axis(1, at = pretty(power$datetime, n = 2), labels = c('Thu', 'Fri', 'Sat'))

# plot 3
plot(power$datetime, power$Voltage,
     type = 'l', xlab = 'datetime', ylab = 'Voltage', xaxt = 'n')
axis(1, at = pretty(power$datetime, n = 2), labels = c('Thu', 'Fri', 'Sat'))

# plot 4
with(power, plot(datetime, Global_reactive_power, type = 'l', xaxt = 'n'))
axis(1, at = pretty(power$datetime, n = 2), labels = c('Thu', 'Fri', 'Sat'))

dev.print(png, 'plot4.png', width = 480, height = 480)
dev.off()
