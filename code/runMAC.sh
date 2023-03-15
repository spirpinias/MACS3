#!/usr/bin/env bash

source ./config.sh
source ./utils.sh

# Search for the Alignment Files
bam_files=$(find -L ../data -name "*.bed*" -o -name "*.bam" -o -name "*.bam.gz" -o -name "*.bed.gz")
bam_count=$(echo $bam_files | wc -w)

# Compare Sheet
compare_sheet=${compare_sheet}
compare_sheet_count=$(echo $compare_sheet | wc -w)
delim_compare_count=$(cat $compare_sheet | grep -c ",")

if [ "$compare_sheet_count" -eq 1 ]; 
then

    echo "Compare Sheet Found!"
    
    if [ "$delim_compare_count" -gt 0 ] ;
    then
        
        echo "Compare Sheet Contains Comparisons!"

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

            macs3 callpeak -t ${case_file} -c ${control_file} -f ${format} -g "${genome}" -n "${control}vs${case}" --outdir ../results/"${control}vs${case}" --qvalue ${q_val}        
        done        
    else
        echo "Compare Sheet was Empty!"
    fi

else

    if [ "$bam_count" -gt 0 ];
    then
        echo "No Comparison File Found! Assuming only ChIP Seq"
        condGroup=$(echo $bam_files| xargs basename -a | sed 's/_[^_]*$//g' | sort | uniq)
        for line in ${condGroup};
        do 
            echo "${line} is being Processed"
            no_control=$(echo $bam_files | tr ' ' '\n' | grep -i ''${line}'')
            macs3 callpeak -t ${no_control} -f ${format} -g "${genome}" -n "${line}" --outdir ../results/"${line}" --qvalue ${q_val} --nomodel
        done
    fi
fi