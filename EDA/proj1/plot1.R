setwd('~/Documents/coursera_ds_r_specialization/EDA/proj1')

data <- read.table(file = 'household_power_consumption.txt', header = TRUE, sep = ';')
head(data)

power <- subset(data, Date == '1/2/2007' | Date == '2/2/2007')
head(power)

hist(as.numeric(power$Global_active_power),
     col = 'red',
     main = 'Global Active Power',
     xlab = 'Global Active Power (kilowatts)')

dev.print(png, 'plot1.png', width = 480, height = 480)
dev.off()
