#!/usr/bin/env Rscript
#
# hreyes Apr 2020
# bedpe-to-hicexp.R
#
# Read in bedpe files (with replicates) and generate a hicexp object
#
#
#################### import libraries and set options ####################
suppressMessages(library(optparse))
suppressMessages(library(multiHiCcompare))
#
options(scipen = 10)
#
########################## read in data ###################################
option_list = list(
  make_option(opt_str = c("-s", "--stable"), 
              type = "character",
              help = "Input stable: plain text file where the first column specifies a .bedpe.Rds file route and the second column specifies a sample group"),
  make_option(opt_str = c("-z", "--zeroprop"), 
              type = "numeric", 
              default = 0.8, 
              help = "If the proportion of zeroes in a row is <= z the row is filtered out. Default is 0.8"),
  make_option(opt_str = c("-a", "--average"),
              type = "numeric", 
              default = 5, # should it actually be a percentage of the total reads? 
              help = "Minimum average value (for a row). Default is 5"),
  make_option(opt_str = c("-o", "--output"),
              type = "character",
              help = "Output Rds file: hicexp object with more than two Hi-C matrices")
)

opt <- parse_args(OptionParser(option_list=option_list))

if (is.null(opt$stable)){
  print_help(OptionParser(option_list=option_list))
  stop("The stable input file is mandatory.n", call.=FALSE)
}

input.stable <- read.csv(file = opt$stable, header = FALSE, stringsAsFactors = FALSE)
message(paste("\nTable with input files has been read:", opt$stable))

hic.matrices.list <- lapply(input.stable[,1], readRDS)
message("Hi-C matrices in bedpe format have been read.")

hic.matrices.sample <- input.stable[,2]
message("Hi-C sample names have been read.")
#
######################### build hicexp object #############################
outhicexp <- make_hicexp(data_list = hic.matrices.list,
                         groups = hic.matrices.sample,
                         zero.p = opt$zeroprop,
                         A.min = opt$average,
                         filter = TRUE,
                         remove.regions = hg38_cyto)
message("hicexp object has been created.")
# maybe some day code will be added to deal with the mandatory filtering and remove regions.

# save hicexp as Rds
saveRDS(outhicexp, file = opt$output)
message(paste("hicexp object has been saved as Rds file:", opt$output, "\n"))

