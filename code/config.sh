#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
else
  echo "args:"
  for i in $*; do 
    echo $i 
  done
  echo ""
fi

# Search for the Alignment Files
bam_files=$(find -L ../data -name "*.bed*" -o -name "*.bam" -o -name "*.bam.gz" -o -name "*.bed.gz")
bam_count=$(echo $bam_files | wc -w)

# MacS3 
if [ -z "${1}" ]; then
    genome=""
else
    genome="-g ${1}"
fi

if [ -z "${2}" ]; then
    format=""
else
    format="-f ${2}"
fi

if [ -z "${3}" ]; then
    q_val=""
else
    q_val="-q ${3}"
fi

if [ -z "${4}" ]; then
    compare_sheet=""
else
    compare_sheet="${4}"
fi

if [ "${5}" = 'True' ]; then
    no_model="--nomodel"
else
    no_model=""
fi

if [ -z "${6}" ]; then
    ext_size=""
else
    ext_size="--extsize ${6}"
fi

if [ -z "${7}" ]; then
    tag_size=""
else
    tag_size="-s ${7}"
fi

if [ "${8}" = 'True' ]; then
    track_line="--trackline"
else
    track_line=""
fi

if [ "${9}" = 'True' ]; then
    save_signal="--SPMR"
else
    save_signal=""
fi
compare_sheet_count=$(echo $compare_sheet | wc -w)