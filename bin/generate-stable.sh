#!/usr/bin/bash

stable_directory=$1
stable_full_path=$2

find $stable_directory \
	-type f \
	-name "*.bedpe.Rds" \
> $stable_full_path
