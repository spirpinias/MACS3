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
