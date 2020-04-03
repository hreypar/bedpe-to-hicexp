#!/usr/bin/bash

stable_directory=$1
stable_full_path=$2

find -L $stable_directory \
	-type f \
	-name "*.bedpe.Rds" \
| sort \
> $stable_full_path


