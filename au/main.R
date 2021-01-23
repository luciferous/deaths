#!/usr/bin/env Rscript

library(zoo)

states <- c(
  "New South Wales",
  "Northern Territory and Australian Capital Territory",
  "Queensland",
  "South Australia",
  "Tasmania",
  "Victoria",
  "Western Australia"
)

normalized <- data.frame()

path <- "Doctor certified deaths by week of occurrence, 2015-19.csv"
data <- read.csv(path, header=F)

for (state in states) {
  ix <- which(data$V1 == state)
  rows <- data[(ix+1):(ix+5),]
  rows$V1 <- paste(state, rows$V1, sep=" - ")
  normalized <- rbind(normalized, rows)
}

path <- "Provisional Mortality Statistics, Weekly Dashboard, Jan-Oct 2020 with SDRs.csv"
data <- read.csv(path, header=F)
data <- data[data$V1 %in% paste(states, "2020", sep=" - "),]
if (ncol(data) < ncol(normalized)) data[, (ncol(data)+1):ncol(normalized)] <- NA
normalized <- rbind(normalized, data)

complete <- data.frame()
for (year in 2015:2020) {
  data <- normalized[normalized$V1 %in% paste(states, year, sep=" - "),]
  row.names(data) <- sub(paste(" - ", year, "$", sep=""), "", data$V1)
  data <- subset(data, select=-V1)
  data[] <- lapply(data, as.numeric)

  ym <- if (ncol(data) <= 52) {
    as.yearmon(paste(year, 1:ncol(data), 7), "%Y %U %u")
  } else {
    c(as.yearmon(paste(year, 1:52, 7), "%Y %U %u"),
      as.yearmon(paste(year, 12, sep="-")))
  }
  data <- rbind(data, Date=ym)
  data <- aggregate(. ~ Date, as.data.frame(t(data)), sum)
  data$Date <- as.yearmon(data$Date)
  complete <- rbind(complete, data)
}

complete <- read.zoo(complete)

write.zoo(complete, index.name="Date", sep=",", na="")
