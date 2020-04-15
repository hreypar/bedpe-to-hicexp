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
< config.mk
#
# Run R script to produce hicexp objects.
#
results/%.hicexp.Rds:	data/%.stable
	mkdir -p `dirname $target`
	bin/bedpe-to-hicexp.R \
		--vanilla \
		--stable $prereq \
		--zeroprop $MAXIMUM_ZERO_PROPORTION \
		--average $MINIMUM_AVERAGE \
		--output  $target

# Generate samples table: the script that generates 
# these targets ensures bedpe.Rds files exist
#
'(data\/.+\/)[^/]+\.stable':R:	'\1'
	bin/generate-stable.sh \
		$stem1 \
		$target

