#!/usr/bin/env bash

source ./config.sh
source ./utils.sh

# Search for the Bam Files
bam_count=$(find -L ../data -name "*.bam" | wc -l)

# Compare Sheet
compare_sheet=$(find -L ../data -name "*compare_sheet.csv")
compare_sheet_count=$(find -L ../data -name "*compare_sheet.csv" | wc -l)
delim_compare_count=$(cat $compare_sheet | grep -o "," | wc -l)

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

            control_file=$(find -L ../data -name "${control}"_*ep?.bam)

            case_file=$(find -L ../data -name "${case}"_*ep?.bam)
            
            macs3 callpeak -t ${case_file} -c ${control_file} -f ${format} -g "${genome}" -n "${control}_vs_${case}" --outdir ../results/"${control}_vs_${case}" --qvalue ${q_val} --extsize 147 --nomodel      
        done        
    else
        echo "Sample Sheet was Empty!"
    fi
else
    echo "No Sample Sheet was Found!"
fi