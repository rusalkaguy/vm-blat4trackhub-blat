#!/bin/bash

# test if our blat server is working
echo "========== mktemp ============"
outPsl=$(mktemp --suffix=.psl)
echo "# mktemp=$outPsl"

echo "========== gcClient localhost 17779 ============"
./ucsc_kent/2016-05-10/blat/gfClient -t=dna -q=dna -minScore=5 localhost 17779 hcmv_pub/hh5Merlin2 test.fa $outPsl
echo "========== $outPsl ============"
cat $outPsl
echo "========== diff out.psl test.psl ========="
diff -s $outPsl test.psl

rm $outPsl

