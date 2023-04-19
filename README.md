[![Code Ocean Logo](images/CO_logo_135x72.png)](http://codeocean.com/product)

<hr>

# MACS3 PeakCalling

MACS3 is a peak calling tool for ChIP-Seq data to identify transcript factor binding sites. This capsule works with .bam, .bed, .bed.gz, and .bam.gz inputs.

When supplied with alignment files and compare sheet, this tool will perform peak calling with comparisons. 

## Input
Searches **data** folder .bam\* or .bed\* files.

## Naming Convention

This capsule requires alignment files in a specific format. For example:

- sampleA_Rep1.bam
- sampleA_Rep2.bam
- sampleA_Rep3.bam
- sampleA_Rep4.bam

We are assuming the final "_ " precedes a replicate marker ending with positive integer.

## App Panel Parameters 

Genome 
- Mappable genome size or effective genome size. Defined as the genome size which can be sequenced. Because of the repetitive features, actual mappable genome size will be smaller than the original size, about 90% or 70% of the genome size. The default hs -- 2.7e9 is recommended for human genome. Here are all precompiled parameters for effective genome size:

    - hs: 2.7e9

    - mm: 1.87e9

    - ce: 9e7

    - dm: 1.2e8

Format
- Data format for the input files. "AUTO" will autodetect. 
    - If your alignments are from PAIRED-END data you MUST select BAMPE or BEDPE to alert MACS that you are working with paired end data, respectively.
    - You can mix .bed and .bam (can be compressed in .gz format) for inputs. You must select AUTO in order for this to work!
    - Please take note! BEDPE is NOT the same as bedtools format.  


Q Value
- The q-value (minimum FDR) cutoff to call significant regions. Default is 0.05. For broad marks, you can try 0.05 as the cutoff. Q-values are calculated from p-values using the Benjamini-Hochberg procedure.

Compare Sheet
- Compare format MUST be like so - control,case. 
    - Use file prefix to identify control and case samples. For example, hypoxia_test_rep1.bam would use file prefix hypoxia_test. 
    - Each line in compare file will have paired control and case bams, i.e., “hypoxia_control,hypoxia_test” 
    - If you do not provide a compare file, the tool assumes all provided files are ChIP data.

Include Model
-   Wether or not to build the shifting model.
    - If you have less than 100 peaks this parameter is needed to process your sequencing files.

Extension Size
-   The arbitrary extension size in bp. When Include Model is true, MACS will use this value as fragment size to extend each read towards 3' end, then pile them up.

Tag Size
-   Tag size/read length. This will override the auto detected tag size. 

Including Trackline
-   Tells MACS to include trackline with bedGraph files. To include this trackline while displaying bedGraph at UCSC genome browser, can show name and description of the file as well. 

Saving Signal per Million Reads
-   If True, MACS will SAVE signal per million reads for fragment pileup profiles. It won't interfere with computing pvalue/qvalue during peak calling, since internally MACS3 keeps using the raw pileup and scaling factors between larger and smaller dataset to calculate statistics measurements. If you plan to use the signal output in bedGraph to call peaks using bdgcmp and bdgpeakcall, you shouldn't use this option because you will end up with different results. However, this option is recommended for displaying normalized pileup tracks across many datasets.

Shift Reads
-   The arbitrary shift in bp. Use discretion while setting it other than default value. When NOMODEL is set, MACS will use this value to move cutting ends (5') towards 5'->3' direction then apply EXTSIZE to extend them to fragments. When this value is negative, ends will be moved toward 3'->5' direction. 

Band Width
-   Band width for picking regions to compute fragment size. This value is only used while building the shifting model.

Minimum Fragment Size in Basepair
-   Minimum fragment size in basepair. Any predicted fragment size less than this will be excluded.

Fix Bimodal 
-   

## Output

*  _peaks.narrowPeak : BED6+4 format file which contains the peak locations together with peak summit, p-value, and q-value. 

* _peaks.xls : a tabular file which contains information about called peaks.

* _summits.bed : BED format, which contains the peak summits locations for every peak. The 5th column in this file is the same as what is in the narrowPeak file. If you want to find the motifs at the binding sites, this file is recommended.

* _model.r : an R script which you can use to produce a PDF image of the model based on your data. Load it to R by:
    - $ Rscript NAME_model.r
    - If no peaks are found, the model will not be built and errors will instruct you how to correct it. 

## Source

https://github.com/macs3-project/MACS

<hr>

[Code Ocean](https://codeocean.com/) is a cloud-based computational platform that aims to make it easy for researchers to share, discover, and run code.<br /><br />
[![Code Ocean Logo](images/CO_logo_68x36.png)](https://www.codeocean.com)