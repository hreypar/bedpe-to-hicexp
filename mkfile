# DESCRIPTION:
# mk module to create a hicexp object
# from bedpe objects 
#
# USAGE:
# Single target execution: `mk <TARGET>` where TARGET is
# any line printed by the script `bin/mk-targets`
#
# Multiple target execution in tandem `bin/mk-targets | xargs mk`
#
# AUTHOR: HRG
#
# Run R script to produce hicexp objects.
#
results/%.hicexp.Rds:	data/%.stable
	mkdir -p `dirname $target`
	bin/generate-hicexp.R \
		--vanilla \
		$prereq \
		$target

# Generate samples table
#
# if the wildcard doesnt work the prereq will change to be only data and the directory
data([A-z0-9_/\-]*)([A-z0-9_]+).stable:R:	data\1*.bedpe.Rds
	bin/generate-stable.sh \
		$stem1 \
		$target

