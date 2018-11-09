#!/usr/bin/env Rscript

# Designed to automatically submit an R script
# for literate programming conversion directly
#	using SLURM resource managers

library(knitr)

args <- commandArgs(TRUE)
file_name <- args[1]

knitr::spin(file_name)
