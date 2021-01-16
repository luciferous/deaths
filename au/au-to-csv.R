#!/usr/bin/env Rscript

library(readxl)

path <- commandArgs(trailingOnly=T)[1]
sheet <- commandArgs(trailingOnly=T)[2]

if (is.na(sheet)) {
  sheets <- excel_sheets(path)
  print(sheets)
  quit()
}

figures <- read_excel(path, sheet=sheet)
write.table(figures, sep=",", row.names=F, na="")
