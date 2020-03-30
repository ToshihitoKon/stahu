#!/bin/bash
set -e

if [ $# -ne 1 ]; then
    echo "usage: ${0} [listfile]"
    exit
fi

if [ ! -r ${1} ]; then
    echo "error: couldn't find file or no have read permission."
    exit
fi

cat ${1} | while read LINE || [ -n "${LINE}" ]; do
    data=(`echo ${LINE} | tr ',' ' '`)
    if [ ${#data[*]} -ne 2 ]; then
        echo "error: couldn't parse line\n> ${LINE}"
        continue
    fi
    echo ${data[0]}
    wget --quiet -O .tmp_img "${data[1]}"
    convert .tmp_img -resize '500x>' ${data[0]}/cover.jpg
    
    echo 'sleep 5 seconds'
    sleep 5
done
