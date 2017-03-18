#!/bin/bash
base_dir="$(dirname $(readlink -f "$0"))"/core
all_files=$(find $base_dir -mindepth 1 -name "*")
#echo Detected files:
#echo $all_files
for core_file in $all_files; do
    name_only=$(basename $core_file)
    home_file=~/$name_only
    if [ -e "$home_file" ]; then
        if ! diff -q $home_file $core_file; then
            echo Creating backup$name_only
            mv $home_file ~/backup$name_only
        fi
    fi
    ln -sf $core_file $home_file
done
