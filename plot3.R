# Ben de Haan - Exploratory Data Analysis, Coursera

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

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

# Aggregate total Baltimore City emissions per year
BaltimoreCityEmissionsPerYear <- aggregate(Emissions ~ year + type, data = NEI[NEI$fips == "24510",], sum)

# Generate graph on screen
qplot(year, 
     Emissions, 
     main = "Total Baltimore City PM2.5 emission per year by type",
     xlab = "Year",
     ylab = "Total PM2.5 emission in tons",
     data = BaltimoreCityEmissionsPerYear,
     color = type,
     geom = "line")


# Generate PNG
png("plot3.png")

# Generate graph
qplot(year, 
      Emissions, 
      main = "Total Baltimore City PM2.5 emission per year by type",
      xlab = "Year",
      ylab = "Total PM2.5 emission in tons",
      data = BaltimoreCityEmissionsPerYear,
      color = type,
      geom = "line")

dev.off()
