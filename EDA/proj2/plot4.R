# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# They decreased in general.

setwd('~/Documents/coursera_ds_r_specialization/EDA/proj2')

NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')

head(NEI)
head(SCC)

# get numbering in 'EI.Sector' for coal combustion by finding both 'Comb' and 'Coal',
# numbers are [1, 6, 10] in 'unique(SCC$EI.Sector)' stored in 'both'
unique(SCC$EI.Sector)
comb <- grep('Comb',unique(SCC$EI.Sector))
coal <- grep('Coal',unique(SCC$EI.Sector))
both <- intersect(comb, coal)

# get characters that are at numbering [1, 6, 10] in 'unique(SCC$EI.Sector)'
# stored in 'coal.comb', which are
# "Fuel Comb - Electric Generation - Coal"
# "Fuel Comb - Industrial Boilers, ICEs - Coal"
# "Fuel Comb - Comm/Institutional - Coal"
coal.comb <- unique(SCC$EI.Sector)[both]
coal.comb <- as.character(coal.comb)
coal.comb 

# subset df SCC by EI.Sector == coal.comb to get SCC numbers for later subsetting NEI
coal.comb.SCC <- subset(SCC, EI.Sector %in% coal.comb)
dim(coal.comb.SCC) # 99/11,717 are coal combustion in SCC

# subset df NEI by SCC == coal.comb.SCC$SCC
coal.comb.NEI <- subset(NEI, SCC %in% coal.comb.SCC$SCC)
dim(coal.comb.NEI) # 28,480/6,497,651 are coal combustion in NEI

head(coal.comb.NEI)

p <- tapply(coal.comb.NEI$Emissions, coal.comb.NEI$year, sum)

plot(names(p), p,
     type = 'l',
     xlab = 'Year',
     ylab = 'Emissions',
     main = 'Total Emissions by Coal Combustion per Year')

dev.print(png, 'plot4.png', width = 480, height = 480)
dev.off()