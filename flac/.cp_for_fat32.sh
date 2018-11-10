#!/bin/bash
#set -x

if [ $# -ne 2 ]; then
    echo "usase: ${0} [original_dir] [copy_to_dir]"
    exit
fi

cd $1
root_dir=$(pwd)
for i in $(find . -maxdepth 1 -type d | sed 's/^\.\///g'); do
    if [ -d ${2}/${i} ]; then
        continue
    fi
    mkdir -p ${2}/${i}

    cd $i

    for j in *.flac; do
        echo ${i}/${j}
        cp "${j}" "${2}/${i}/$(echo ${j} | sed 's/[?<>\\:*|\"]/_/g')"
    done
    cd $root_dir
done
