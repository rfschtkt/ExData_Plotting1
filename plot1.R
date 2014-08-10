url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "exdata_data_household_power_consumption.zip"
if (!file.exists(zipfile)) download.file(url, zipfile, method="curl")
file <- "household_power_consumption.txt"
if (!file.exists(file)) unzip(zipfile)

# TODO: could we read directly from the zipped file?
#       how to select rows during loading?
#       and without being particular about Date formatting?
data <- read.csv(file, sep=";", na.strings="?")
data <- data[as.Date(data$Date, "%d/%m/%Y")==as.Date("2007-02-01") |
             as.Date(data$Date, "%d/%m/%Y")==as.Date("2007-02-02") ,]

png(file = "plot1.png")
hist(as.numeric(data$Global_active_power),
     col="red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()
