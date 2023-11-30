setwd('~/Documents/coursera_ds_r_specialization/EDA/proj1')

data <- read.table(file = 'household_power_consumption.txt', header = TRUE, sep = ';')
head(data)

power <- subset(data, Date == '1/2/2007' | Date == '2/2/2007')
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
power$datetime <- strptime(paste(power$Date, power$Time), format = "%Y-%m-%d %H:%M:%S")
head(power)

plot(power$datetime, power$Global_active_power,
     type='l', xlab = '', ylab = 'Global Active Power (kilowatts)', xaxt = 'n')
axis(1, at = pretty(power$datetime, n = 2), labels = c('Thu', 'Fri', 'Sat'))

dev.print(png, 'plot2.png', width = 480, height = 480)
dev.off()
