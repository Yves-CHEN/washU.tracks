#!/bin/bash - 
#===============================================================================
#
#          FILE: dl.sh
# 
#         USAGE: ./dl.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 15/11/23 09:59
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

function convert()
{
    [[ ! -f bedToBigBed ]] &&  wget http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/bedToBigBed && chmod +x bedToBigBed
    [[ ! -f hg19.chrom.sizes ]] && wget https://genome.ucsc.edu/goldenPath/help/hg19.chrom.sizes

    gzfile=$1
    prefix=`basename $gzfile .tsv.gz`
    zcat $gzfile  | awk '{if($6>1000)$6=1000;print $1,$2,$3,$4,$6,$7}' > ${prefix}.6col.tsv
    ./bedToBigBed ${prefix}.6col.tsv hg19.chrom.sizes  ${prefix}.bb
}


## # CTCF core motif
## http://expdata.cmmt.ubc.ca/JASPAR/downloads/UCSC_tracks/2022//hg19/MA0139.1.tsv.gz
## # CTCF core motif plus upstream
## http://expdata.cmmt.ubc.ca/JASPAR/downloads/UCSC_tracks/2022//hg19/MA1929.1.tsv.gz
## convert MA0139.1.tsv.gz
#
#
wget https://hgdownload.soe.ucsc.edu/gbdb/hg19/reMap/reMapDensity2022.bw .


