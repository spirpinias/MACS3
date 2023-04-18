#!/usr/bin/env bash

set -ex

source ./config.sh
source ./utils.sh

if [ "$compare_sheet_count" -eq 1 ]; 
then

    echo "Compare Sheet Found!"
    delim_compare_count=$(cat $compare_sheet | grep -c ",")

    if [ "$delim_compare_count" -gt 0 ] ;
    then
        
        echo "Compare Sheet Contains Comparisons!"
        echo "Number of Comparisons : $delim_compare_count" 

        for line in $(cat ${compare_sheet}); 
        do

            # Get Control and Case 
            control=$(echo $line | cut -d "," -f1)
            case=$(echo $line | cut -d "," -f2)

            control_file=$(echo $bam_files | tr ' ' '\n' | grep -i ''${control}'')
            case_file=$(echo $bam_files | tr ' ' '\n' | grep -i ''${case}'')

            control_count=$(echo $control_file | wc -w)
            case_count=$(echo $case_file | wc -w)

            echo "Number of Control Files Found : ${control_count}"
            echo "Number of Case Files Found : ${case_count}" 

            macs3 callpeak \
            -t ${case_file} \
            -c ${control_file} \
            ${format} \
            ${genome} \
            ${q_val} \
            ${no_model} \
            ${ext_size} \
            -n "${control}vs${case}" \
            --outdir ../results/"${control}vs${case}" 
        done        
    else
        echo "Compare Sheet was Empty!"
    fi

else

    if [ "$bam_count" -gt 0 ];
    then
    
        echo "No Comparison File Found! Assuming only ChIP Seq"

        condGroup=$(echo $bam_files| xargs basename -a | sed 's/_[^_]*$//g' | sort | uniq)
        condGroup_count=$(echo $condGroup | wc -w)
        
        echo "Number of Groups Found : $condGroup_count"

        for line in ${condGroup};
        do 
            echo "${line} is being Processed"
            no_control=$(echo $bam_files | tr ' ' '\n' | grep -i ''${line}'')
            macs3 callpeak \
            -t ${no_control} \
            ${format} \
            ${genome} \
            ${q_val} \
            ${no_model} \
            ${ext_size} \
            -n "${line}" \
            --outdir ../results/"${line}"           
        done
    fi
fi