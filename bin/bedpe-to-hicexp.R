#!/usr/bin/env Rscript
#
# hreyes Feb 2020
# bedpe-to-hicexp.R
#
# Read in bedpe files (with replicates) and generate a hicexp object
#
#
#################### import libraries and set options ####################
library(optparse)
library(dplyr)
library(multiHiCcompare)
#library(magrittr)
#library(purrr)
#
options(scipen = 10)
#
########################## read in data ###################################

# receive STABLE AND THE OTHER make_hicexp ARGUMENTS
# READ IN THE STABLE AS A DATA FRAME AND USE THE COLUMNS TO FILL HIC DATA AND GROUPS
#
# read RDS files into a list
#provide the list to make_hicexp
# does make_hicexp understand the data list names as the groups?

option_list = list(
  make_option(opt_str = c("-s", "--samples"), 
              type = "character",
              default = NULL, 
              help = "A table where the first column is a bedpe file path and the second is its sample name")
)
#
#
######################### build hicexp object #############################
outhicexp <- make_hicexp(b1, b2, b3, b4, 
                       groups = c(0, 0, 1, 1), 
                       zero.p = 0.8, A.min = 5, filter = TRUE,
                       remove.regions = hg38_cyto)

hicexp_40kb_NC2 <- make_hicexp(hic_raw_40kb$`MCF-10A-rep1`, hic_raw_40kb$`MCF-10A-rep2`,
                               hic_raw_40kb$`MCF-7-rep1`, hic_raw_40kb$`MCF-7-rep2`,
                               groups = c(1,1,2,2),
                               zero.p = 0.8, A.min = 5, filter = TRUE,
                               remove.regions = hg38_cyto)

  
# then you save the object with a unique name within R and that's that
save(list = outhicexp, file = out_hicexp_path)
