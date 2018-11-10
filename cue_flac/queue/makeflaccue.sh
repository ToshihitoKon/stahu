#!/bin/bash

mkdir ${1}
cd ${1}
cdrdao read-cd --rspeed 48 --with-cddb --cddb-servers "freedbtest.dyndns.org:/~cddb/cddbutf8.cgi" --datafile ${1}.bin ${1}.toc
cueconvert -i toc -o cue ${1}.toc ${1}.tmp
printf "$(cat ${1}.tmp)" | sed -e "s/\.bin/\.flac/g" > ${1}.cue
echo "" >> ${1}.cue
sox -t cdda ${1}.bin ${1}.wav
flac ${1}.wav
rm ${1}.{bin,wav,tmp}

# cue file auto complete
sed -i -f ../freedb.sed ${1}.cue
sed -i -f ../performer.sed ${1}.cue
