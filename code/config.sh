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
bam_files=$(find -L ../data/PeakCalling -name "*.bed*" -o -name "*.bam" -o -name "*.bam.gz" -o -name "*.bed.gz")
bam_count=$(echo $bam_files | wc -w)


# Compare Sheet
compare_sheet=$(find -L ../data/Compare -name "*.csv")
compare_sheet_count=$(echo $compare_sheet | wc -w)

# MacS3 
if [ -z "${1}" ]; then
    genome=""
else
    genome="${1}"
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

if [ "${4}" = "True" ]; then
    if [ "$compare_sheet_count" -eq 1 ];
    then
        delim_compare_count=$(cat $compare_sheet | grep -c ",")
    else
        echo "Only 1 Compare Sheet Allowed!"
    fi
else
    compare_sheet_count=0
    compare_sheet=""
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

if [ -z "${10}" ]; then
    shift_reads=""
else
    shift_reads="--shift ${10}"
fi

if [ -z "${11}" ]; then
    band_width=""
else
    band_width="--bw ${11}"
fi

if [ -z "${12}" ]; then
    minimum_fragment_size=""
else
    minimum_fragment_size="--d-min ${12}"
fi

if [ "${13}" = 'True' ]; then
    fix_bimodel="--fix-bimodal"
else
    fix_bimodel=""
fi

if [ -z "${14}" ]; then
    p_value=""
else
    p_value="-p ${14}"
fi

if [ "${15}" = 'small' ]; then
    scaling="--scale-to ${15}"
else
    scaling=""
fi

if [ "${16}" = 'True' ]; then
    down_sample="--down-sample"
else
    down_sample=""
fi

if [ "${17}" = 'True' ]; then
    lambda="--nolambda"
else
    lambda=""
fi

if [ -z "${18}" ]; then
    small_local=""
else
    small_local="--slocal ${18}"
fi

if [ -z "${19}" ]; then
    large_local=""
else
    large_local="--llocal ${19}"
fi

if [ -z "${20}" ]; then
    max_gap_cluster=""
else
    max_gap_cluster="--max-gap ${20}"
fi

if [ -z "${21}" ]; then
    min_peak_length=""
else
    min_peak_length="--min-length ${21}"
fi

if [ "${22}" = 'True' ]; then
    call_broad="--broad"
else
    call_broad=""
fi

if [ -z "${23}" ]; then
    broad_cutoff=""
else
    broad_cutoff="--broad-cutoff ${23}"
fi

if [ "${23}" = 'True' ]; then
    cut_off_analysis="--cutoff-analysis"
else
    cut_off_analysis=""
fi

if [ "${25}" = 'True' ]; then
    call_summits="--call-summits"
else
    call_summits=""
fi

if [ -z "${26}" ]; then
    filter_peaks_low=""
else
    filter_peaks_low="--fe-cutoff ${26}"
fi