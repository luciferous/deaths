#!/usr/bin/env Rscript

library(plyr)
library(zoo)

### ABS.Stat final historical.
final <- read.csv("DEATHS_MONTHOCCURENCE_17012021043159486.csv")
final <- final[final$MONTHS != "TOT",]
final$Date <- as.yearmon(paste(final$Time, final$MONTHS, sep="-"))
final <- subset(final,
               Measure == "All Deaths" &
                 Sex == "Persons" &
                 Region != "Australia",
               select=c(Date, Region, Value))
final <- reshape(final, idvar="Date", timevar="Region", direction="wide")
names(final) <- sub("Value.", "", names(final))
final.zoo <- read.zoo(final)

# Combine NT and ACT because that's what the provisional data does.
final.zoo$`Northern Territory and Australian Capital Territory` <-
  final.zoo$`Northern Territory` + final.zoo$`Australian Capital Territory`
final.zoo <- subset(final.zoo, select=-c(`Northern Territory`, `Australian Capital Territory`))

### Victoria 2019-2020.
vic <- read.csv("Death Registrations by Month.csv") 
colnames(vic) <- c("Date", "Victoria")
vic.zoo <- read.zoo(vic, drop=F)
time(vic.zoo) <- as.yearmon(time(vic.zoo))
vic.final <- subset(final.zoo, select=Victoria)
final.zoo <- subset(final.zoo, select=-Victoria)
vic.final <- window(vic.final, end=start(vic.zoo) - 1/12)
vic.complete <- c(vic.final, vic.zoo)

### ABS provisional 2020.
path <- "Provisional Mortality Statistics, Weekly Dashboard, Jan-Oct 2020 with SDRs.csv"
data <- read.csv(path, header=F)
rows <- c(
  "New South Wales - 2020",
  "Northern Territory and Australian Capital Territory - 2020",
  "Queensland - 2020",
  "South Australia - 2020",
  "Tasmania - 2020",
  #"Victoria - 2020",
  "Western Australia - 2020"
)

data <- data[data$V1 %in% rows,]
data <- as.data.frame(t(data))
colnames(data) <- sub(" - 2020$", "", data[1,])
data <- data[-1,]
data <- as.data.frame(sapply(as.data.frame(data), as.numeric))
data$Date <- as.yearmon(paste("2020", index(data), "1"), "%Y %U %u")
data <- aggregate(. ~ Date, data, sum)
data.zoo <- read.zoo(data)

complete <- rbind(final.zoo, data.zoo)
complete <- merge(complete, vic.complete)

write.zoo(complete, index.name="Date", sep=",", na="")
