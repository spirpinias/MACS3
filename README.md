[![Code Ocean Logo](images/CO_logo_135x72.png)](http://codeocean.com/product)

<hr>

# MACS3 PeakCalling

MACS3 is a peak calling tool for ChIP-Seq data to identify transcript factor binding sites. This capsule works with .bam, .bed, .bed.gz, and .bam.gz inputs.

When supplied with alignment files and compare sheet, this tool will perform peak calling with comparisons. 

## Input

**Alignment/peak annotation files**

In **data** folder either \*.bam files containing alignments or or \*.bed files containing peak annotations. These can can optionally be paired tumor/control with control sample establishing background peaks. 

If no compare sheet is provided, this capsule assumes the final "_ " precedes a replicate marker.

For example:

- sampleA_Rep1.bam
- sampleA_Rep2.bam
- sampleA_Rep3.bam
- sampleA_Rep4.bam

**Compare Sheet**

Optional .csv formatted file containing tumor/normal information. The first column provides the sample prefix for the control condition, the second column provides the sample prefix for the case condition. No header is necessary. If not specified, this is assumed to be 

## App Panel Parameters 

Genome 
- Mappable genome size or effective genome size. Defined as the genome size which can be sequenced. Because of the repetitive features, actual mappable genome size will be smaller than the original size, about 90% or 70% of the genome size. The default hs -- 2.7e9 is recommended for human genome. Here are all precompiled parameters for effective genome size:

    - hs: 2.7e9

    - mm: 1.87e9

    - ce: 9e7

    - dm: 1.2e8

Format
- Data format for the input files.  
    - If your alignments are from **PAIRED-END** data you **MUST** select **BAMPE** or **BEDPE** (please use MACS randsample to convert your BAM into BAMPE, if you want this format) to alert MACS that you are working with paired end data, respectively.
    - You can mix .BED and .BAM (can be compressed in .gz format) for inputs. You must select **AUTO** in order for this to work!
    - Please take note! BEDPE is **NOT** the same as bedtools format.  


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
-   Whether turn on the auto pair model process. If set, when MACS failed to build paired model, it will use the nomodel settings, the --exsize parameter to extend each tags towards 3' direction.

P Value
-  Pvalue cutoff for peak detection.

Scaling 
-  When set to 'small', scale the larger sample up to the smaller sample. When set to 'larger', scale the smaller sample up to the bigger sample.

Down Sample
-   When set, random sampling method will scale down the bigger sample. By default, MACS uses linear scaling.

Lambda 
-   If True, MACS will use fixed background lambda as local lambda for every peak region. Normally, MACS calculates a dynamic local lambda to reflect the local bias due to the potential chromatin accessibility.

Small Local
-   The small nearby region in basepairs to calculate dynamic lambda. This is used to capture the bias near the peak summit region.

Large Local
-   The large nearby region in basepairs to calculate dynamic lambda. This is used to capture the surround bias.

Maximum Gap Between Clusters
-   Maximum gap between significant sites to cluster them together. 

Minimum Length of Peak
-   Minimum length of a peak.

Call Broad Peak
-   If set, MACS will try to call broad peaks using the --broad-cutoff setting. Please tweak '--broad-cutoff' setting to control the peak calling behavior. At the meantime, either -q or -p cutoff will be used to define regions with 'stronger enrichment' inside of broad peaks. 

Broad Cut Off  
-   Cutoff for broad region. This option is not available unless --broad is set. If -p is set, this is a pvalue cutoff, otherwise, it's a qvalue cutoff. Please note that in broad peakcalling mode, MACS3 uses this setting to control the overall peak calling behavior, then uses -q or -p setting to define regions inside broad region as 'stronger' enrichment.

Cut Off Analysis 
-   While set, MACS3 will analyze number or total length of peaks that can be called by different p-value cutoff then output a summary table to help user decide a better cutoff. 

Call Summits
-   If set, MACS will use a more sophisticated signal processing approach to find subpeak summits in each enriched peak region. 

Filter Peaks with Low-Fold
-  When set, the value will be used as the minimum requirement to filter out peaks with low fold-enrichment. 

## Output

When Broad Peaks is Off,


    *  _peaks.narrowPeak : BED6+4 format file which contains the peak locations together with peak summit, p-value, and q-value. 

    * _peaks.xls : a tabular file which contains information about called peaks.

    * _summits.bed : BED format, which contains the peak summits locations for every peak. The 5th column in this file is the same as what is in the narrowPeak file. If you want to find the motifs at the binding sites, this file is recommended.

    * _model.r : an R script which you can use to produce a PDF image of the model based on your data. Load it to R by:
        - $ Rscript NAME_model.r
        - If no peaks are found, the model will not be built and errors will instruct you how to correct it. 

    *The narrowPeak file contains the entire interval of the peak, the _summits.bed the peak summits so the base with the highest read pipeup.*

When Broad Peaks is On,

    * _model.r : an R script which you can use to produce a PDF image of the model based on your data. Load it to R by:
        - $ Rscript NAME_model.r
        - If no peaks are found, the model will not be built and errors will instruct you how to correct it.

    *  _peaks.broadPeak : BED6+4 format file which contains the peak locations together with peak summit, p-value, and q-value. 

    *  _peaks.gappedPeaks : BED6+4 format file which contains the peak locations together with peak summit, p-value, and q-value.

    * _peaks.xls : a tabular file which contains information about called peaks.

    * _summits.bed : BED format, which contains the peak summits locations for every peak. The 5th column in this file is the same as what is in the narrowPeak file. If you want to find the motifs at the binding sites, this file is recommended.




## Source

https://github.com/macs3-project/MACS

<hr>

[Code Ocean](https://codeocean.com/) is a cloud-based computational platform that aims to make it easy for researchers to share, discover, and run code.<br /><br />
[![Code Ocean Logo](images/CO_logo_68x36.png)](https://www.codeocean.com)