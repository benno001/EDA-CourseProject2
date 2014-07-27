# Ben de Haan - Exploratory Data Analysis, Coursera

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

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
BaltimoreCityEmissionsPerYear <- aggregate(Emissions ~ year, data = NEI[NEI$fips == "24510",], sum)

# Generate graph on screen
plot(BaltimoreCityEmissionsPerYear$year, 
     BaltimoreCityEmissionsPerYear$Emissions, 
     type = "l",
     main = "Total Baltimore City PM2.5 emission per year",
     xlab = "Year",
     ylab = "Total PM2.5 emission in tons")


# Generate PNG
png("plot2.png")

# Generate graph
plot(BaltimoreCityEmissionsPerYear$year, 
     BaltimoreCityEmissionsPerYear$Emissions, 
     type = "l",
     main = "Total Baltimore City PM2.5 emission per year",
     xlab = "Year",
     ylab = "Total PM2.5 emission in tons")

dev.off()
