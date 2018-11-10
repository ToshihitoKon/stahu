#!/bin/bash

# $1: flac_cue directory
if [ $# -ne 1 ]; then
    echo "usage: $0 [directory]"
    exit
fi

root_dir=$(pwd)
flac_dir=${root_dir}/../flac

cd $1
for i in $(ls -1); do
	if [ ! -e ${flac_dir}/${1}/${i} ]; then
	    cd $i
        mkdir -p ${flac_dir}/${1}/${i}
	    shnsplit -o 'flac flac' -d ${flac_dir}/${1}/${i} -t '%n-%t' -f *.cue *.flac
	    cuetag.sh *.cue ${flac_dir}/${1}/${i}/*
	    img=$(ls | grep cover)
        if [ -n "$img" ]; then 
	        metaflac --import-picture-from="3||||${img}" ${flac_dir}/${1}/${i}/*
        fi
        cd ${root_dir}/$1
    fi
done
