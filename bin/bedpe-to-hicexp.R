#!/usr/bin/env Rscript
#
# hreyes Apr 2020
# bedpe-to-hicexp.R
#
# Read in bedpe files (with replicates) and generate a hicexp object
#
#
#################### import libraries and set options ####################
library(optparse)
library(dplyr)
library(multiHiCcompare)
library(GenomicRanges)
#library(magrittr)
#library(purrr)
#
options(scipen = 10)
#
########################## read in data ###################################
option_list = list(
  make_option(opt_str = c("-s", "--stable"), 
              type = "character",
              default = "data/breast-cancer-1mb/breast-cancer-1mb.stable", 
              help = "Input stable: plain text file where the first column specifies a .bedpe.Rds file route and the second column specifies a sample group"),
  make_option(opt_str = c("-z", "--zeroprop"), 
              type = "numeric", 
              default = 0.8, 
              help = "If the proportion of zeroes in a row is <= z the row is filtered out. Default is 0.8"),
  make_option(opt_str = c("-a", "--average"),
              type = "numeric", 
              default = 5, # should it actually be a percentage of the total reads? 
              help = "Minimum average value (for a row). Default is 5"),
  make_option(opt_str = c("-r", "--removeregions"), 
              type = "character", 
              default = "hg38_cyto", 
              help = "GenomicRanges object indicating specific regions to be filtered out. 
              Default is hg38 centromeric, gvar and stalk regions. You can only change it to hg19_cyto"),
  make_option(opt_str = c("-o", "--output"),
              type = "character", 
              default = "results/breast-cancer-1mb/breast-cancer-1mb.hicexp.Rds", 
              help = "Output Rds file: hicexp object with more than two Hi-C matrices")
)

opt <- parse_args(OptionParser(option_list=option_list))

if (is.null(opt$stable)){
  print_help(OptionParser(option_list=option_list))
  stop("The stable input file is mandatory.n", call.=FALSE)
}

input.stable <- read.csv(file = opt$stable, header = FALSE, stringsAsFactors = FALSE)

hic.matrices.list <- lapply(input.stable[,1], readRDS)
hic.matrices.sample <- input.stable[,2]
#
######################### build hicexp object #############################
outhicexp <- make_hicexp(data_list = hic.matrices.list,
                         groups = hic.matrices.sample,
                         zero.p = opt$zeroprop,
                         A.min = opt$average,
                         filter = TRUE,
                         remove.regions = hg38_cyto)
# maybe some day code will be added to deal with the mandatory filtering and remove regions.

# save hicexp as Rds
saveRDS(outhicexp, file = opt$output)
