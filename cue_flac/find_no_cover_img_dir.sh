#!/bin/bash

if [ $# -ne 1 ]; then
    echo "uases \$ ${0} [directory]"
    exit
fi

if [ ! -d ${1} ]; then
    echo "error: ${1} not directory or not found."
    exit
fi

root_dir=$(pwd)
# echo $root_dir

cd ${1}

for i in $(ls -1); do
    cd ${i}
    img=$(ls | grep cover)
    if [ -z "${img}" ]; then
        echo "${1}/${i}"
    fi
    cd ${root_dir}/${1}
done
