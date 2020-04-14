#!/usr/bin/bash

stable_directory=$1
stable_full_path=$2

find -L $stable_directory \
	-type f \
	-name "*.bedpe.Rds" \
	-exec sh \
		-c 'echo -n $0,; basename $0 | sed -r "s#-rep.+##"' {} \; \
> $stable_full_path


