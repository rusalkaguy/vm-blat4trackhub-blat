SERVER_EXE=ucsc_kent/2016-05-10/blat/gfServer
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

cd hcmv_pub/hh5Merlin2
GENOME=$(basename $PWD)
echo GENOME=$GENOME
GENOME_2BIT=$(find . -name "*.2bit")
echo GENOME_2BIT=$GENOME_2BIT
nohup $ROOTDIR/ucsc_kent/2016-05-10/blat/gfServer start localhost 17777 -trans       -seqLog -ipLog -log=$ROOTDIR/logs/$GENOME.pro.17777.log ${GENOME_2BIT} &
nohup $ROOTDIR/ucsc_kent/2016-05-10/blat/gfServer start localhost 17779 -stepSize=5  -seqLog -ipLog -log=$ROOTDIR/logs/$GENOME.dna.17779.log ${GENOME_2BIT} &
cd ..

cd hcmv_pub/hh5BE_7_2011v1
GENOME=$(basename $PWD)
echo GENOME=$GENOME
GENOME_2BIT=$(find . -name "*.2bit")
echo GENOME_2BIT=$GENOME_2BIT
nohup $ROOTDIR/ucsc_kent/2016-05-10/blat/gfServer start localhost 17781 -trans       -seqLog -ipLog -log=$ROOTDIR/logs/$GENOME.pro.17777.log ${GENOME_2BIT} &
nohup $ROOTDIR/ucsc_kent/2016-05-10/blat/gfServer start localhost 17783 -stepSize=5  -seqLog -ipLog -log=$ROOTDIR/logs/$GENOME.dna.17779.log ${GENOME_2BIT} &
cd ..
