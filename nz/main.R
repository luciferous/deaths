#!/usr/bin/env Rscript
suppressMessages(library(zoo))

path <- commandArgs(trailingOnly=T)[1]
d <- read.csv(path)
d$Date <- as.yearmon(d$parameter)
d.agg <- aggregate(value ~ Date + series_name, d, sum)
d.wide <- reshape(d.agg, timevar="series_name", idvar="Date", direction="wide")
colnames(d.wide) <- sub("value.", "", colnames(d.wide))
write.table(d.wide, sep=",", row.names=F)
