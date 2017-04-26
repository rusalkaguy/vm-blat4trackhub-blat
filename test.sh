#!/bin/bash

# test if our blat server is working
echo "========== gcClient localhost 17779 ============"
./ucsc_kent/2016-05-10/blat/gfClient -t=dna -q=dna -minScore=5 localhost 17779 hcmv_pub/hh5Merlin2 test.fa out.psl
echo "========== out.psl ============"
cat out.psl
echo "========== diff out.psl test.psl ========="
diff -s out.psl test.psl

