#!/bin/bash
# set -x

#echo "[WIP]"
#exit

if [ $# -ne 1 ]; then
    echo "usase: ${0} [directory]"
    exit
fi

if [ ! -d ${1} ]; then
    echo "couldn't find directory ${1}"
    exit
fi

root_dir=$(pwd)
flac_dir=${root_dir}/../flac

cd $1
for i in $(ls -1); do
    echo ${i}
    if [ ! -d ${i} ]; then
        echo "skip ${i}"
        cd ${root_dir}/${1}
        continue
    fi
    
    if [ ! -d ${flac_dir}/${1}/${i} ]; then
        echo "no flac direcotry. ${i}"
        cd ${root_dir}/${1}
        continue
    fi
    cd ${i}

    cuetag.sh *.cue ${flac_dir}/${1}/${i}/*.flac
    img=$(ls | grep cover)
    if [ -n "$img" ]; then
        for file in ${flac_dir}/${1}/${i}/*.flac; do
            # [WIP]何故か滅茶苦茶遅いので既に画像が埋め込まれている場合はスキップ
            isexistcover=`metaflac --list "${file}" | grep "Cover (front)"`
            if [ ! -z "${isexistcover}" ]; then
                continue
            fi
	        
            echo ${file}
            metaflac --import-picture-from="3||||${img}" "${file}" &
        done
        wait
    else
        echo "error: image file not found."
    fi

    cd ${root_dir}/${1}

done
