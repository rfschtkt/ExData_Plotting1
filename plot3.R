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

png(file = "plot3.png")
plot(strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S"),
     as.numeric(data$Sub_metering_1),
     type = "n",
     xlab = "",
     ylab = "Energy sub metering")
lines(strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S"),
      as.numeric(data$Sub_metering_1),
      col = "black")
lines(strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S"),
      as.numeric(data$Sub_metering_2),
      col = "red")
lines(strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S"),
      as.numeric(data$Sub_metering_3),
      col = "blue")
legend("topright",
       lty=c(1,1,1),
       col = c("black", "red", "blue"),
       legend = paste("Sub_metering", c("1", "2", "3"), sep="_"))
dev.off()
