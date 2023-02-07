# MACS3 PeakCalling

MACS3 is a peak calling tool for ChIP seq data to identify transcript factor binding sites. This capsule works with .bam, .bed, .bed.gz, and .bam.gz inputs.

## Input
Searches **data** folder .bam\*, or .bed\* files.

## Naming Convention

This capsule requires alignment files in a specific format. For example:

- sampleA_Rep1.bam
- sampleA_Rep2.bam
- sampleA_Rep3.bam
- sampleA_Rep4.bam

We are assuming the final "_ " precedes a replicate marker ending with positive integer.

## Parameters 

* Genome : Mappable genome size or effective genome size. Defined as the genome size which can be sequenced. Because of the repetitive features, actual mappable genome size will be smaller than the original size, about 90% or 70% of the genome size. The default hs -- 2.7e9 is recommended for human genome. Here are all precompiled parameters for effective genome size:

hs: 2.7e9
mm: 1.87e9
ce: 9e7
dm: 1.2e8

* Format : Data format for the input files. "AUTO" will autodetect.

* Q Value : The q-value (minimum FDR) cutoff to call significant regions. Default is 0.05. For broad marks, you can try 0.05 as the cutoff. Q-values are calculated from p-values using the Benjamini-Hochberg procedure.

* Compare Sheet : Compare format MUST be like so - control,case.

Use file prefix to identify control and case samples. For example, hypoxia_test_rep1.bam would use file prefix hypoxia_test. 

Each line in compare file will have paired control and case bams, i.e.,
“hypoxia_control,hypoxia_test” 

If you do not provide a compare file, the tool assumes all provided files are ChIP data.

## Usage

When supplied with alignment files and compare sheet. This tool will perform peak calling with comparisons. 

If your alignments are from PAIRED-END data you MUST select BAMPE or BEDPE to alert MACS that you are working with paired end data, respectively.

Please take note! BEDPE is NOT the same as bedtools format.  

If you would like to mix .bed and .bam (can be compressed in .gz format) for inputs. You must select AUTO from the App Panel. 

For instance in the case of comparisons, 

Control = Mixture of .bed and .bam formatted files. 
Chip = Mixture of .bed and .bam formatted files.

or no comparisons.

Chip = Mixture of .bed and .bam formatted files.

## Output

*  _peaks.narrowPeak : BED6+4 format file which contains the peak locations together with peak summit, p-value, and q-value. 

* _peaks.xls : a tabular file which contains information about called peaks.

* _summits.bed : BED format, which contains the peak summits locations for every peak. The 5th column in this file is the same as what is in the narrowPeak file. If you want to find the motifs at the binding sites, this file is recommended.

* _model.r : an R script which you can use to produce a PDF image of the model based on your data. Load it to R by:
    - $ Rscript NAME_model.r

