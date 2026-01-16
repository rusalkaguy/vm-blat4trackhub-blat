<<<<<<< HEAD
#!/bin/bash
SERVER_EXE=ucsc_kent/2016-05-10/blat/gfServer
=======
SERVER_EXE=ucsc_kent/2025-06-20/blat/gfServer
>>>>>>> 1f5397c05340b9050aef9618486ab2a2f9a1ec92
HUB_URL=https://data.genome.uab.edu/public/ucsc_track_hubs/hcmv_pub
# 
# mirror .2bit files from data.genome.uab.edu
#
# could be improved with something like
#wget -r --no-parent --reject "index.html*" -nH --cut-dirs=3 http://genome.ucsc.edu/goldenPath/help/examples/hubExamples/hubAssembly/plantAraTha1/
# ie wget -q -r --no-parent --reject "index.html*" -nH --cut-dirs=2 https://data.genome.uab.edu/public/ucsc_track_hubs/hcmv_pub/
echo "Pulling genomes from $HUB_URL"
#wget -m $HUB_URL
wget -q -r --no-parent --reject "index.html*" -nH --cut-dirs=2 $HUB_URL/

#
# get blat exe 
#
if [ ! -e ucsc_kent/2016-05-10/blat/gfServer ]; then
	(cd ucsc_kent/2016-05-10 && ./pull.sh)
fi

#
# dir for output logs
#
mkdir -p logs

#
# per https://genome.ucsc.edu/goldenpath/help/hubQuickStartAssembly.html#blat
# start 2 servers - one for translated, one for straight up
#

# hcmv only for now
#GENOMES=$(find data.genome.uab.edu/public/ucsc_track_hubs/hcmv_pub -name "*.2bit")
#for x in $GENOMES; do ln -fs $x . ; done
#GENOMES_2BIT=$(ls *.2bit)
ROOTDIR=$PWD

pushd hcmv_pub/hh5Merlin2
GENOME=$(basename $PWD)
echo GENOME=$GENOME
GENOME_2BIT=$(find . -name "*.2bit")
echo GENOME_2BIT=$GENOME_2BIT
export PORT=17777
echo  $ROOTDIR/ucsc_kent/2016-05-10/blat/gfServer start localhost $PORT -trans       -seqLog -ipLog -log=$ROOTDIR/logs/$GENOME.pro.$PORT.log ${GENOME_2BIT} 
      $ROOTDIR/ucsc_kent/2016-05-10/blat/gfServer start localhost $PORT -trans       -seqLog -ipLog -log=$ROOTDIR/logs/$GENOME.pro.$PORT.log ${GENOME_2BIT} > log1.txt 2>&1 &
export PORT=17779
echo  $ROOTDIR/ucsc_kent/2016-05-10/blat/gfServer start localhost $PORT -stepSize=5  -seqLog -ipLog -log=$ROOTDIR/logs/$GENOME.dna.$PORT.log ${GENOME_2BIT} 
      $ROOTDIR/ucsc_kent/2016-05-10/blat/gfServer start localhost $PORT -stepSize=5  -seqLog -ipLog -log=$ROOTDIR/logs/$GENOME.dna.$PORT.log ${GENOME_2BIT} > log2.txt 2&>1 &
popd

pushd hcmv_pub/hh5BE_7_2011v1
GENOME=$(basename $PWD)
echo GENOME=$GENOME
GENOME_2BIT=$(find . -name "*.2bit")
echo GENOME_2BIT=$GENOME_2BIT
export PORT=17781
echo  $ROOTDIR/ucsc_kent/2016-05-10/blat/gfServer start localhost $PORT -trans       -seqLog -ipLog -log=$ROOTDIR/logs/$GENOME.pro.$PORT.log ${GENOME_2BIT} 
      $ROOTDIR/ucsc_kent/2016-05-10/blat/gfServer start localhost $PORT -trans       -seqLog -ipLog -log=$ROOTDIR/logs/$GENOME.pro.$PORT.log ${GENOME_2BIT} > log3.txt 2&>1 &
export PORT=17783
echo  $ROOTDIR/ucsc_kent/2016-05-10/blat/gfServer start localhost $PORT -stepSize=5  -seqLog -ipLog -log=$ROOTDIR/logs/$GENOME.dna.$PORT.log ${GENOME_2BIT}
      $ROOTDIR/ucsc_kent/2016-05-10/blat/gfServer start localhost $PORT -stepSize=5  -seqLog -ipLog -log=$ROOTDIR/logs/$GENOME.dna.$PORT.log ${GENOME_2BIT} > log4.txt 2&>1  &
popd
