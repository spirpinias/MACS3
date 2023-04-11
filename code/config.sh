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
    genome="hs"
else
    genome="${1}"
fi

if [ -z "${2}" ]; then
    format="BAM"
else
    format="${2}"
fi

if [ -z "${3}" ]; then
    q_val="0.05"
else
    q_val="${3}"
fi

if [ -z "${4}" ]; then
    compare_sheet=""
else
    compare_sheet="${4}"
fi

# Compare Sheet
compare_sheet=${compare_sheet}
compare_sheet_count=$(echo $compare_sheet | wc -w)
delim_compare_count=$(cat $compare_sheet | grep -c ",")