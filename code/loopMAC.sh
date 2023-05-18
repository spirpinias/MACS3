#!/bin/bash 

LoopMAC () {

if [ -z "${1}" ]                           
  then
    case="" 
   else
    case="-t ${1}"
fi

if [ -z "${2}" ]                           
  then
    controls="" 
   else
    controls="-c ${2}"
fi

if [ -z "${3}" ]                           
  then
    naming="" 
   else
    naming="-n ${3}
    --outdir ../results/${3}"
fi

  macs3 callpeak \
  ${case} \
  ${controls} \
  -g ${genome} \
  ${format} \
  ${q_val} \
  ${no_model} \
  ${ext_size} \
  ${tag_size} \
  ${track_line} \
  ${save_signal} \
  ${shift_reads} \
  ${band_width} \
  ${minimum_fragment_size} \
  ${fix_bimodel} \
  ${p_value} \
  ${scaling} \
  ${down_sample} \
  ${lambda} \
  ${small_local} \
  ${large_local} \
  ${max_gap_cluster} \
  ${min_peak_length} \
  ${call_broad} \
  ${broad_cutoff} \
  ${cut_off_analysis} \
  ${call_summits} \
  ${filter_peaks_low} \
  ${save_pileup} \
  ${naming}
}