#!/usr/bin/env Rscript

Sys.setenv(RSTUDIO_PANDOC="/Applications/RStudio.app/Contents/MacOS/pandoc")

rmarkdown::render("index.Rmd", output_dir="docs")
