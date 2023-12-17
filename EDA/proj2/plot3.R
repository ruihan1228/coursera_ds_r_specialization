# Of the four types of sources indicated by the type(point, nonpoint, onroad, nonroad)
# variable, which of these four sources have seen decreases in emissions from 1999–2008
# for Baltimore City? Which have seen increases in emissions from 1999–2008?
# Use the ggplot2 plotting system to make a plot answer this question.


# Point have seen increases while the others decreased.

setwd('~/Documents/coursera_ds_r_specialization/EDA/proj2')

NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')

head(NEI)

baltimore <- subset(NEI, fips == '24510')
bt.emis.year.type <- baltimore |>
  group_by(type, year) |>
  summarise(Emissions = sum(Emissions))

ggplot(bt.emis.year.type, aes(x = year, y = Emissions, group = type, color = type)) +
  geom_line() +
  labs(title = 'Total Emission by Year and Type in Baltimore')

dev.print(png, 'plot3.png', width = 480, height = 480)
dev.off()
