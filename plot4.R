# Ben de Haan - Exploratory Data Analysis, Coursera

# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

# Initialize ggplot2 library
library(ggplot2)

# Download data
if(!file.exists("FNEI_data.zip")){
    download.file(
        url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", 
        destfile =   "FNEI_data.zip", 
        method = "curl")
}

# Unzip the data
if(!file.exists("Source_Classification_Code.rds")){
    unzip("FNEI_data.zip")    
}

# Read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Create vector for coal related emissions
SCC$isCoalRelated <- (grepl("..Coal", SCC$EI.Sector, ignore.case = TRUE) | 
    grepl("Coal..", SCC$EI.Sector, ignore.case = TRUE) | 
    grepl("..Coal", SCC$EI.Sector, ignore.case = TRUE))

# Merge the two dataframes
NEI.SCC <- merge(NEI, SCC)

# Select coal related emissions
coalCumbustionEmissions <- NEI.SCC[isCoalRelated,]

# Aggregate total United States emissions from coal combustion related sources per year
UnitedStatesCoalCombustionEmissionsPerYear <- aggregate(Emissions ~ year, 
                                                        data = coalCumbustionEmissions, 
                                                        sum)

# Generate graph on screen
qplot(year, 
      Emissions, 
      main = "Total United States PM2.5 coal combustion related emission per year",
      xlab = "Year",
      ylab = "Total PM2.5 emission in tons",
      data = UnitedStatesCoalCombustionEmissionsPerYear,
      geom = "line")


# Generate PNG
png("plot4.png")

# Generate graph
qplot(year, 
       Emissions, 
       main = "Total United States PM2.5 coal combustion related emission per year",
       xlab = "Year",
       ylab = "Total PM2.5 emission in tons",
       data = UnitedStatesCoalCombustionEmissionsPerYear,
       geom = "line")

dev.off()
