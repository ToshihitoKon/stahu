#!/bin/bash

root_dir=$(pwd)

cd $1/$2
mkdir /mnt/$2
shnsplit -o 'flac flac' -d /mnt/${2} -t '%n-%t' -f *.cue *.flac
cuetag.sh *.cue /mnt/${2}/*
img=$(ls | grep cover)
metaflac --import-picture-from="3||||${img}" /mnt/${2}/*
cd $root_dir
