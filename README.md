# bedpe-to-hicexp #

Import bedpe matrices of any resolution into R and generate a hicexp object

## About ##

This module requires that you place all the bedpe matrices (in `Rds` format) that will become a single `hicexp` object under the same directory.
It is assumed by the module's scripts that the bedpe files are named `*-rep[0-9]_[0-9].bedpe.Rds` 

Also, it is up to you to know what are you laying in your `hicexp` objects (there are plenty of Hi-C dataset combinations that can be normalized and compared)
