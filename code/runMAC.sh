#!/usr/bin/env bash

source ./config.sh
source ./utils.sh

# Search for the Bam Files
bam_count=$(find -L ../data -name "*.bam" | wc -l)
bam_files=$(find -L ../data -name "*.bam")

# Compare Sheet
compare_sheet=$(find -L ../data -name "*compare_sheet.csv")
compare_sheet_count=$(find -L ../data -name "*compare_sheet.csv" | wc -l)
delim_compare_count=$(cat $compare_sheet | grep -c ",")

if [ "$compare_sheet_count" -eq 1 ]; 
then

    echo "Compare Sheet were Found!"
    
    if [ "$delim_compare_count" -gt 0 ] ;
    then
        
        echo "Compare Sheet Look Good!"

        for line in $(cat ${compare_sheet}); 
        do
        
            # Get Control and Case 
            control=$(echo $line | awk -F, '{print $1}')
            case=$(echo $line | awk -F, '{print $2}')

            control_file=$(find -L ../data -name "*.bam" | grep -i ''${control}'')
            case_file=$(find -L ../data -name "*.bam" | grep -i ''${case}'')

            macs3 callpeak -t ${case_file} -c ${control_file} -f BAM -g "${genome}" -n "${control}vs${case}" --outdir ../results/"${control}vs${case}" --qvalue ${q_val} --nomodel --extsize ${ext_size}        
        done        
    else
        echo "Sample Sheet was Empty!"
    fi
else
    if [ "$bam_count" -gt 0 ];
    then
        echo "No Comparison were Found! Assuming no Controls.."
        condGroup=$(echo $bam_files| xargs basename -a | sed 's/_[^_]*$//g' | sort | uniq)
        for line in ${condGroup};
        do 
            echo "${line} is being Processed"
            no_control=$(find -L ../data -name "*.bam" | grep -i ''${line}'')
            macs3 callpeak -t ${no_control} -f BAM -g "${genome}" -n "${line}" --outdir ../results/"${line}" --qvalue ${q_val} --nomodel --extsize ${ext_size}    
        done
    fi
fi