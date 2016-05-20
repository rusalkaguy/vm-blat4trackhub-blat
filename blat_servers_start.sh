# 
# mirror .2bit files from data.genome.uab.edu
#
wget -m https://data.genome.uab.edu/public/ucsc_track_hubs/hcmv_pub/

#
# per https://genome.ucsc.edu/goldenpath/help/hubQuickStartAssembly.html#blat
# start 2 servers - one for translated, one for straight up

# hcmv only for now
GENOMES=$(find data.genome.uab.edu/public/ucsc_track_hubs/hcmv_pub -name "*.2bit")
nohup ucsc_kent/2016-05-10/blat/gfServer start localhost 17777 -trans -mask ${GENOMES} > logs/gfServer.17777.log &
nohup ucsc_kent/2016-05-10/blat/gfServer start localhost 17779 -stepSize=5  ${GENOMES} > logs/gfServer.17779.log &

