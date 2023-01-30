# MACS3  
##  Call Peaks

MACS2 is a peak calling tool generally used on ChIP seq data to identify transcript factor binding sites. MACS3 can be used on ChIP seq data with or without controls.

## Features

- Searches your environment for the alignment files in .bam format.
- Searches your environment for a compare file in .csv format. 
- The compare file must be written with controls,cases. 
- In this exact format. We assume your first entry is the control and second is the case. 
- If you do not provide a compare file, the tool assumes you have no comparisons and will proceed with peak calling devoid of comparisons.

## Installation

The latest version of MACS has been downloaded via apt-get and pip3. You do not have to install anything else. Please see to the Environment for the exact version being used in this Capsule.

## Usage

When supplied with alignement file in .bam format and compare sheet. This tool will perform peak calling with or without comparisons. From the App Panel you can make choice of popular genomes depending on your projects species, auto detection of file formats, q value, and extension size, if desired. 

Please take note! This capsule is specifically working with bam files, only. 

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