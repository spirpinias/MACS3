# MACS3  
##  Call Peaks

MACS3 is a peak calling tool for ChIP seq data to identify transcript factor binding sites. This capsule works with .bam, .bed, .bed.gz, and .bam.gz inputs.

## Features

- Searches your data folder for the files in aforementioned format.
- Searches your data folder for a compare file in .csv format. 
- Compare format MUST be like so - control,case.
- Use file prefix to identify control and case samples. For example, hypoxia_test_rep1.bam would use file prefix hypoxia_test. 
- Each line in compare file will have paired control and case bams, i.e.,
“hypoxia_control,hypoxia_test” 
- If you do not provide a compare file, the tool assumes all provided files are ChIP data with no comparisons or controls.


## Naming Convention

This capsule requests you name your alignment files in a specific format. 

Please adhere to this example when naming your files. 

sampleA_Rep1.bam
sampleA_Rep2.bam
sampleA_Rep3.bam
sampleA_Rep4.bam

We are assuming the final "_ " precedes a replicate marker ending with positive integer.

## Parameters 

- Genome : It's the mappable genome size or effective genome size which is defined as the genome size which can be sequenced. Because of the repetitive features on the chromosomes, the actual mappable genome size will be smaller than the original size, about 90% or 70% of the genome size. The default hs -- 2.7e9 is recommended for human genome. Here are all precompiled parameters for effective genome size:

hs: 2.7e9
mm: 1.87e9
ce: 9e7
dm: 1.2e8

- Q Value : The q-value (minimum FDR) cutoff to call significant regions. Default is 0.05. For broad marks, you can try 0.05 as the cutoff. Q-values are calculated from p-values using the Benjamini-Hochberg procedure.

- Extension Size : While --nomodel is set, MACS uses this parameter to extend reads in 5'->3' direction to fix-sized fragments. For example, if the size of the binding region for your transcription factor is 200 bp, and you want to bypass the model building by MACS, this parameter can be set as 200. This option is only valid when --nomodel is set or when MACS fails to build model and --fix-bimodal is on.

## Usage

When supplied with alignment file and compare sheet. This tool will perform peak calling with comparisons. 

If your alignments are from PAIRED-END data you MUST select BAMPE or BEDPE to alert MACS that you are working with paired end data, respectively.

Please take note! BEDPE is NOT the same as bedtools format.  

If you would like to mix .bed and .bam (can be compressed in .gz format) for inputs. You must select AUTO from the App Panel. 

For instance in the case of comparisons, 

Control = Mixture of .bed and .bam formatted files. 
Chip = Mixture of .bed and .bam formatted files.

or no comparisons.

Chip = Mixture of .bed and .bam formatted files.

(Tentatively removing this line).
You can make choice of popular genomes depending on your projects species, q value, and extension size, if desired. 


## Output

In your results folder you will find a directory holding .narrowPeak, peaks.xls, and .bed files describing the peaks and locations founding on your genome during analysis. 

## Source

https://github.com/macs3-project/MACS

## License

MIT

**Free Software, Hell Yeah!**

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

   [dill]: <https://github.com/joemccann/dillinger>
   [git-repo-url]: <https://github.com/joemccann/dillinger.git>
   [john gruber]: <http://daringfireball.net>
   [df1]: <http://daringfireball.net/projects/markdown/>
   [markdown-it]: <https://github.com/markdown-it/markdown-it>
   [Ace Editor]: <http://ace.ajax.org>
   [node.js]: <http://nodejs.org>
   [Twitter Bootstrap]: <http://twitter.github.com/bootstrap/>
   [jQuery]: <http://jquery.com>
   [@tjholowaychuk]: <http://twitter.com/tjholowaychuk>
   [express]: <http://expressjs.com>
   [AngularJS]: <http://angularjs.org>
   [Gulp]: <http://gulpjs.com>

   [PlDb]: <https://github.com/joemccann/dillinger/tree/master/plugins/dropbox/README.md>
   [PlGh]: <https://github.com/joemccann/dillinger/tree/master/plugins/github/README.md>
   [PlGd]: <https://github.com/joemccann/dillinger/tree/master/plugins/googledrive/README.md>
   [PlOd]: <https://github.com/joemccann/dillinger/tree/master/plugins/onedrive/README.md>
   [PlMe]: <https://github.com/joemccann/dillinger/tree/master/plugins/medium/README.md>
   [PlGa]: <https://github.com/RahulHP/dillinger/blob/master/plugins/googleanalytics/README.md>